`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:08 05/14/2023 
// Design Name: 
// Module Name:    ppu_rendering_FSM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module ppu_rendering_FSM(
    input 	wire clk, // 25MHz 
    input 	wire rst,

    input 	wire background_enabled,
    
	output	wire	ph1_rising,
	output	wire	ph1_falling,
	output	wire	ph2_rising,
	output	wire	ph2_falling,

	// PPU registers inout wire can be used?
	input wire [14:0] 		ppu_nt_addr, // nametable  address
	input wire [11:0] 		ppu_at_addr, // attribute  address
	input wire [13:0] 		ppu_pattern_table_addr, // pattern table address
	output wire				nametable_read_req,
	output wire				attribute_read_req,
	output wire [1:0]		attribute_sel,

	// PPU interface for memory acces
	output wire [17:0] 		ppu_mem_addr,
	input  wire [7:0]		ppu_mem_din, 
	output wire 			ppu_mem_wr_request,
	output wire 			ppu_mem_read_request
    );

localparam END_OF_RENDERING_LINE = 11'd1599;
localparam PRERENDERING_ROW = 9'd261;		
localparam FIRST_RENDERING_ROW = 9'd0;

//ppu background rendering counters
reg [10:0] x_rendercntr;
reg [8:0] y_renderingcntr;
//nes x rendering
always @ (posedge clk)
begin
	if (rst || (x_rendercntr == END_OF_RENDERING_LINE))
		x_rendercntr <= 11'd0;
	else
		x_rendercntr <= x_rendercntr + 11'd1;
end
//original nes y rendering
always @ (posedge clk)
begin
	if (rst)
		y_renderingcntr <= PRERENDERING_ROW;
	else if (x_rendercntr == END_OF_RENDERING_LINE)
		if (y_renderingcntr == PRERENDERING_ROW)
			y_renderingcntr <= 9'd0;
		else 
			y_renderingcntr <= y_renderingcntr + 11'd1;
end

reg oddframe;
// We find odd frames to render
always@(posedge clk)
begin
	if (rst)
		oddframe <= 1'd0;
	else 
		if ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr == END_OF_RENDERING_LINE))
			oddframe <= ~oddframe;
end

//FSM for BG rendering
localparam SLEEP  = 3'b000;
localparam IDLE 	 = 3'b001;
localparam NT 	 = 3'b010;
localparam AT 	 = 3'b011;
localparam BG_LSB = 3'b100;
localparam BG_MSB = 3'b101;
localparam VBLANK = 3'b110;

localparam FIRST_SCANLINE_PIXEL = 11'd127;   			//4*32 	- 1
localparam START_OF_LAST_NT = 11'd1483; 					//(128 + 4*339) - 1 = 1483
localparam END_OF_BG_RENDERING_LINE = 11'd1491;			//(128 + 4*341) - 1 = 1491 
localparam BG_NEXT_STEP_CONDITION = 3'b011;

localparam MEM_READ_START = 3'b111;
localparam MEM_READ_CONTROLL_OFF = 3'b000;
localparam MEM_READ_TAKE = 3'b010;

localparam ODDFRAME_END_OF_FIRST_NT = 11'd131;
localparam ODDFRAME_END_OF_BG_RENDERING_LINE = 11'd1487; //(128 + 4*340) - 1 = 1487

localparam END_OF_VISIBLE_FRAME_ROW = 9'd239;
localparam END_OF_VBLANK_ROW = 9'd260;

localparam START_OF_VBLANK_ROW = 9'd240; 

reg [2:0] bgrender_state;


reg			rd_req_reg;

reg	[17:0]	ppu_addr_reg;

reg			nametable_read_reg;
reg			attribute_read_reg;
reg         bg_lsb_read;
reg      	bg_msb_read;	
//PPU BG rendering state machine with oddframe changes
always @ (posedge clk)
begin
	if (rst)
		bgrender_state <= SLEEP;
	else	
		case (bgrender_state)
			SLEEP: begin
				if ((x_rendercntr == FIRST_SCANLINE_PIXEL) 
					&& ((y_renderingcntr >= START_OF_VBLANK_ROW) && (y_renderingcntr != PRERENDERING_ROW)))
					bgrender_state <= VBLANK;
				else if ((x_rendercntr == FIRST_SCANLINE_PIXEL) && oddframe && (y_renderingcntr == FIRST_RENDERING_ROW))
					begin
					ppu_addr_reg <= {3'd0, ppu_nt_addr};
					rd_req_reg <= 1'b1;

					bgrender_state <= NT;
					end
				else if (x_rendercntr == FIRST_SCANLINE_PIXEL)
					bgrender_state <= IDLE;
				else
					bgrender_state <= SLEEP;
			end
			IDLE: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					bgrender_state <= NT;
					end
				else
					bgrender_state <= IDLE;
			end
			NT: begin
				if ((x_rendercntr == END_OF_BG_RENDERING_LINE) 
				|| ((y_renderingcntr == PRERENDERING_ROW) && oddframe && (x_rendercntr == ODDFRAME_END_OF_BG_RENDERING_LINE)))
					begin
					nametable_read_reg <= 1'b0;

					bgrender_state <= SLEEP;
					end
					// ODDFRAME_END_OF_FIRST_NT is good here because x_rendercntr will always be higher then this just in the first line 
				else if ((x_rendercntr == ODDFRAME_END_OF_FIRST_NT) || (x_rendercntr == START_OF_LAST_NT))
					begin
					// commands get here for NT fetch
					nametable_read_reg <= 1'b0;

					bgrender_state <= NT;
					end
				else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					// commands get here for AT fetch
					nametable_read_reg <= 1'b0;

					bgrender_state <= AT;
					end
				else
					begin
					// commands get here for NT Load
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {3'd0, ppu_nt_addr};
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						nametable_read_reg <= 1'b1;
						
					bgrender_state <= NT;
					end
			end
			AT: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					// commands get here for BG_LSB fetch
					attribute_read_reg <= 1'b0;

					bgrender_state <= BG_LSB;
					end
				else
					begin
					// commands get here for AT Load
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {6'd0, ppu_at_addr};
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							attribute_read_reg <= 1'b1;
						end

					bgrender_state <= AT;
					end
			end
			BG_LSB: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					// commands get here for BG_MSB fetch
					bg_lsb_read <= 1'b0;

					bgrender_state <= BG_MSB;
					end
				else
					begin
					// commands get here for BG_LSB load	
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {4'd0, ppu_pattern_table_addr}; // we have to find out this
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							bg_lsb_read <= 1'b1;
						end


					bgrender_state <= BG_LSB;
					end
			end
			BG_MSB: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					// commands get here for NT fetch
					bg_msb_read <= 1'b0;

					bgrender_state <= NT;
					end
				else
					begin
					// commands get here for BG_MSB load	
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {4'd0, ppu_pattern_table_addr}; // we have to find out this
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							bg_msb_read <= 1'b1;
						end

					bgrender_state <= BG_MSB;	
					end
			end
			VBLANK: begin
				if (x_rendercntr == END_OF_BG_RENDERING_LINE)
					bgrender_state <= SLEEP;
				else
					bgrender_state <= VBLANK;
			end
			default:
				bgrender_state <= IDLE;
		endcase
end

assign attribute_sel = { ppu_nt_addr[6], ppu_nt_addr[1]};

assign ppu_mem_read_request = rd_req_reg; 
assign nametable_read_req = nametable_read_reg;
assign attribute_read_req = attribute_read_reg;
assign ppu_mem_addr = ppu_addr_reg;

//*****************************************************************************
//* Back ground least significant byte                                     	  *
//*****************************************************************************
reg [7:0] bg_lsb_reg;


always @ (posedge clk) 
begin
    if (rst)
        bg_lsb_reg <= 8'd0;
    else
        if (bg_lsb_read)
            bg_lsb_reg <= ppu_mem_din;
end

//*****************************************************************************
//* Back ground most significant byte                                    	  *
//*****************************************************************************
reg [7:0] bg_msb_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_msb_reg <= 8'd0;
    else
        if (bg_msb_read)
            bg_msb_reg <= ppu_mem_din;
end

// SLR


//*****************************************************************************
//* CPU clock generation			                                          *
//*****************************************************************************
reg ph1_rising;
reg ph1_falling;
reg ph2_rising;
reg ph2_falling;

// clock genereation enable
reg		clkgen_cnt_en;

always @ (posedge clk)
begin
	if (rst || bgrender_state == SLEEP) // Is it correct with the (*) in the upper state machine
		clkgen_cnt_en <= 1'b0;
	else // every other option next_state != SLEEP -> working processor
		clkgen_cnt_en <= 1'b1;
end	

//clock generation timer
reg	[3:0]	clkgen_cnt;

always @ (posedge clk)
begin
	if (rst)
		clkgen_cnt <= 4'd0;
	else
		if (clkgen_cnt_en)
			if (clkgen_clk == 4'd11)
				clkgen_cnt <= 4'd0;
			else
				clkgen_cnt <= clkgen_cnt + 4'd1;
end

always @ (posedge clk)
begin
	ph1_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd0);
	ph1_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd5);
	ph2_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd6);
	ph2_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd11);
end

//*****************************************************************************
//* NO BLANK State mavhine and clk gen						            	  *
//*****************************************************************************

reg			rd_req_reg;
reg			rd_req_reg;
reg	[17:0]	ppu_addr_reg;
reg			nametable_read_reg;
reg			attribute_read_reg;	

// BG rendering without oddframe counting withou VBLANK
always @ (posedge clk)
begin
	if (rst)
		bgrender_state <= SLEEP;
	else
		case (bgrender_state)
			SLEEP: begin
				if (x_rendercntr == FIRST_SCANLINE_PIXEL 
				&& (x_rendercntr <= END_OF_VISIBLE_FRAME_ROW || x_rendercntr == PRERENDERING_ROW))
					bgrender_state <= IDLE;
				else
					bgrender_state <= SLEEP;
			end
			IDLE: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					bgrender_state <= NT;
				else
					bgrender_state <= IDLE;
			end
			NT: begin
				if (x_rendercntr == END_OF_BG_RENDERING_LINE)
				begin
					nametable_read_reg <= 1'b0;

					bgrender_state <= SLEEP;
				end
				else if (x_rendercntr == START_OF_LAST_NT)
				begin
					nametable_read_reg <= 1'b0;

					bgrender_state <= NT;
				end
				else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
					nametable_read_reg <= 1'b0;

					bgrender_state <= AT;
				end
				else
				begin
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {3'd0, ppu_nt_addr};
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						nametable_read_reg <= 1'b1;

					bgrender_state <= NT;
				end
			end
			AT: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
					attribute_read_reg <= 1'b0;

					bgrender_state <= BG_LSB;
				end
				else
				begin
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							ppu_addr_reg <= {6'd0, ppu_at_addr};
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							attribute_read_reg <= 1'b1;
						end

					bgrender_state <= AT;
				end
			end
			BG_LSB: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					bgrender_state <= BG_MSB;
				else
					bgrender_state <= BG_LSB;
			end
			BG_MSB: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					bgrender_state <= NT;
				else
					bgrender_state <= BG_MSB;
			end
			default:
				bgrender_state <= IDLE;
		endcase
end

assign attribute_sel = { ppu_nt_addr[6], ppu_nt_addr[1]};

assign ppu_mem_read_request = rd_req_reg; 
assign nametable_read_req = nametable_read_reg; //these go to ppu internak registers
assign attribute_read_req = attribute_read_reg; //
assign ppu_mem_addr = ppu_addr_reg;


// Clock Gen
reg ph1_rising;
reg ph1_falling;
reg ph2_rising;
reg ph2_falling;

reg  clkgen_cnt_en_clr;
wire clkgen_cnt_en_set = (x_rendercntr == (ODDFRAME_END_OF_BG_RENDERING_LINE + 4));

always @(*) 
begin
	if (background_enabled && odd_frame && (y_renderingcntr == PRERENDERING_ROW))
		clkgen_cnt_en_clr <= (x_rendercntr == ODDFRAME_END_OF_BG_RENDERING_LINE);
	else
		clkgen_cnt_en_clr <= 1'b0;	
end

// clock genereation enable
reg		clkgen_cnt_en;

always @ (posedge clk)
begin
	if (rst || (x_rendercntr == END_OF_BG_RENDERING_LINE) || clkgen_cnt_en_clr)
		clkgen_cnt_en <= 1'b0;
	else
		if ((x_rendercntr == FIRST_SCANLINE_PIXEL) || clkgen_cnt_en_set)
			clkgen_cnt_en <= 1'b1;
end	

//clock generation timer
reg	[3:0]	clkgen_cnt;

always @ (posedge clk)
begin
	if (rst)
		clkgen_cnt <= 4'd0;
	else
		if (clkgen_cnt_en)
			if (clkgen_clk == 4'd11)
				clkgen_cnt <= 4'd0;
			else
				clkgen_cnt <= clkgen_cnt + 4'd1;
end

always @ (posedge clk)
begin
	ph1_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd0);
	ph1_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd5);
	ph2_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd6);
	ph2_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd11);
end

endmodule
