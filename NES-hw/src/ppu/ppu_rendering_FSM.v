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
    input wire clk, // 25MHz 
    input wire rst,

    input ppu_en,
    
	output	wire	ph1_rising,
	output	wire	ph1_falling,
	output	wire	ph2_rising,
	output	wire	ph2_falling,

	// PPU registers inout wire can be used?
	inout wire [14:0] 		v, // VRAM address
	inout wire [14:0] 		t, // Temporary VRAM address
	inout wire [2:0] 		x, // Fine x scroll
	inout wire 				w, // first or second toggle

	// PPU interface for memory acess
	output reg  [7:0] 		ppu_data_out, //output 
	input  wire [7:0] 		ppu_data_in,
	output wire [13:0] 		ppu_addr, 
	output wire 			ppu_wr_request,
	output wire 			ppu_read_request
    );

parameter END_OF_RENDERING_LINE = 11'd1599;
parameter PRERENDERING_ROW = 9'd261;
parameter FIRST_RENDERING_ROW = 9'd0;

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
parameter SLEEP  = 3'b000;
parameter IDLE = 3'b001;
parameter NT = 3'b010;
parameter AT = 3'b011;
parameter BG_LSB = 3'b100;
parameter BG_MSB = 3'b101;
parameter VBLANK = 3'b110;

parameter FIRST_SCANLINE_PIXEL = 11'd127;
parameter START_OF_LAST_NT = 11'd1482; 
parameter END_OF_BG_RENDERING_LINE = 11'd1490;
parameter BG_NEXT_STEP_CONDITION = 3'b011;
parameter SRAM_READ_DIN = 3'b111;

parameter ODDFRAME_END_OF_FIRST_NT = 11'd131;
parameter ODDFRAME_END_OF_BG_RENDERING_LINE = 11'd1486;

parameter END_OF_VISIBLE_FRAME_ROW = 9'd239;
parameter END_OF_VBLANK_ROW = 9'd260;

parameter START_OF_VBLANK_ROW = 9'd240; 

// PPU integral registers the addr coming from ppu registers
reg [14:0] 		v_reg; // VRAM address
reg [14:0] 		t_reg; // Temporary VRAM address
reg [2:0] 		x_reg; // Fine x scroll
reg 			w_reg; // first or second toggle

// PPU mem interface registers
reg [7:0] 	ppu_mem_dout_reg;
reg [7:0] 	ppu_mem_din_reg;
reg [13:0] 	ppu_mem_addr_reg;
reg 		ppu_mem_wr_req_reg;
reg 		ppu_mem_read_req_reg;

reg [7:0] 	ppu_name_table_reg;
reg [7:0] 	ppu_attribute_table_reg;


reg [2:0] bgrender_state;
reg [2:0] next_state;

always@(posedge clk)
begin
	if(rst)
		bgrender_state <= SLEEP;
	else
		bgrender_state <= next_state;
end

//PPU BG rendering state machine with oddframe changes
always @ (*)
begin
	case (bgrender_state)
		SLEEP: begin
			if ((x_rendercntr == FIRST_SCANLINE_PIXEL) 
				&& ((y_renderingcntr >= START_OF_VBLANK_ROW) && (y_renderingcntr != PRERENDERING_ROW)))
				next_state <= VBLANK;
			else if ((x_rendercntr == FIRST_SCANLINE_PIXEL) && oddframe && (y_renderingcntr == FIRST_RENDERING_ROW))
				begin
				// commands get here for NT fetch
				ppu_mem_addr_reg <= v_reg;
				ppu_mem_read_req_reg <= 1'b1;
				
				next_state <= NT;
				end
			else if (x_rendercntr == FIRST_SCANLINE_PIXEL)
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
				// commands get here for NT fetch
				
				next_state <= NT;
				end
			else
				next_state <= IDLE;
		end
		NT: begin
			if ((x_rendercntr == END_OF_BG_RENDERING_LINE) 
			|| ((y_renderingcntr == PRERENDERING_ROW) && oddframe && (x_rendercntr == ODDFRAME_END_OF_BG_RENDERING_LINE)))
				next_state <= SLEEP;
				// ODDFRAME_END_OF_FIRST_NT is good here because x_rendercntr will always be higher then this just in the first line 
			else if ((x_rendercntr == ODDFRAME_END_OF_FIRST_NT) || (x_rendercntr == START_OF_LAST_NT))
				begin
				// commands get here for NT fetch


				next_state <= NT;
				end
			else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
				// commands get here for AT fetch


				next_state <= AT;
				end
			else
				begin
				// commands get here for NT Load
				if (x_rendercntr[2:0] == SRAM_READ_DIN)
					begin
						ppu_name_table_reg <= ppu_data_in;
						ppu_mem_read_req_reg <= 1'b0;
					end

				next_state <= NT;
				end
		end
		AT: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
				// commands get here for BG_LSB fetch

				next_state <= BG_LSB;
				end
			else
				begin
				// commands get here for AT Load


				next_state <= AT;
				end
		end
		BG_LSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
				// commands get here for BG_MSB fetch


				next_state <= BG_MSB;
				end
			else
				begin
				// commands get here for BG_LSB load	


				next_state <= BG_LSB;
				end
		end
		BG_MSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				begin
				// commands get here for NT fetch


				next_state <= NT;
				end
			else
				next_state <= BG_MSB;
		end
		VBLANK: begin
			if (x_rendercntr == END_OF_BG_RENDERING_LINE)
				next_state <= SLEEP;
			else
				next_state <= VBLANK;
		end
		default:
			next_state <= IDLE;
	endcase
end

// SLR for 




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

/*
// BG rendering without oddframe counting withou VBLANK
always @ (*)
begin
	case (bgrender_state)
		SLEEP: begin
			if ((x_rendercntr == FIRST_SCANLINE_PIXEL) 
			&& ((y_renderingcntr == PRERENDERING_ROW) || (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW)))
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT: begin
			if (x_rendercntr == END_OF_BG_RENDERING_LINE)
				next_state <= SLEEP;
			else if (x_rendercntr == START_OF_LAST_NT)
				next_state <= NT;
			else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= AT;
			else
				next_state <= NT;
		end
		AT: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_LSB;
			else
				next_state <= AT;
		end
		BG_LSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_MSB;
			else
				next_state <= BG_LSB;
		end
		BG_MSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= BG_MSB;
		end
		default:
			next_state <= 3'bxxx;
	endcase
end
*/


endmodule
