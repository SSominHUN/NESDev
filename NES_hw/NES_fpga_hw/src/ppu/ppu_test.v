`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:44:03 10/29/2023
// Design Name:   ppu_top
// Module Name:   D:/NESDev/NES-hw/src/ppu/ppu_test.v
// Project Name:  NES-hw
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ppu_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ppu_test;

reg [15:0] cpu_addr;

	// Inputs
	reg clk;
	reg rst;
	reg clk_2x;
	reg clk_10x;
	reg bufpll_locked;
	reg serdes_strobe;
	wire [2:0] slv_mem_addr = cpu_addr[2:0];
	wire slv_mem_cs = (cpu_addr[15:13] == 3'b001);
	reg slv_mem_rnw;
	reg [7:0] slv_mem_din;
	reg [7:0] ppu_mem_din;

	// Outputs
	wire ph1_rising_outw;
	wire ph2_rising_outw;
	wire ph2_falling_outw;
	wire [7:0] slv_mem_dout;
	reg irq;
	wire [7:0] ppu_mem_dout;
	wire [13:0] ppu_mem_addr;
	wire ppu_mem_wr_request;
	wire tmds_data0_out_p;
	wire tmds_data0_out_n;
	wire tmds_data1_out_p;
	wire tmds_data1_out_n;
	wire tmds_data2_out_p;
	wire tmds_data2_out_n;
	wire tmds_clock_out_p;
	wire tmds_clock_out_n;

	

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
//*****************************************************************************
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
			y_renderingcntr <= y_renderingcntr + 9'd1;
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
assign ppu_mem_addr = (((y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW) || (y_renderingcntr == PRERENDERING_ROW))) 
						? (ppu_addr_fetch) : (ppu_nt_addr); // not good yet

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
		else if (((bgrender_state == BG_MSB) && (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION) && (x_rendercntr <= FINE_VERTICAL_CNT_UP) && (x_rendercntr > START_OF_LAST_TWO_FETCH)) 
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

//*****************************************************************************
//* CPU clock generation			                                          *
//*****************************************************************************
reg ph1_rising;
//reg ph1_falling;
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
			if (clkgen_cnt == 4'd11)
				clkgen_cnt <= 4'd0;
			else
				clkgen_cnt <= clkgen_cnt + 4'd1;
end

always @ (posedge clk)
begin
	ph1_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd0);
	//ph1_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd5);
	ph2_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd6);
	ph2_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd11);
end

assign ph1_rising_outw = ph1_rising;
//assign ph1_falling_outw = ph1_falling;
assign ph2_rising_outw = ph2_rising;
assign ph2_falling_outw = ph2_falling;

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

wire [7:0] 	oam_read_data;

wire [7:0]  sprite_tile_index;
wire [3:0]  sprite_range;
wire [3:0] 	sprite_pixel;
wire 		sprite_priority;

sprite_rendering sprite_fsm(
   	//Clock and reset
   	.clk(clk),
   	.rst(rst),

   	//Data inputs
   	.slv_mem_din(slv_mem_din),
   	.ppu_mem_din(ppu_mem_din),

	//Signals related to the OAM access
    .oam_addr_wr(oam_addr_wr),
    .oam_data_wr(oam_data_wr),
    .oam_dout(oam_read_data), //not 100% sure

	//Input control signals
	.bground_enabled(background_enabled), 
    .sprite_enabled(sprite_enabled),  
    .no_sprite_clip(sprite_clipping), 
    .first_column(first_column), // hole first column 1 is now include the idle too
    .sprite_size(sprite_size),     
    .next_pixel(next_pixel), // az idle is bele számolódik?  
    .start_rendering((y_renderingcntr == END_OF_VBLANK_ROW) && (x_rendercntr == END_OF_RENDERING_LINE)), // utolsó pixel a vga  1599, 260 sor
    .scanline_begin(x_rendercntr == FIRST_SCANLINE_PIXEL),  // 127 idle cycle
    .bgnd_read_end(x_rendercntr == FINE_VERTICAL_CNT_UP),   // this is actually (dot 256) dot 257
    .pattern0_read(bg_lsb_read_reg),   //helyes adat
    .pattern1_read(bg_msb_read_reg),   
    .bground_read((x_rendercntr <= FINE_VERTICAL_CNT_UP)),  // just the 0-256 reagion is sprite read
    .sprite_read(sprite_read),   // this is 1 in all sprite read
    .sprite_read_end(x_rendercntr == START_OF_LAST_TWO_FETCH), // ~(bgrender_state == VBLANK) && (x_rendercntr[2:0] == FINE_VERTICAL_CNT_UP)
    .nes_scanline_end((x_rendercntr == END_OF_BG_RENDERING_LINE)), // 2 NT fetch after
    .rendering_end((y_renderingcntr == END_OF_VISIBLE_FRAME_ROW) && (x_rendercntr == END_OF_RENDERING_LINE)), // this is the VBLANK start

    //Output control signals
    .lost_sprite_set(lost_sprites_set),
    .sprite0_visible(sprite0_hit_set), //sprite 0 pixel is visible

    //Output sprite data
    .sprite_tile_index(sprite_tile_index),	//sprite tile index
    .sprite_range(sprite_range),     		//Sprite line index
    .sprite_pixel(sprite_pixel),     		//Sprite pixel color (palette index) 
    .sprite_priority(sprite_priority)   	//Priority (0: in front of background; 1: behind background)
);

wire [13:0] sprite_lsb_addr;
wire [13:0] sprite_msb_addr;

//sprite address with sprite size
assign sprite_lsb_addr = (~sprite_size) ? 
						({1'b0, sprite_pattern_sel, sprite_tile_index, 1'b0, sprite_range[2:0]})
						: ({1'b0, sprite_tile_index[0], sprite_tile_index[7:1], 1'b0, sprite_range});
assign sprite_msb_addr = (~sprite_size) ? 
						({1'b0, sprite_pattern_sel, sprite_tile_index, 1'b1, sprite_range[2:0]}) 
						: ({1'b0, sprite_tile_index[0], sprite_tile_index[7:1], 1'b1, sprite_range});

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
wire palette_ram_access = (ppu_nt_addr[13:8] == 6'h3F);

// maybe we need to turn it of during rendering
//wire [4:0] palette_ram_addr = (palette_ram_access) ? (ppu_nt_addr[4:0]) : (palette_addr); 

wire [4:0] palette_ram_nt_addr_mirrored = 	((ppu_nt_addr[4:0] == 5'h10) 
										|| (ppu_nt_addr[4:0] == 5'h14)
										|| (ppu_nt_addr[4:0] == 5'h18)
										|| (ppu_nt_addr[4:0] == 5'h1C)) ? 
										({1'b0, ppu_nt_addr[3:0]}) 
										: (ppu_nt_addr[4:0]);

wire [4:0] palette_ram_addr_mirrored = 	((palette_addr[4:0] == 5'h10) 
										|| (palette_addr[4:0] == 5'h14)
										|| (palette_addr[4:0] == 5'h18)
										|| (palette_addr[4:0] == 5'h1C)) ? 
										({1'b0, palette_addr[3:0]}) 
										: (palette_addr);

(* ram_style = "distributed" *)
reg  [5:0] 	palette_ram [31:0];

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

	initial begin 
    forever begin
    clk = 0;
    #10 clk = ~clk;
 	end 
 	end

	initial begin
		slv_mem_din = 8'b0;
		ppu_mem_din  = 8'b0;
		rst = 1;
		#20;
		rst = 0;
	/*
		// Initialize Inputs
		rst = 1;
		clk_2x = 0;
		clk_10x = 0;
		bufpll_locked = 0;
		serdes_strobe = 0;
		slv_mem_rnw = 0;
		ppu_mem_din = 0;

		// Wait 100 ns for global reset to finish
		#20;
		rst = 0;
      cpu_addr = 16'h2006;
		#20
		slv_mem_din = 8'h3F;
		#20
		slv_mem_din = 8'h01;
		#20  
		slv_mem_din = 8'h00;
	*/

	end
      
endmodule

