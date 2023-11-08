`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:00:03 10/29/2023
// Design Name:   nes_top
// Module Name:   D:/NESDev/NES-hw/src/nes_top_test.v
// Project Name:  NES-hw
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: nes_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module nes_top_test;

	// Inputs
	reg clk;
	reg rst;
	reg ctrl1_data;
	reg ctrl2_data;

	// Outputs
	wire ctrl1_clk;
	wire ctrl2_clk;
	wire ctrl1_latch;
	wire ctrl2_latch;
	wire tmds_data0_out_p;
	wire tmds_data0_out_n;
	wire tmds_data1_out_p;
	wire tmds_data1_out_n;
	wire tmds_data2_out_p;
	wire tmds_data2_out_n;
	wire tmds_clock_out_p;
	wire tmds_clock_out_n;
//*****************************************************************************
//* PPU                                                                       *
//*****************************************************************************
//cpu
/*
// register interface or interface to cpu
	.slv_mem_addr(cpu_addr[2:0]),      // register interface reg select (#2000-#2007)
	.slv_mem_cs((cpu_addr[15:13] == 3'b001)),       // register interface enable (#2000 - #3FFF just when it is active)
	.slv_mem_rnw(rnw),       // register interface cpu read not write
	.slv_mem_din(cpu_dout),       // register interface data in (cpu data lane)
	.slv_mem_dout(ppu_to_cpu_din),       // register interface data out (cpu data lane)

	// PPU interface for memory access
	.ppu_mem_din(ppu_mem_din),
	.ppu_mem_dout(ppu_mem_dout),
	.ppu_mem_addr(ppu_mem_addr),
	.ppu_mem_wr_request(ppu_mem_wr_request),
*/

wire slv_mem_cs = (cpu_addr[15:13] == 3'b001);
wire [2:0] slv_mem_addr = cpu_addr[2:0];
wire rnw;
wire slv_mem_rnw = rnw;

wire [7:0] cpu_dout;

wire [7:0] slv_mem_din = cpu_dout;
reg [7:0] slv_mem_dout;
wire [7:0] ppu_to_cpu_din = slv_mem_dout;
reg irq;
wire nmi = irq;

wire [7:0]  ppu_mem_din;
reg [7:0]  ppu_mem_dout;
wire [13:0] ppu_mem_addr;
wire        ppu_mem_wr_request;
//wire        ppu_mem_read_request;

//register write enable signals
wire control_wr     = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b000); //CTRL register write #2000
wire render_mask_wr = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b001); //MASK register write #2001
wire oam_addr_wr    = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b011); //OAM read/write address #2003
wire oam_data_wr    = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b100); //OAM data read/write #2004
wire scrolling_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b101); //fine scroll position (two writes: X scroll, Y scroll) #2005
wire vram_addr_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b110); //PPU read/write address (two writes: most significant byte, least significant byte) #2006
wire vram_data_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b111); //PPU data read/write #2007

//Register read enable signals
wire status_rd      = slv_mem_cs & slv_mem_rnw & (slv_mem_addr == 3'b010);
wire oam_data_rd    = slv_mem_cs & slv_mem_rnw & (slv_mem_addr == 3'b100);
wire vram_data_rd   = slv_mem_cs & slv_mem_rnw & (slv_mem_addr == 3'b111);

//*****************************************************************************
//* Second write of 16 bit registers   (scrolling, vram_addr)             	  *
//* W first or second write toggle                                         	  *
//*****************************************************************************
reg second_write;

always @ (posedge clk) 
begin
    if (rst || (status_rd && ph2_falling))
        second_write <= 1'b0;
    else
        if (scrolling_wr || vram_addr_wr)
            second_write <= ~second_write;
end

//*****************************************************************************
//* Controll register write                                               	  *
//*****************************************************************************
reg [4:0] control_reg;

always @ (posedge clk) 
begin
    if (rst)
        control_reg <= 5'b10000;
    else
        if (control_wr)
            control_reg <= {slv_mem_din[7], slv_mem_din[5:2]};   
end

wire vram_address_inc_sel   = control_reg[0]; 	// VRAM address increment per CPU read/write of PPUDATA
                                              	// (0: add 1, going across; 1: add 32, going down)
wire sprite_pattern_sel     = control_reg[1]; 	// Sprite pattern table address for 8x8 sprites
wire background_pattern_sel = control_reg[2]; 	// Background pattern table address (0: $0000; 1: $1000)
wire sprite_size            = control_reg[3]; 	// 0: 8x8 pixels; 1: 8x16 pixels
wire vblank_irq_enable      = control_reg[4]; 	// Generate an NMI at the start of the vertical blanking interval 
                                              	// (0: off; 1: on)

//*****************************************************************************
//* PPU mask register/ controll reg 2                                      	  *
//*****************************************************************************
reg [7:0] render_mask_reg;

always @ (posedge clk) 
begin
    if (rst)
        render_mask_reg <= 8'd0;
    else
        if (render_mask_wr)
            render_mask_reg <= slv_mem_din;    
end

wire monochrome_mode     = render_mask_reg[0]; // Greyscale (0: normal color, 1: produce a greyscale display)
wire background_clipping = render_mask_reg[1]; // 1: Show background in leftmost 8 pixels of screen, 0: Hide
wire sprite_clipping     = render_mask_reg[2]; // 1: Show sprites in leftmost 8 pixels of screen, 0: Hide
wire background_enabled  = render_mask_reg[3];
wire sprite_enabled 	 = render_mask_reg[4];
wire emphasize_r         = render_mask_reg[5];
wire emphasize_g 		 = render_mask_reg[6];
wire emphasize_b 		 = render_mask_reg[7];


wire ppu_enable = background_enabled | sprite_enabled;

//*****************************************************************************
//* PPU status register read                                             	  *
//*****************************************************************************
//Vertical blank flag
reg  [2:0] vblank;
wire [2:0] vblank_set;
wire       vblank_clr;

always @(posedge clk) 
begin
    if (rst || vblank_clr || (status_rd && ph2_falling))
        vblank <= 3'b000;
    else
        if (vblank_set[0]) // with vblank_set[0] we write 001 into vblank
            vblank <= 3'b001;
        else
            if(vblank_set[1] || vblank_set[2])
                vblank <= {vblank[1:0], 1'b0};
end

//Sprite 0 collision flag
reg  sprite0_hit;
wire sprite0_hit_set;

always @ (posedge clk) 
begin
    if (rst || vblank_clr)
        sprite0_hit <= 1'b0;
    else
        if (sprite0_hit_set && (sprite0_hit == 0)) // just one time set
            sprite0_hit <= 1'b1;
end

//Lost sprite flag
reg  lost_sprites;
wire lost_sprites_set;

always @ (posedge clk) 
begin
    if (rst || vblank_clr)
        lost_sprites <= 1'b0;
    else
        if (lost_sprites_set && (lost_sprites == 0))
            lost_sprites <= 1'b1;
end

//Value of the status register.
wire [7:0] status_reg = {|vblank[2:1], sprite0_hit, lost_sprites, 5'd0};

//Driving the interupt flag
reg  interrupt_flag;
wire interrupt_clr;

always @ (posedge clk) 
begin
    if (rst || interrupt_clr || (status_rd && ph2_falling))
        interrupt_flag <= 1'b0;
    else
        if (vblank_set[2] && vblank[1])
            interrupt_flag <= 1'b1;
end

always @ (posedge clk) 
begin
    if (rst)
        irq <= 1'b0;
    else
        irq <= interrupt_flag & vblank_irq_enable; 
end

//*****************************************************************************
//* Fine horizontal scroll (FH) register                                   	  *
//*****************************************************************************
reg [2:0] fh_reg;

always @ (posedge clk) 
begin
    if (rst)
        fh_reg <= 3'b000;
    else
        if (scrolling_wr && (second_write == 0))
            fh_reg <= slv_mem_din[2:0];
end

//*****************************************************************************
//* Horizontal tile index (HT) register                                 	  *
//*****************************************************************************
reg [4:0] ht_reg;

always @(posedge clk) 
begin
    if (rst)
        ht_reg <= 5'd0;
    else
        case ({second_write, vram_addr_wr, scrolling_wr})
            3'b001: ht_reg <= slv_mem_din[7:3];
            3'b110: ht_reg <= slv_mem_din[4:0];
        endcase    
end

//*****************************************************************************
//* Verical tile index (VT) register                                     	  *
//*****************************************************************************
reg  [2:0] vt_reg1;
reg  [1:0] vt_reg2;
wire [4:0] vt_reg = {vt_reg2, vt_reg1};

always @ (posedge clk) 
begin
    if (rst)
        vt_reg1 <= 3'd0;
    else
        case ({second_write, vram_addr_wr, scrolling_wr})
            3'b101: vt_reg1 <= slv_mem_din[5:3];
            3'b110: vt_reg1 <= slv_mem_din[7:5];
        endcase
end

always @ (posedge clk) 
begin
    if (rst)
        vt_reg2 <= 2'd0;
    else
        case ({second_write, vram_addr_wr, scrolling_wr})
            3'b101: vt_reg2 <= slv_mem_din[7:6];
            3'b010: vt_reg2 <= slv_mem_din[1:0];
        endcase
end

//*****************************************************************************
//* Horizontal name table select (H) register                              	  *
//*****************************************************************************
reg h_reg;

always @ (posedge clk) 
begin
    if (rst)
        h_reg <= 0;
    else
        case ({second_write, vram_addr_wr, control_wr})
            3'b001: h_reg <= slv_mem_din[0];
            3'b101: h_reg <= slv_mem_din[0];
            3'b010: h_reg <= slv_mem_din[2];
        endcase    
end

//*****************************************************************************
//* Verical name table select (V) register                              	  *
//*****************************************************************************
reg v_reg;

always @ (posedge clk) 
begin
    if (rst)
        v_reg <= 1'b0;
    else
        case ({second_write, vram_addr_wr, control_wr})
            3'b001: v_reg <= slv_mem_din[1];
            3'b101: v_reg <= slv_mem_din[1];
            3'b010: v_reg <= slv_mem_din[3];
        endcase
end

//*****************************************************************************
//* Fine vertical scroll (FV) register                                    	  *
//*****************************************************************************
reg [2:0] fv_reg;

always @ (posedge clk) 
begin
    if (rst)
        fv_reg <= 3'd0;
    else
        case ({second_write, vram_addr_wr, scrolling_wr})
            3'b101: fv_reg <= slv_mem_din[2:0];
            3'b010: fv_reg <= {1'b0, slv_mem_din[5:4]};
        endcase
end

//*****************************************************************************
//* Tile index register                                                 	  *
//*****************************************************************************
reg [7:0] tile_index_reg;
wire      nametable_read;

always @ (posedge clk) 
begin
    if (rst)
        tile_index_reg <= 8'd0;
    else
        if (nametable_read)
            tile_index_reg <= ppu_mem_din;
end

//*****************************************************************************
//* Tile attribute (palette select) register                              	  *
//*****************************************************************************
reg  [1:0] tile_attr_reg;
wire       attribute_read;
wire [1:0] attribute_sel;

always @ (posedge clk) 
begin
    if (rst)
        tile_attr_reg <= 2'b00;
    else
        if (attribute_read)
            case (attribute_sel)
                2'b00: tile_attr_reg <= ppu_mem_din[1:0];
                2'b01: tile_attr_reg <= ppu_mem_din[3:2];
                2'b10: tile_attr_reg <= ppu_mem_din[5:4];
                2'b11: tile_attr_reg <= ppu_mem_din[7:6];
            endcase     
end

//*****************************************************************************
//* Back ground least significant byte                                     	  *
//*****************************************************************************
reg [7:0] bg_lsb_reg;
wire      bg_lsb_read;


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
//****************************************************************************

localparam START_OF_SHIFT = 11'd131;			//(128 + 4*1) - 1 = 131 (dot 1) shift is maybe bad because >= we need >
localparam END_OF_SHIFT = 11'd1475;				//(128 + 4*337) - 1 = 1475 (dot 336)

reg [7:0] bg_msb_reg;
wire      bg_msb_read;

always @ (posedge clk) 
begin
    if (rst)
        bg_msb_reg <= 8'd0;
    else
        if (bg_msb_read)
            bg_msb_reg <= ppu_mem_din;
		else if ((x_rendercntr[1:0] == 2'b11) 
				&& (x_rendercntr >= START_OF_SHIFT) && (x_rendercntr <= END_OF_SHIFT) && ~(bgrender_state == VBLANK))
					bg_msb_reg <= {bg_msb_reg[6:0], bg_msb_reg[7]};
end

//*****************************************************************************
//* BackGround Rendering FSM						                     	  *
//*****************************************************************************

localparam END_OF_RENDERING_LINE = 11'd1599;
localparam PRERENDERING_ROW = 9'd261;		
localparam FIRST_RENDERING_ROW = 9'd0;

//ppu background rendering counters
reg [10:0] x_rendercntr = 11'b0;
reg [8:0] y_renderingcntr = 9'b0;
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
			y_renderingcntr <= y_renderingcntr + 9'd1;
end

reg oddframe = 1'b0;
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
localparam IDLE   = 3'b001;
localparam NT 	  = 3'b010;
localparam AT 	  = 3'b011;
localparam BG_LSB = 3'b100;
localparam BG_MSB = 3'b101;
localparam VBLANK = 3'b110;

localparam FIRST_SCANLINE_PIXEL = 11'd127;   			//4*32 	- 1
localparam START_OF_LAST_NT = 11'd1483; 				//(128 + 4*339) - 1 = 1483
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
localparam V_BLANK_BEGIN = 9'd241; 

reg [2:0] bgrender_state;


reg			rd_req_reg;

reg	[13:0]	ppu_addr_fetch;

reg			nametable_read_reg;
reg			attribute_read_reg;
reg         bg_lsb_read_reg;
reg      	bg_msb_read_reg;	
//PPU BG rendering state machine with oddframe changes

always @ (posedge clk)
begin
	if (rst)
		bgrender_state <= SLEEP;
	else	
		case (bgrender_state)
			SLEEP: begin
				if ((x_rendercntr == FIRST_SCANLINE_PIXEL) 
					&& ((y_renderingcntr >= START_OF_VBLANK_ROW) && ~(y_renderingcntr == PRERENDERING_ROW)))
					bgrender_state <= VBLANK;
				else if ((x_rendercntr == FIRST_SCANLINE_PIXEL) && oddframe && (y_renderingcntr == FIRST_RENDERING_ROW))
					begin
					ppu_addr_fetch <= ppu_nt_addr;
					rd_req_reg <= 1'b1;

					bgrender_state <= NT;
					end
				else if (x_rendercntr == FIRST_SCANLINE_PIXEL)
					begin
					ppu_addr_fetch <= bg_lsb_addr;

					bgrender_state <= IDLE;
					end
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
							ppu_addr_fetch <= ppu_nt_addr;
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
							ppu_addr_fetch <= ppu_at_addr;
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
					bg_lsb_read_reg <= 1'b0;

					bgrender_state <= BG_MSB;
					end
				else
					begin
					// commands get here for BG_LSB load	
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							if (sprite_read)
								ppu_addr_fetch <= sprite_lsb_addr;
							else
								ppu_addr_fetch <= bg_lsb_addr;
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							bg_lsb_read_reg <= 1'b1;
						end


					bgrender_state <= BG_LSB;
					end
			end
			BG_MSB: begin
				if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
					begin
					// commands get here for NT fetch
					bg_msb_read_reg <= 1'b0;

					bgrender_state <= NT;
					end
				else
					begin
					// commands get here for BG_MSB load	
					if (x_rendercntr[2:0] == MEM_READ_START)
						begin
							if (sprite_read)
								ppu_addr_fetch <= sprite_msb_addr;
							else
								ppu_addr_fetch <= bg_msb_addr; 
							rd_req_reg <= 1'b1;
						end
					else if (x_rendercntr[2:0] == MEM_READ_CONTROLL_OFF)
						rd_req_reg <= 1'b0;
					else if (x_rendercntr[2:0] == MEM_READ_TAKE)
						begin
							bg_msb_read_reg <= 1'b1;
						end

					bgrender_state <= BG_MSB;	
					end
			end
			VBLANK: begin
				if (x_rendercntr == END_OF_BG_RENDERING_LINE)
					bgrender_state <= SLEEP;
				else
					bgrender_state <= VBLANK;
				ppu_addr_fetch <= vram_addr_reg;
			end
			default:
				bgrender_state <= IDLE;
		endcase
end

//localparam VBLANK_CLR_SET = 11'd135;			(128 + 4*2) - 1 = 135

assign attribute_sel = {ppu_nt_addr[6], ppu_nt_addr[1]};
//assign vblank_clr = ((bgrender_state == PRERENDERING_ROW) && (x_rendercntr == VBLANK_CLR_SET));

// vblank set signals
assign vblank_set[0] = (x_rendercntr == (FIRST_SCANLINE_PIXEL +  0)) & (y_renderingcntr == V_BLANK_BEGIN);
assign vblank_set[1] = (x_rendercntr == (FIRST_SCANLINE_PIXEL +  4)) & (y_renderingcntr == V_BLANK_BEGIN);
assign vblank_set[2] = (x_rendercntr == (FIRST_SCANLINE_PIXEL + 12)) & (y_renderingcntr == V_BLANK_BEGIN);

//Indicates the end of the VBLANK period.
assign vblank_clr    = (x_rendercntr == FIRST_SCANLINE_PIXEL +  4) & (y_renderingcntr == PRERENDERING_ROW);
assign interrupt_clr = (x_rendercntr == FIRST_SCANLINE_PIXEL + 12) & (y_renderingcntr == PRERENDERING_ROW);

//(x_rendercntr <= FINE_VERTICAL_CNT_UP) && (x_rendercntr > START_OF_LAST_TWO_FETCH) 
assign ppu_mem_addr = ppu_addr_fetch; // not good yet

//assign ppu_mem_read_request = rd_req_reg; 
assign nametable_read = nametable_read_reg;
assign attribute_read = attribute_read_reg;
assign bg_lsb_read = bg_lsb_read_reg;
assign bg_msb_read = bg_msb_read_reg;

//*****************************************************************************
//* Back ground active pixel out		                                   	  *
//*****************************************************************************
reg [7:0] bg_lsb_buff_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_lsb_buff_reg <= 8'd0;
    else
        if (bg_msb_read)
            bg_lsb_buff_reg <= bg_lsb_reg; // shift reg
		else if ((x_rendercntr[1:0] == 2'b11) 
				&& (x_rendercntr >= START_OF_SHIFT) && (x_rendercntr <= END_OF_SHIFT) && ~(bgrender_state == VBLANK))
					bg_lsb_buff_reg <= {bg_lsb_buff_reg[6:0], bg_lsb_buff_reg[7]};
end

reg [7:0] shr_lsb_render = 8'd0;
wire	  bg_lsb_out;  

always @(posedge clk) 
if ((x_rendercntr[1:0] == 2'b11) 
	&& (x_rendercntr >= START_OF_SHIFT) && (x_rendercntr <= END_OF_SHIFT) && ~(bgrender_state == VBLANK)) //(bgrender_state != IDLE) && (bgrender_state != VBLANK) && (bgrender_state != SLEEP)
		shr_lsb_render <= {shr_lsb_render[6:0], bg_lsb_buff_reg[7]};

assign bg_lsb_out = shr_lsb_render[~fh_reg];

reg [7:0] shr_msbrender = 8'd0;
wire	  bg_msb_out;  

always @(posedge clk) 
if ((x_rendercntr[1:0] == 2'b11) 
	&& (x_rendercntr >= START_OF_SHIFT) && (x_rendercntr <= END_OF_SHIFT) && ~(bgrender_state == VBLANK))
		shr_msbrender <= {shr_msbrender[6:0], bg_msb_reg[7]};

assign bg_msb_out = shr_msbrender[~fh_reg];
//*****************************************************************************
//* Addr make										                     	  *
//*****************************************************************************
/*
wire [13:0] ppu_nt_addr;
wire [13:0] ppu_at_addr;
wire [13:0] bg_lsb_addr;
wire [13:0] bg_msb_addr;

//Horizontal tile index (HT) counter 
reg	 [4:0]  ht_cntr;

localparam H_COPY = 11'd1159;						//(128 + 4*258) - 1 = 1159 (dot 257)
localparam FINE_VERTICAL_CNT_UP = 11'd1155;			//(128 + 4*257) - 1 = 1155 (dot 256)
localparam START_OF_LAST_TWO_FETCH = 11'd1411;		//(128 + 4*321) - 1 = 1411 (dot 320)

always @(posedge clk) 
begin
	if (rst)
		ht_cntr <= 5'd0;
	else
		if (second_write && vram_addr_wr) 
			ht_cntr <= slv_mem_din[4:0];
		else if (~(bgrender_state == VBLANK) && (x_rendercntr == H_COPY))
			ht_cntr <= ht_reg;
		// changing the cnt up range we dont do cnt up in the reagion between 257 and 320
		else if (((bgrender_state == BG_MSB) && (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION) && ((x_rendercntr <= FINE_VERTICAL_CNT_UP) || (x_rendercntr > START_OF_LAST_TWO_FETCH))) 
					|| ((vram_addr_wr || vram_data_rd ) && ~(bgrender_state == VBLANK) && ppu_enable))
						ht_cntr <= ht_cntr + 5'd1;
end

// Verical tile index (VT) counter
reg  [2:0] vt_cntr1;
reg  [1:0] vt_cntr2;
wire [4:0] vt_cntr = {vt_cntr2, vt_cntr1};

localparam START_OF_V_COPY = 11'd1251;	//(128 + 4*281) - 1 = 1251 (dot 280)
localparam END_OF_V_COPY = 11'd1347;	//(128 + 4*305) - 1 = 1347 (dot 304)

always @(posedge clk) 
begin
	if (rst)
		vt_cntr1 <= 3'd0;
	else
		if (second_write && vram_addr_wr)
			vt_cntr1 <= slv_mem_din[7:5];
		else if ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && ppu_enable)
			vt_cntr1 <= vt_reg1;
		else if ((fv_cntr == 3'b111)
				|| ((vram_addr_wr || vram_data_rd) && (bgrender_state == VBLANK) && (vram_address_inc_sel)))
					vt_cntr1 <= vt_cntr1 + 3'd1;
end

always @(posedge clk) 
begin
	if (rst)
		vt_cntr2 <= 2'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && ppu_enable))
				vt_cntr2 <= vt_reg2; // hopefully good with timing
		else if (vt_cntr1 == 3'b111)
			vt_cntr2 <= vt_cntr2 + 2'd1;
end

// Horizontal name table select (H) counter 
reg h_sel_cntr;

always @(posedge clk) 
begin
	if (rst)
		h_sel_cntr <= 1'd0;
	else
		if ((second_write && vram_addr_wr)
			|| (~(bgrender_state == VBLANK) && (x_rendercntr == H_COPY)))
					h_sel_cntr <= h_reg; // hopefully good with timing
		else if (ht_cntr == 5'd31)
			h_sel_cntr <= ~h_sel_cntr;
end

// Verical name table select (V) counter 
reg v_sel_cntr;

always @(posedge clk) 
begin
	if (rst)
		v_sel_cntr <= 1'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && ppu_enable))
				v_sel_cntr <= v_reg; // hopefully good with timing
		else if (vt_cntr2 == 2'b11)
			v_sel_cntr <= ~v_sel_cntr;
end

//Fine vertical scroll (FV) counter
reg [2:0] fv_cntr; 

always @(posedge clk) 
begin
	if (rst)
		fv_cntr <= 3'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && ppu_enable))
				fv_cntr <= fv_reg; 
		else if (((bgrender_state == BG_MSB) && (x_rendercntr == FINE_VERTICAL_CNT_UP))
				|| (( vram_addr_wr || vram_data_rd ) && ~(bgrender_state == VBLANK) && ppu_enable)
				|| ((vram_addr_wr || vram_data_rd) && (bgrender_state == VBLANK) && (~vram_address_inc_sel)))
					fv_cntr <= fv_cntr + 3'd1;
end

// name_table addr
assign ppu_nt_addr = {fv_cntr[1:0], v_sel_cntr, h_sel_cntr, vt_cntr, ht_cntr};
assign ppu_at_addr = {2'b00, v_sel_cntr, h_sel_cntr, 4'b1111, vt_cntr[4:2], ht_cntr[4:2]}; // 3 zero for the same address size
assign bg_lsb_addr = {1'b0, background_pattern_sel, tile_index_reg, 1'b0, fv_cntr}; //one extra 0 for tha same address size
assign bg_msb_addr = {1'b0, background_pattern_sel, tile_index_reg, 1'b1, fv_cntr}; //one extra 0 for tha same address size
*/

reg vram_addr_second_wr;

always @(posedge clk) 
begin
	if (rst)
		vram_addr_second_wr <= 1'b0;
	else
		vram_addr_second_wr <= vram_addr_wr & second_write;	
end

localparam H_COPY = 11'd1159;						//(128 + 4*258) - 1 = 1159 (dot 257)
localparam FINE_VERTICAL_CNT_UP = 11'd1155;			//(128 + 4*257) - 1 = 1155 (dot 256)
localparam START_OF_LAST_TWO_FETCH = 11'd1411;		//(128 + 4*321) - 1 = 1411 (dot 320)
localparam START_OF_V_COPY = 11'd1251;				//(128 + 4*281) - 1 = 1251 (dot 280)
localparam END_OF_V_COPY = 11'd1347;				//(128 + 4*305) - 1 = 1347 (dot 304)

wire x_cnt_en = ((((bgrender_state == BG_MSB) && (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION))) 
				&& ((x_rendercntr <= FINE_VERTICAL_CNT_UP) || (x_rendercntr > START_OF_LAST_TWO_FETCH)));

wire y_cnt_en = ((bgrender_state == BG_MSB) && (x_rendercntr == FINE_VERTICAL_CNT_UP));

wire x_cnt_ld = ((y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW) || (y_renderingcntr == PRERENDERING_ROW)) 
				&& (x_rendercntr == H_COPY);

wire counters_ld = (y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY);

wire vram_read = rd_req_reg; // nametable_read_reg || attribute_read_reg || bg_lsb_read_reg || bg_msb_read_reg
wire vram_write = vram_data_wr;

//cntrs
reg [5:0] vram_haddr_cnt;
reg [8:0] vram_vaddr_cnt;

wire [4:0] 	ht_cnt 	= vram_haddr_cnt[4:0];
wire [4:0] 	vt_cnt 	= vram_vaddr_cnt[7:3];
wire		h_cnt   = vram_haddr_cnt[5];
wire		v_cnt   = vram_vaddr_cnt[8];
wire [2:0]  fv_cnt  = vram_vaddr_cnt[2:0];

wire [14:0] vram_addr_cnt = {fv_cnt, v_cnt, h_cnt, vt_cnt, ht_cnt};

wire [14:0] new_vram_addr = vram_addr_cnt + ((vram_address_inc_sel) ? 15'd32 : 15'd1);

wire vram_addr_inc = vram_data_wr | (vram_data_rd & ph2_falling);
wire haddr_cnt_ld  = vram_addr_second_wr | vram_addr_inc | x_cnt_ld; //| counters_ld
wire haddr_cnt_en  = x_cnt_en;

reg [5:0] new_haddr;

always @(*) 
begin
	if (vram_addr_inc)
		new_haddr <= {new_vram_addr[10], new_vram_addr[4:0]};
	else
		new_haddr <= {h_reg, ht_reg};
end

always @(posedge clk) 
begin
	if (rst)
		vram_haddr_cnt <= 0;
	else
		if (haddr_cnt_ld)
			vram_haddr_cnt <= new_haddr;
		else
			if (haddr_cnt_en)
				vram_haddr_cnt <= vram_haddr_cnt + 6'd1;
end

wire  vaddr_cnt_ld = vram_addr_second_wr | counters_ld | vram_addr_inc;
wire  vaddr_cnt_en = y_cnt_en;

reg [8:0] new_vaddr;

always @(*) 
begin
	if (vram_addr_inc)
		new_vaddr <= {new_vram_addr[11], new_vram_addr[9:5], new_vram_addr[14:12]};
	else
		new_vaddr <= {v_reg, vt_reg, fv_reg};	
end

always @(posedge clk) 
begin
	if (rst)
		vram_vaddr_cnt <= 0;
	else
		if (vaddr_cnt_ld)
			vram_vaddr_cnt <= new_vaddr;
		else
			if (vaddr_cnt_en)
				if (vram_addr_cnt[7:0] == 8'b11101_111)
					vram_vaddr_cnt <= {~vram_vaddr_cnt[8], 8'd0};
				else
					vram_vaddr_cnt[7:0] <= vram_vaddr_cnt[7:0] + 8'd1;	
end

wire palette_ram_access = (vram_addr_cnt[13:8] == 6'h3F);

reg [13:0] vram_addr_reg;

always @(posedge clk) 
begin
	if (rst)
		vram_addr_reg <= 0;
	else
		if (vram_addr_second_wr)
			vram_addr_reg <= {fv_reg[1:0], v_reg, h_reg, vt_reg, ht_reg};
		else
			if (vram_addr_inc || vram_read || vram_write)
				vram_addr_reg <= vram_addr_cnt[13:0];	
end

assign attribute_sel = {vt_cnt[1], ht_cnt[1]};

wire [13:0] ppu_nt_addr = {2'b10, v_cnt, h_cnt, vt_cnt, ht_cnt};
wire [13:0] ppu_at_addr = {2'b10, v_cnt, h_cnt, 4'b1111, vt_cnt[4:2], ht_cnt[4:2]}; // 3 zero for the same address size
wire [13:0] bg_lsb_addr = {1'b0, background_pattern_sel, tile_index_reg, 1'b0, fv_cnt}; //one extra 0 for tha same address size
wire [13:0] bg_msb_addr = {1'b0, background_pattern_sel, tile_index_reg, 1'b1, fv_cnt};

//*****************************************************************************
//* CPU clock generation			                                          *
//*****************************************************************************
/*
reg ph1_rising;
reg ph1_falling;
reg ph2_rising;
reg ph2_falling;

// clock genereation enable
reg		clkgen_cnt_en;

always @ (posedge clk)
begin
	if (rst || (bgrender_state == SLEEP)) // Is it correct with the (*) in the upper state machine
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
			if (clkgen_cnt == 4'd11)
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
*/

// Clock Gen
reg ph1_rising;
reg ph1_falling;
reg ph2_rising;
reg ph2_falling;

reg  clkgen_cnt_en_clr;
wire clkgen_cnt_en_set = (x_rendercntr == (ODDFRAME_END_OF_BG_RENDERING_LINE + 4));

always @(*) 
begin
	if (background_enabled && oddframe && (y_renderingcntr == PRERENDERING_ROW))
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
			if (clkgen_cnt == 4'd11)
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
//* sprite rendering part									                  *
//*****************************************************************************
localparam H_FIRST_COLUMN_END = 11'd163;			//(128 + 4*9) - 1 = 163 (dot 8) not 100%

//think over once again START_OF_SHIF and END_OF_SHIFT, <=, >= !!
//FINE_VERTICAL_CNT_UP insted of END_OF_SHIFT
wire next_pixel = ((x_rendercntr[1:0] == 2'b11) && (x_rendercntr > START_OF_SHIFT) 
					&& (x_rendercntr < END_OF_SHIFT) && ~(bgrender_state == VBLANK));

wire sprite_read = ((x_rendercntr > FINE_VERTICAL_CNT_UP) && (x_rendercntr <= START_OF_LAST_TWO_FETCH));

wire first_column = ((x_rendercntr >= FIRST_SCANLINE_PIXEL) && (x_rendercntr <= H_FIRST_COLUMN_END));

reg [7:0]  sprite_tile_index;
reg [3:0]  sprite_range;
reg [3:0] 	sprite_pixel;
reg 		sprite_priority;

   	//Data inputs

	//Signals related to the OAM acces
	reg [7:0] oam_dout;
wire [7:0]  oam_read_data  =  oam_dout; //not 100% sure

	//Input control signals
wire bground_enabled = background_enabled; 
 
wire no_sprite_clip = sprite_clipping; 
 // hole first column 1 is now include the idle too
    
 // az idle is bele számolódik?  
wire start_rendering = (y_renderingcntr == END_OF_VBLANK_ROW) && (x_rendercntr == END_OF_RENDERING_LINE); // utolsó pixel a vga  1599, 260 sor
wire scanline_begin = (x_rendercntr == FIRST_SCANLINE_PIXEL);  // 127 idle cycle
wire bgnd_read_end = (x_rendercntr == FINE_VERTICAL_CNT_UP);   // this is actually (dot 256) dot 257
wire pattern0_read = bg_lsb_read_reg;   //helyes adat
wire pattern1_read = bg_msb_read_reg;   
wire bground_read = (x_rendercntr <= FINE_VERTICAL_CNT_UP);  // just the 0-256 reagion is sprite read
   // this is 1 in all sprite read
wire sprite_read_end = (x_rendercntr == START_OF_LAST_TWO_FETCH); // ~(bgrender_state == VBLANK) && (x_rendercntr[2:0] == FINE_VERTICAL_CNT_UP)
wire nes_scanline_end = (x_rendercntr == END_OF_BG_RENDERING_LINE); // 2 NT fetch after
wire rendering_end = ((y_renderingcntr == END_OF_VISIBLE_FRAME_ROW) && (x_rendercntr == END_OF_RENDERING_LINE)); // this is the VBLANK start

    //Output control signals
assign lost_sprites_set = lost_sprite_set;
assign sprite0_hit_set = sprite0_visible; //sprite 0 pixel is visible

    //Output sprite data
  	//sprite tile index
      		//Sprite line index
   		//Sprite pixel color (palette index) 
     	//Priority (0: in front of background; 1: behind background)


//*****************************************************************************
//* counting all the verical rows from pre rendering up to VBLANK             *
//*****************************************************************************
reg [8:0] scanline_cnt = 9'd511;

always @(posedge clk) 
begin
    if (rst || start_rendering)
        scanline_cnt <= 9'd511;
    else
        if (sprite_read_end)
            scanline_cnt <= scanline_cnt + 9'd1;
end

//*****************************************************************************
//* Signals of the even/odd pixels                                            *
//*****************************************************************************
reg [2:0]   pixel_cnt;
wire        pixel_cnt_overflow = (pixel_cnt == 3'b111);

always @(posedge clk) 
begin
    if (rst || scanline_begin)
        pixel_cnt <= 3'd0;
    else
        if (next_pixel)
            pixel_cnt <= pixel_cnt + 3'd1;
end

// rendering enabled
//wire ppu_enable = bground_enabled | sprite_enabled; 

// basically the odd and even pixels rendering its enables the phase signals only for a clk because of next pixel
//even
wire even_phase_en = pixel_cnt[0] & next_pixel & ppu_enable;
//odd
wire odd_phase_en = ~pixel_cnt[0] & next_pixel & ppu_enable;
wire odd_phase    = ~pixel_cnt[0] & next_pixel;

//*****************************************************************************
//* Priamary OAM address counters                                             *
//*****************************************************************************
reg [7:0] pri_oam_addr_cnt;

always @(posedge clk) 
begin
    if (rst)
        pri_oam_addr_cnt <= 8'd0;
    else
        if (oam_addr_wr)
            pri_oam_addr_cnt <= slv_mem_din;
        else
            if (oam_data_wr) // this is when sprite dma bang 2004
                pri_oam_addr_cnt <= pri_oam_addr_cnt + 8'd1;    
end


//Counters for sprite evaluation
//OAM[n][m] below refers to the byte at offset 4*n + m within OAM, i.e. OAM byte m (0-3) of sprite n (0-63)
reg [1:0] m_cnt; //which byte in the sprite
wire      m_cnt_overflow = (m_cnt == 2'd3);
wire      m_cnt_clr;
reg       m_cnt_en;

always @(posedge clk) 
begin
    if (scanline_begin || bgnd_read_end || m_cnt_clr)
        m_cnt <= 2'd0;
    else
        if (m_cnt_en)
            m_cnt <= m_cnt + 2'd1;    
end

reg [5:0] n_cnt; // wich sprite from 64
wire      n_cnt_overflow = (n_cnt == 6'd63);
reg       n_cnt_en;
reg       n_cnt_max_reached;

always @(posedge clk) 
begin
    if (scanline_begin || bgnd_read_end)
        n_cnt <= 6'd0;
    else
        if (n_cnt_en)
            n_cnt <= n_cnt + 6'd1;
end

always @(posedge clk) 
begin
    if (scanline_begin)
        n_cnt_max_reached <= 1'b0;
    else
        if (n_cnt_en && n_cnt_overflow)
            n_cnt_max_reached <= 1'b1;    
end

//*****************************************************************************
//* Primary Object Attribute Memory                                           *
//*****************************************************************************
(* ram_style = "distributed" *)
reg  [7:0]  pri_oam [255:0];
reg  [7:0]  pri_oam_addr;
wire [1:0]  pri_oam_addr_sel;
wire [7:0]  pri_oam_dout = pri_oam[pri_oam_addr];

always @(*) 
begin
    case (pri_oam_addr_sel)
        2'b01:   pri_oam_addr <= {n_cnt, m_cnt};
        2'b11:   pri_oam_addr <= {pri_oam_addr_cnt[7:3], n_cnt[0], m_cnt}; 
        default: pri_oam_addr <= pri_oam_addr_cnt; 
    endcase    
end

always @(posedge clk) 
begin
    if (oam_data_wr)
        pri_oam[pri_oam_addr] <= slv_mem_din;    
end

//*****************************************************************************
//* Secondary Primary OAM dout                                                *
//*****************************************************************************
reg  [7:0]  oam_temp_reg = 8'hFF;
wire        oam_temp_reg_set;
reg         oam_temp_reg_wr;

always @(posedge clk) 
begin
    if (rst || oam_temp_reg_set)
        oam_temp_reg <= 8'hFF;
    else
        if (oam_temp_reg_wr)
            oam_temp_reg <= pri_oam_dout;    
end

//*****************************************************************************
//* Testing the visibility of the sprite                                      *
//*****************************************************************************
reg  [8:0]  y_diff_reg1;
wire        sprite_in_range = (sprite_size) ? (y_diff_reg1[8:4] == 5'd0) : (y_diff_reg1[8:3] == 6'd0);


// if I subtract from scanline cntr - tile_addr then check the upper bits of y_diff_reg to be zero then we have a sprite in range
always @(posedge clk) 
begin
    if (rst)
        y_diff_reg1 <= 9'd0;
    else
        if (oam_temp_reg_wr)
            y_diff_reg1 <= scanline_cnt - {1'b0, pri_oam_dout};    
end

//*****************************************************************************
//* Secondary OAM address counter                                             *
//*****************************************************************************
reg  [4:0]  sec_oam_addr_cnt;
wire        sec_oam_addr_cnt_overflow = (sec_oam_addr_cnt == 5'd31);
reg         sec_oam_addr_cnt_en;

always @(posedge clk) 
begin
    if (rst || scanline_begin || bgnd_read_end)
        sec_oam_addr_cnt <= 5'd0;
    else
        if (sec_oam_addr_cnt_en)
            sec_oam_addr_cnt <= sec_oam_addr_cnt + 5'd1;    
end

//*****************************************************************************
//* Secondary Object Attribute Memory                                         *
//*****************************************************************************
(* ram_style = "distributed" *)
reg  [7:0]  sec_oam [31:0];
wire [7:0]  sec_oam_dout = sec_oam[sec_oam_addr_cnt];
reg         sec_oam_wr;
wire        sec_oam_rd;

always @(posedge clk) 
begin
    if (sec_oam_wr)
        sec_oam[sec_oam_addr_cnt] <= oam_temp_reg;  
end

//*****************************************************************************
//* Register that stores the sprite line index                                *
//* The vertical inversion is applied here                                    *
//*****************************************************************************
// this is the range where we are in a one tile rendering
reg  [3:0]  y_diff_reg2;
wire        y_diff_reg2_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b00);

always @(posedge clk) 
begin
    if (rst)
        y_diff_reg2 <= 4'd0;
    else
        if (y_diff_reg2_wr)
            y_diff_reg2 <= scanline_cnt[3:0] - sec_oam_dout[3:0];    
end

wire sprite_range_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b11);
wire v_inversion;

always @(posedge clk) 
begin
    if (rst)
        sprite_range <= 4'd0;
    else
        if (sprite_range_wr)
            sprite_range <= y_diff_reg2 ^ {4{v_inversion}};    
end

//*****************************************************************************
//* Register that stores the sprite tile index                                *
//*****************************************************************************
wire sprite_tile_index_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b01);

always @(posedge clk) 
begin
    if (rst)
        sprite_tile_index <= 8'd0;
    else
        if (sprite_tile_index_wr)
            sprite_tile_index <= sec_oam_dout;    
end

//*****************************************************************************
//* Register that stores the sprite attribute data                            *
//*****************************************************************************
reg  [4:0]  sprite_attributes;
wire        sprite_attribute_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b10);

always @(posedge clk) 
begin
    if (rst)
        sprite_attributes <= 5'd0;
    else
        if (sprite_attribute_wr)
            sprite_attributes <= {sec_oam_dout[7:5], sec_oam_dout[1:0]};
end

// Vertical inversion bit
assign v_inversion = sprite_attributes[4];

//*****************************************************************************
//* Register that stores the sprite X-coordinate                              *
//*****************************************************************************
reg  [7:0]  sprite_x_coord;
wire        sprite_x_coord_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b11);

always @(posedge clk) 
begin
    if (rst)
        sprite_x_coord <= 8'd0;
    else
        if (sprite_x_coord_wr)
            sprite_x_coord <= sec_oam_dout; 
end

//*****************************************************************************
//* Controller state machine                                                  *
//*****************************************************************************
localparam  OAM_IDLE            = 4'd0;
localparam  OAM_SCANLINE_WAIT   = 4'd1;
localparam  OAM_INITIALIZE      = 4'd2;
localparam  OAM_COPY_Y_COORD    = 4'd3;
localparam  OAM_COPY_TILE       = 4'd4;
localparam  OAM_COPY_ATTRIB     = 4'd5;
localparam  OAM_COPY_X_COORD    = 4'd6;
localparam  OAM_SPR_OVERFLOW1   = 4'd7;
localparam  OAM_SPR_OVERFLOW2   = 4'd8;
localparam  OAM_SPR_OVERFLOW3   = 4'd9;
localparam  OAM_SPR_OVERFLOW4   = 4'd10;
localparam  OAM_HBLANK_WAIT     = 4'd11;
localparam  OAM_SPR_DATA_RD1    = 4'd12;
localparam  OAM_SPR_DATA_RD2    = 4'd13;
localparam  OAM_SPR_DATA_RD3    = 4'd14;

reg [3:0] oam_state;

always @(posedge clk) 
begin
    if (rst)
        oam_state <= OAM_IDLE;
    else
        case (oam_state)
            // Waiting for the beginning of rendering (end of VBLANK)
            OAM_IDLE:   if (start_rendering)
                            oam_state <= OAM_SCANLINE_WAIT;
                        else
                            oam_state <= OAM_IDLE;
            // waiting for the beginning of the NES scanline        
            OAM_SCANLINE_WAIT:  if (scanline_begin)
                                    oam_state <= OAM_INITIALIZE;
                                else
                                    if (rendering_end)
                                        oam_state <= OAM_IDLE;
                                    else
                                        oam_state <= OAM_SCANLINE_WAIT;
            // initializing the secondary oam with 0xFF
            OAM_INITIALIZE: if (odd_phase && sec_oam_addr_cnt_overflow)
                                oam_state <= OAM_COPY_Y_COORD;
                            else
                                oam_state <= OAM_INITIALIZE;
            // testing sprite visibility and copying the Y coordinate
            OAM_COPY_Y_COORD:   if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (sprite_in_range)
                                            oam_state <= OAM_COPY_TILE;
                                        else
                                            if (n_cnt_overflow)
                                                oam_state <= OAM_HBLANK_WAIT;
                                            else
                                                oam_state <= OAM_COPY_Y_COORD;
                                    else
                                        oam_state <= OAM_COPY_Y_COORD;
            // copy the sprite tile index
            OAM_COPY_TILE:  if (bgnd_read_end)
                                oam_state <= OAM_SPR_DATA_RD1;
                            else
                                if (odd_phase_en)
                                    oam_state <= OAM_COPY_ATTRIB;
                                else
                                    oam_state <= OAM_COPY_TILE;
            // Copy the sprite attribete data
            OAM_COPY_ATTRIB:    if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_COPY_X_COORD;
                                    else
                                        oam_state <= OAM_COPY_ATTRIB;
            // copy the sprite x-coordinate
            OAM_COPY_X_COORD:   if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (n_cnt_overflow)
                                            oam_state <= OAM_HBLANK_WAIT;
                                        else
                                            if (sec_oam_addr_cnt_overflow)
                                                oam_state <= OAM_SPR_OVERFLOW1;
                                            else
                                                oam_state <= OAM_COPY_Y_COORD;
                                    else
                                        oam_state <= OAM_COPY_X_COORD;
            // checking the secondary oam is full
            OAM_SPR_OVERFLOW1:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (sprite_in_range)
                                            oam_state <= OAM_SPR_OVERFLOW2;
                                        else
                                            if (n_cnt_overflow)
                                                oam_state <= OAM_HBLANK_WAIT;
                                            else
                                                oam_state <= OAM_SPR_OVERFLOW1;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW1;
            // sprite overtflow
            OAM_SPR_OVERFLOW2:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW3;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW2;
            // sprite overtflow
            OAM_SPR_OVERFLOW3:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW4;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW3;
            // sprite overtflow
            OAM_SPR_OVERFLOW4:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW1;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW4;
            // Waiting for the end of the background data read
            OAM_HBLANK_WAIT:    if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    oam_state <= OAM_HBLANK_WAIT;
            // reading the sprite data from the secondary oam
            OAM_SPR_DATA_RD1:   if (next_pixel && (sec_oam_addr_cnt[1:0] == 2'd3))
                                    oam_state <= OAM_SPR_DATA_RD2;
                                else
                                    oam_state <= OAM_SPR_DATA_RD1;
            // waiting for the end of the last sprite byte
            OAM_SPR_DATA_RD2:   if (next_pixel && pixel_cnt_overflow)
                                    if (sec_oam_addr_cnt_overflow)
                                        oam_state <= OAM_SPR_DATA_RD3;
                                    else
                                        oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    oam_state <= OAM_SPR_DATA_RD2;
            // waiting for the end of nes scanline
            OAM_SPR_DATA_RD3:   if (nes_scanline_end)
                                    oam_state <= OAM_SCANLINE_WAIT;
                                else
                                    oam_state <= OAM_SPR_DATA_RD3;
            // invalid state
            default:    oam_state <= OAM_IDLE;
        endcase    
end

//Primary OAM address select signal
// if we are in VBLANK we wait for dma to copy primary oam
assign pri_oam_addr_sel[0] = ppu_enable & ~((oam_state == OAM_IDLE) | (oam_state == OAM_SCANLINE_WAIT));
assign pri_oam_addr_sel[1] = (n_cnt[5:1] == 5'd0) & ~n_cnt_max_reached;

//Primary OAM M address counter clear signal
assign m_cnt_clr = odd_phase_en & (oam_state == OAM_SPR_OVERFLOW1) & ~sprite_in_range & n_cnt_overflow;

//Primary OAM M address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD:   m_cnt_en <= odd_phase_en & sprite_in_range;
        OAM_COPY_TILE:      m_cnt_en <= odd_phase_en;
        OAM_COPY_ATTRIB:    m_cnt_en <= odd_phase_en;
        OAM_COPY_X_COORD:   m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW1:  m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW2:  m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW3:  m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW4:  m_cnt_en <= odd_phase_en;
        default:            m_cnt_en <= 1'b0;
    endcase    
end

//Primary OAM N address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD:   n_cnt_en <= odd_phase_en & ~sprite_in_range;
        OAM_COPY_X_COORD:   n_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW1:  n_cnt_en <= odd_phase_en & (~sprite_in_range | m_cnt_overflow);
        OAM_SPR_OVERFLOW2:  n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_SPR_OVERFLOW3:  n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_SPR_OVERFLOW4:  n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_HBLANK_WAIT:    n_cnt_en <= odd_phase_en;
        default:            n_cnt_en <= 1'b0;
    endcase    
end

//Temporary data register set signal
assign oam_temp_reg_set = scanline_begin | bgnd_read_end;

//Temprory data register write en signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD:   oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_TILE:      oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_ATTRIB:    oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_X_COORD:   oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW1:  oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW2:  oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW3:  oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW4:  oam_temp_reg_wr <= even_phase_en;
        OAM_HBLANK_WAIT:    oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_DATA_RD2:   oam_temp_reg_wr <= sprite_read_end;
        default:            oam_temp_reg_wr <= 1'b0;
    endcase 
end

//Secondary OAM address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_INITIALIZE:     sec_oam_addr_cnt_en <= odd_phase;
        OAM_COPY_Y_COORD:   sec_oam_addr_cnt_en <= odd_phase_en & sprite_in_range;
        OAM_COPY_TILE:      sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_COPY_ATTRIB:    sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_COPY_X_COORD:   sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_SPR_DATA_RD1:   sec_oam_addr_cnt_en <= next_pixel & (sec_oam_addr_cnt[1:0] != 2'd3); // only count in RD1 this is the read from secondary oam
        OAM_SPR_DATA_RD2:   sec_oam_addr_cnt_en <= next_pixel & pixel_cnt_overflow;
        default:            sec_oam_addr_cnt_en <= 1'b0;
    endcase    
end

// secondary OAM write enable signal
always @(*) 
begin
    case (oam_state)
        OAM_INITIALIZE:     sec_oam_wr <= odd_phase;
        OAM_COPY_Y_COORD:   sec_oam_wr <= odd_phase_en;
        OAM_COPY_TILE:      sec_oam_wr <= odd_phase_en;
        OAM_COPY_ATTRIB:    sec_oam_wr <= odd_phase_en;
        OAM_COPY_X_COORD:   sec_oam_wr <= odd_phase_en;
        default:            sec_oam_wr <= 1'b0;
    endcase
end

//Secondery OAM read enable signal
assign sec_oam_rd = (oam_state == OAM_SPR_DATA_RD1) & next_pixel;

//Sprite overflow flag set signal
assign lost_sprite_set = odd_phase_en & (oam_state == OAM_SPR_OVERFLOW1) & sprite_in_range;

//*****************************************************************************
//* Drive the output data bus                                                 *
//*****************************************************************************
wire oam_dout_sel = ppu_enable & ~((oam_state == OAM_IDLE) | (oam_state == OAM_SCANLINE_WAIT));

always @(*) 
begin
    case (oam_dout_sel)
        1'b0: oam_dout <= pri_oam_dout; 
        1'b1: oam_dout <= oam_temp_reg;
    endcase    
end

//*****************************************************************************
//* Sprite0 in range signal                                                   *
//*****************************************************************************
reg [1:0] sprite0_in_range;
// sprite0_visible set 
assign sprite0_visible = sprite0_in_range[1] & |sprite_pixel[1:0] & sprite_enabled; // not fully sure 

always @(posedge clk) 
begin
    if (rst)
        sprite0_in_range <= 2'd0;
    else
        if (scanline_begin)
            sprite0_in_range <= {sprite0_in_range[0], 1'd0};
        else
            if (odd_phase_en && (oam_state == OAM_COPY_X_COORD) && (n_cnt == 6'd0))
                sprite0_in_range <= {sprite0_in_range[1], 1'b1};
end

//*****************************************************************************
//* Registers that stores the validity of the sprites                         *
//*****************************************************************************
reg [7:0] valid_sprite; // fill up when we find a valid sprite 
// it is important if not all the 8 sprite was found the other sprites are invisible

always @(posedge clk) 
begin
    if (rst || scanline_begin)
        valid_sprite <= 8'd0;
    else
        if (odd_phase_en && (oam_state == OAM_COPY_X_COORD))
            valid_sprite <= {valid_sprite[6:0], 1'b1};
end

//*****************************************************************************
//* Sprite buffers                                                            *
//*****************************************************************************
wire    [3:0]  sprite_buff_pixel [7:0];
wire    [7:0]  sprite_buff_priority;
genvar         i;

generate
    for(i = 0; i < 8; i = i + 1)
    begin: sprite_buffer_load
        wire pattern0_ld = pattern0_read & sprite_read & (sec_oam_addr_cnt[4:2] == i);
        wire pattern1_ld = pattern1_read & sprite_read & (sec_oam_addr_cnt[4:2] == i);

        sprite_buffer sprite_buffer(
            .clk(clk),
            .rst(rst),

            // input controll signals
            .bground_read(bground_read),
            .next_pixel(next_pixel),
            .pattern0_ld(pattern0_ld),
            .pattern1_ld(pattern1_ld),

            //Data input
            .valid_sprite(valid_sprite[i]),
            .sprite_attr_in(sprite_attributes[3:0]),
            .sprite_x_in(sprite_x_coord),
            .pattern_in(ppu_mem_din),

            //Data out
            .sprite_pixel(sprite_buff_pixel[i]),
            .sprite_priority(sprite_buff_priority[i])
        );
    end
endgenerate

//*****************************************************************************
//* Sprite priority mux                                                       *
//*****************************************************************************
sprite_mux sprite_mux(
    .clk(clk),
    .rst(rst),
    //Input controll signals
    .sprite_enabled(sprite_enabled),
    .no_sprite_clip(no_sprite_clip),
    .first_column(first_column), //first background

    //Data input
    //.sprite_buff_pixel(sprite_buff_pixel),
    .sprite_pixel_0(sprite_buff_pixel[0]),
    .sprite_pixel_1(sprite_buff_pixel[1]),
    .sprite_pixel_2(sprite_buff_pixel[2]),
    .sprite_pixel_3(sprite_buff_pixel[3]),
    .sprite_pixel_4(sprite_buff_pixel[4]),
    .sprite_pixel_5(sprite_buff_pixel[5]),
    .sprite_pixel_6(sprite_buff_pixel[6]),
    .sprite_pixel_7(sprite_buff_pixel[7]),
    .sprite_priority_buff(sprite_buff_priority),

    //Data out
    .sprite_pixel(sprite_pixel),
    .sprite_priority(sprite_priority)
);


wire [13:0] sprite_lsb_addr;
wire [13:0] sprite_msb_addr;

//sprite address with sprite size
assign sprite_lsb_addr = (~sprite_size) ? 
						({1'b0, sprite_pattern_sel, sprite_tile_index, 1'b0, sprite_range[2:0]})
						: ({1'b0, sprite_tile_index[0], sprite_tile_index[7:1], sprite_range[3], 1'b0, sprite_range[2:0]});
assign sprite_msb_addr = (~sprite_size) ? 
						({1'b0, sprite_pattern_sel, sprite_tile_index, 1'b1, sprite_range[2:0]}) 
						: ({1'b0, sprite_tile_index[0], sprite_tile_index[7:1], sprite_range[3], 1'b1, sprite_range[2:0]});

//*****************************************************************************
//* pixel mux a sprite and bg 												  *
//*****************************************************************************
wire [4:0] palette_addr;

// (~background_clipping && first_column) // in this region we draw 0000 or black

wire visible_bg_pixel = (bg_msb_out | bg_lsb_out);

// visible bg pixel maybe over kill
assign palette_addr = 	(sprite_priority && visible_bg_pixel) ?
					 	({1'b0, tile_attr_reg, bg_msb_out, bg_lsb_out}) //back ground color
					 	: ({1'b1, sprite_pixel}); //sprite color palette					 	

//*****************************************************************************
//* color block ram														 	  *
//*****************************************************************************
//wire palette_ram_access = (ppu_nt_addr[13:8] == 6'h3F);

// maybe we need to turn it of during rendering
//wire [4:0] palette_ram_addr = (palette_ram_access) ? (ppu_nt_addr[4:0]) : (palette_addr); 

wire [4:0] palette_ram_nt_addr_mirrored = 	((vram_addr_cnt[4:0] == 5'h10) 
										|| (vram_addr_cnt[4:0] == 5'h14)
										|| (vram_addr_cnt[4:0] == 5'h18)
										|| (vram_addr_cnt[4:0] == 5'h1C)) ? 
										({1'b0, vram_addr_cnt[3:0]}) 
										: (vram_addr_cnt[4:0]);

wire [4:0] palette_ram_addr_mirrored = 	((palette_addr[4:0] == 5'h10) 
										|| (palette_addr[4:0] == 5'h14)
										|| (palette_addr[4:0] == 5'h18)
										|| (palette_addr[4:0] == 5'h1C)) ? 
										({1'b0, palette_addr[3:0]}) 
										: (palette_addr);

(* ram_style = "distributed" *)
reg  [5:0] 	palette_ram [31:0];
integer y;
initial begin for (y=0; y<32; y=y+1) palette_ram[y] = 6'b0;
end

// adat kinullázása monocrome esetben alsó 4 bit csak a paletta data 0?
wire [5:0]  palette_data0 = palette_ram[palette_ram_nt_addr_mirrored]; 
wire [5:0]  palette_nt_with_monocrom = (monochrome_mode) ? ({palette_data0[5:4], 4'd0}) : (palette_data0);

wire [5:0]  palette_data1 = palette_ram[palette_ram_addr_mirrored];
wire [5:0]  palette_with_monocrom = (monochrome_mode) ? ({palette_data1[5:4], 4'd0}) : (palette_data1);

always @(posedge clk) 
begin
    if (ppu_enable && palette_ram_access)
        palette_ram[palette_ram_nt_addr_mirrored] <= slv_mem_din[5:0];  
end

// (~ppu_enable && palette_ram_access) akkor a cím a cím számlálókból jön megjelnítéshez is
wire [5:0]  palette_data = 	(~ppu_enable && palette_ram_access) 
							? (palette_nt_with_monocrom) : (palette_with_monocrom);

// rgb data to render vga 
(* ram_style = "block" *)
reg  [23:0] 	palette_rgb_rom [511:0];
initial begin
	$readmemh( "src/ppu/rgb_rom/rgb_rom_888_24bit.txt" , palette_rgb_rom); 
end
reg  [23:0] 	palette_rgb_rom_dout;

// MASK for blank black value
// 0-256 x_rendercnt

wire [8:0] 		palette_rgb_rom_address = 	((x_rendercntr > START_OF_SHIFT) 
											&& (x_rendercntr <= FINE_VERTICAL_CNT_UP) 
											&& (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW)
											&& ~(~background_clipping && first_column)) ? 
											({emphasize_b, emphasize_g, emphasize_r, palette_data}) : (9'd13); 
											
//9'd13 is black //&& (x_rendercntr <= FINE_VERTICAL_CNT_UP) && (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW) && ~(~background_clipping && first_column)

//wire [8:0] 		palette_rgb_rom_address = 9'd13;

always @(posedge clk)
begin
	palette_rgb_rom_dout <= palette_rgb_rom[palette_rgb_rom_address];
end

//*****************************************************************************
//* Driving the ouzput data bus of the video memory interface                 *
//*****************************************************************************
always @(posedge clk) 
begin
	if (rst)
		ppu_mem_dout <= 8'd0;
	else
		if (vram_data_wr)
			ppu_mem_dout <= slv_mem_din;	
end


reg	ppu_mem_wr_request_reg;

always @(posedge clk) 
begin
	if (rst)
		ppu_mem_wr_request_reg <= 1'b0;	
	else
		if (vram_data_wr)
			ppu_mem_wr_request_reg <= 1'b1;
		else
			ppu_mem_wr_request_reg <= 1'b0;	
end

assign ppu_mem_wr_request = ppu_mem_wr_request_reg;


//assign ppu_mem_wr_request = vram_data_wr;

//*****************************************************************************
//* Driving the output data bus of slave bus interface                        *
//*****************************************************************************
reg  [7:0] vram_read_reg = 8'hFF;
reg  	   read_enable;
wire [3:0] read_sel; 

assign read_sel[0] = status_rd;
assign read_sel[1] = oam_data_rd;
assign read_sel[2] = vram_data_rd;
assign read_sel[3] = palette_ram_access; // we dont have this yet palette_ram_access

always @(posedge clk) 
begin
	if (rst)
		vram_read_reg <= 8'hff;
	else
		if (vram_data_rd)
			vram_read_reg <= ppu_mem_din; 	
end

always @(posedge clk) 
begin
	if (rst)
		read_enable <= 1'b0;
	else
		if (ph2_rising)
			read_enable <= 1'b1;	
end

always @(posedge clk) 
begin
	if (rst || ph2_falling)
		slv_mem_dout <= 8'd0;
	else
		if (read_enable)
		 casex (read_sel)
			4'bx001: slv_mem_dout <= status_reg;
			4'bx010: slv_mem_dout <= oam_read_data; // oam data out
			4'b0100: slv_mem_dout <= vram_read_reg;
			4'b1100: slv_mem_dout <= {2'b00, palette_nt_with_monocrom}; // we need palette access and data too 
			default: slv_mem_dout <= 8'd0;
		 endcase
end

//*****************************************************************************
//* CPU                                                                       *
//*****************************************************************************
wire ready;
wire [7:0] cpu_din = (memory_manager_cpu_din | controller_cpu_din | ppu_to_cpu_din);
wire [15:0] ag6502_addr;
wire [7:0]  ag6502_dout;
wire ag6502_rnw;

nes_cpu6502 cpu(
   //Clock and reset.
   .clk(clk),                //System clock signal.
   .rst(rst),                //System reset signal.
   .ph1_rising(ph1_rising),         //Rising edge of the phase 1 clock.
   .ph1_falling(ph1_falling),        //Falling edge of the phase 1 clock.
   .ph2_rising(ph2_rising),         //Rising edge of the phase 2 clock.
   .ph2_falling(ph2_falling),        //Falling edge of the phase 2 clock.
   
   //Master bus interface.
   .mst_mem_rnw(ag6502_rnw),        //Read/write select signal.
   .mst_mem_address(ag6502_addr),    //Address bus.
   .mst_mem_dout(ag6502_dout),       //Data bus.
   .mst_mem_din(cpu_din),
   
   //Interrupt and DMA request.
   .int_n(1'b1),              //INT request signal (active-low).
   .nmi_n(~nmi),              //NMI request signal (falling edge).
   .ready(ready)               //When low, the CPU stops at read cycles.
);

//*****************************************************************************
//* Sprite DMA                                                                *
//*****************************************************************************
wire [15:0] dma_cpu_addr;
wire [7:0]  dma_cpu_dout;
wire        dma_cpu_avalid;
wire        dma_cpu_rnw;
wire [15:0] cpu_addr;


reg even_cycle;

always @(posedge clk) 
begin
   if (rst)
      even_cycle <= 1'b0;
   else
      if (ph2_falling)
         even_cycle <= ~even_cycle;   
end

sprite_dma sprite_dma(
   .clk(clk),
   .rst(rst),
   .ph1_rising(ph1_rising),
   .ph2_rising(ph2_rising),
   .ph2_falling(ph2_falling),

   // control signal
   .even_cycle(even_cycle), // even cpu clock cycles

   // out control signals
   // used for block cpu until dma cycles
   .ready(ready),      // when low the cpu stops at read cycles

   // Slave bus interface (cpu adress space, write only)
   // Using for the time when cpu activates oam and dmc dma
   .slv_mem_select(ag6502_addr[15:14] == 2'b01), 
   .slv_mem_rnw(ag6502_rnw),    
   .slv_mem_addr(ag6502_addr[4:0]),  // [4:0] ag6502_addr
   .slv_mem_din(ag6502_dout),  // [7:0]

    // Master bus interface
    // CPU bus interface overtaken when DMA is active
   .mst_mem_rnw(dma_cpu_rnw),    
   .mst_mem_address(dma_cpu_addr),
   .mst_mem_avalid(dma_cpu_avalid),
   .mst_mem_dout(dma_cpu_dout),
   .mst_mem_din(cpu_din)
);

assign cpu_addr = (dma_cpu_avalid) ? (dma_cpu_addr) : (ag6502_addr);
assign cpu_dout = (dma_cpu_dout | ag6502_dout);
assign rnw = ~(~dma_cpu_rnw | ~ag6502_rnw);

//*****************************************************************************
//* Memory manager                                                            *
//*****************************************************************************
wire [7:0] memory_manager_cpu_din;

memory_manager_v2_top  #(.NT_MIRRORING(2'b01)) memory_manager (
	//clock and rst signals
	.clk(clk),
	.rst(rst),
	.ph2_rising(ph2_rising),
	.ph2_falling(ph2_falling),

    // CPU interface for memory acess master
	.cpu_addr(cpu_addr), //[15:0]
	.cpu_rnw(rnw), 
	.cpu_data_out(memory_manager_cpu_din), // output [7:0]
	.cpu_data_in(cpu_dout), // [7:0]

	// Memory inerface slave
	.ppu_wr_req(ppu_mem_wr_request), 
	//.ppu_rd_req(ppu_mem_read_request), 
	.ppu_addr(ppu_mem_addr), // [13:0]
	.ppu_din(ppu_mem_dout), // [7:0]
	.ppu_dout(ppu_mem_din) //output [7:0]
);

//*****************************************************************************
//* Controller ports                                                          *
//*****************************************************************************

wire [7:0] controller_cpu_din;

wire controller_clk;
wire controller_latch;

controller_top controller_top(
    //clock
   .clk(clk),
   .rst(rst),
   .ph2_falling(ph2_falling),

    // CPU interface for memory acess master
	.cpu_addr(cpu_addr), // [15:0]
	.cpu_rnw(rnw), 
	.cpu_data_out(controller_cpu_din), // output [7:0]
	.cpu_data_in(cpu_dout[0]), //just one bit the $4016 write strobe

    //controller output signals
   .controller_data1(ctrl1_data),    // joypad 1 input signal
   .controller_data2(ctrl2_data),    // joypad 2 input signal
   .controller1_out_clk(ctrl1_clk),      // joypad output clk signal
   .controller2_out_clk(ctrl2_clk),      // joypad output clk signal
   .controller_out_latch(controller_latch)     // joypad output latch signal
);

assign ctrl1_latch = controller_latch;     
assign ctrl2_latch = controller_latch;

	initial begin 
    forever begin
    #10 clk = ~clk;
 	end 
 	end

	initial begin
		// Initialize Inputs
		clk = 0;
		ctrl1_data = 1;
		ctrl2_data = 1;
		rst = 1;
		#100;
		rst = 0;

        
		// Add stimulus here

	end
      
endmodule

