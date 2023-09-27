`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:57:29 07/03/2023 
// Design Name: 
// Module Name:    ppu_top 
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
module ppu_top(
	input  wire        clk, // 25 MHz
	input  wire		   rst,

    // register interface or interface to cpu
	input  wire [ 2:0] slv_mem_addr,      // register interface reg select (#2000-#2007)
	input  wire        slv_mem_cs,       // register interface enable (#2000 - #3FFF just when it is active)
	input  wire        slv_mem_rnw,       // register interface cpu read not write
	input  wire [ 7:0] slv_mem_din,       // register interface data in (cpu data lane)
	output wire [ 7:0] slv_mem_dout,       // register interface data out (cpu data lane)

	// PPU interface for memory access
	input  wire [ 7:0] ppu_mem_din,
	output wire [ 7:0] ppu_mem_dout,
	output wire [14:0] ppu_mem_addr,
	output wire 	   ppu_mem_wr_request,
	output wire 	   ppu_mem_read_request
	);

//*****************************************************************************
//* Generating controll signals                                          	  *
//*****************************************************************************
//register write enable signals
wire control_wr     = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b000); //CTRL register write #2000
wire render_mask_wr = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b001); //MASK register write #2001
wire oam_addr_wr    = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b011); //OAM read/write address #2003
wire oam_data_wr    = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b100); //OAM data read/write #2004
wire scrolling_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnw & (slv_mem_addr == 3'b101); //fine scroll position (two writes: X scroll, Y scroll) #2005
wire vram_addr_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnv & (slv_mem_addr == 3'b110); //PPU read/write address (two writes: most significant byte, least significant byte) #2006
wire vram_data_wr   = ph2_falling & slv_mem_cs & ~slv_mem_rnv & (slv_mem_addr == 3'b111); //PPU data read/write #2007

//Register read enable signals
wire status_rd      = slv_mem_cs & slv_mem_rnw & (slv_mem_addr == 3'b010);
wire oam_data_rd    = slv_mem_cs & slv_mem_rnv & (slv_mem_addr == 3'b100);
wire vram_data_rd   = slv_mem_cs & slv_mem_rnv & (slv_mem_addr == 3'b111);

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
reg [5:0] control_reg;

always @ (posedge clk) 
begin
    if (rst)
        control_reg <= 5'b10000;
    else
        if (control_wr)
            control_reg <= {slv_mem_din[7], slv_mem_din[5:2]};   
end

wire vram_address_inc_sel   = control_reg[0]; // VRAM address increment per CPU read/write of PPUDATA
                                              // (0: add 1, going across; 1: add 32, going down)
wire sprite_pattern_sel     = control_reg[1]; // Sprite pattern table address for 8x8 sprites
wire background_pattern_sel = control_reg[2]; // Background pattern table address (0: $0000; 1: $1000)
wire sprite_size            = control_reg[3]; // 0: 8x8 pixels; 1: 8x16 pixels
wire vram_irq_enable        = control_reg[4]; // Generate an NMI at the start of the vertical blanking interval 
                                              // (0: off; 1: on)

//*****************************************************************************
//* PPU mask register/ controll reg 2                                      	  *
//*****************************************************************************
reg [7:0] render_mask_reg;

always @ (posedge clk) 
begin
    if (rst)
        render_mask_wr <= 8'd0;
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
wire emphesize_g 		 = render_mask_reg[6];
wire emphesize_b 		 = render_mask_reg[7];


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
        if (vblank_set[0])
            vblank <= 3'b001;
        else
            if(vblank[1] || vblank_set[2])
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
        if (sprite0_hit_set && (sprite0_hit == 0))
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
reg  interupt_flag;
wire interupt_clr;

always @ (posedge clk) 
begin
    if (rst || interupt_clr || (status_rd && ph2_falling))
        interupt_flag <= 1'b0;
    else
        if (vblank_set[2] && vblank[1])
            interupt_flag <= 1'b0;
end

always @ (posedge clk) 
begin
    if (rst)
        irq <= 1'b0;
    else
        irq <= interupt_flag & vblank_irq_enable; //cpu irq?
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
reg [7:0] bg_msb_reg;
wire      bg_msb_read;

always @ (posedge clk) 
begin
    if (rst)
        bg_msb_reg <= 8'd0;
    else
        if (bg_msb_read)
            bg_msb_reg <= ppu_mem_din;
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

reg [2:0] bgrender_state;


reg			rd_req_reg;

reg	[14:0]	ppu_bg_addr_fetch;

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
					&& ((y_renderingcntr >= START_OF_VBLANK_ROW) && (y_renderingcntr != PRERENDERING_ROW)))
					bgrender_state <= VBLANK;
				else if ((x_rendercntr == FIRST_SCANLINE_PIXEL) && oddframe && (y_renderingcntr == FIRST_RENDERING_ROW))
					begin
					ppu_bg_addr_fetch <= {ppu_nt_addr};
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
							ppu_bg_addr_fetch <= {ppu_nt_addr};
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
							ppu_bg_addr_fetch <= {ppu_at_addr};
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
							ppu_bg_addr_fetch <= {bg_lsb_addr};
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
							ppu_bg_addr_fetch <= {bg_msb_addr}; 
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

assign attribute_sel = { ppu_nt_addr[6], ppu_nt_addr[1]};

assign ppu_mem_read_request = rd_req_reg; 
assign nametable_read = nametable_read_reg;
assign attribute_read = attribute_read_reg;
assign bg_lsb_read = bg_lsb_read_reg;
assign bg_msb_read = bg_msb_read_reg;

//*****************************************************************************
//* Back ground active pixel out		                                   	  *
//*****************************************************************************
reg [3:0] out_sel_cntr;

always @(posedge clk) 
begin
	if (rst)
		out_sel_cntr <= 3'd0;
	else if((x_rendercntr[1:0] == 2'b11) 
			&& (bgrender_state != IDLE) && (bgrender_state != VBLANK) && (bgrender_state != SLEEP))
				out_sel_cntr <= out_sel_cntr + 1;	
end

reg [7:0] bg_lsb_buff_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_lsb_buff_reg <= 8'd0;
    else
        if (bg_msb_read)
            bg_lsb_buff_reg <= bg_lsb_reg;
end

(* slr_style =  "register" *)
reg [7:0] shr_lsb_render = 8'd0;
wire	  lsb_out;  

always @(posedge clk) 
if ((x_rendercntr[1:0] == 2'b11) 
	&& (bgrender_state != IDLE) && (bgrender_state != VBLANK) && (bgrender_state != SLEEP))
		shr_lsb_render <= {shr_lsb_render[6:0], bg_lsb_buff_reg[out_sel_cntr]};

assign lsb_out = shr_lsb_render[fv_cntr];

(* slr_style =  "register" *)
reg [7:0] shr_msbrender = 8'd0;
wire	  msb_out;  

always @(posedge clk) 
if ((x_rendercntr[1:0] == 2'b11) 
	&& (bgrender_state != IDLE) && (bgrender_state != VBLANK) && (bgrender_state != SLEEP))
		shr_msbrender <= {shr_msbrender[6:0], bg_msb_reg[out_sel_cntr]};

assign msb_out = shr_msbrender[fv_cntr];

//*****************************************************************************
//* Addr make										                     	  *
//*****************************************************************************
wire [14:0] ppu_nt_addr;
wire [14:0] ppu_at_addr;
wire [14:0] bg_lsb_addr;
wire [14:0] bg_msb_addr;

//Horizontal tile index (HT) counter 
reg	 [4:0]  ht_cntr;

localparam H_COPY = 11'd1159;			//(128 + 4*258) - 1 = 1159 (dot 257)

always @(posedge clk) 
begin
	if (rst)
		ht_cntr <= 5'd0;
	else
		if ((second_write && vram_addr_wr) 
			|| ((bgrender_state != VBLANK) && (x_rendercntr == H_COPY)))
				ht_cntr <= slv_mem_din[4:0];
		else if (((bgrender_state == BG_MSB) && (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)) 
					|| ((vram_addr_wr || vram_data_rd ) && (bgrender_state != VBLANK) && (background_enabled || sprite_enabled)))
						ht_cntr <= ht_cntr + 1;
end

// Verical tile index (VT) counter
reg  [2:0] vt_cntr1;
reg  [1:0] vt_cntr2;
wire [4:0] vt_cntr = {vt_cntr2, vt_cntr1};

localparam START_OF_V_COPY = 11'd1251;	//(128 + 4*281) - 1 = 1251 (dot 280)
localparam END_OF_V_COPY = 11'd1343;	//(128 + 4*304) - 1 = 1343 (dot 304)

always @(posedge clk) 
begin
	if (rst)
		vt_cntr1 <= 3'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && (background_enabled || sprite_enabled)))
			vt_cntr1 <= slv_mem_din[7:5];
		else if ((fv_cntr == 3'b111)
				|| ((vram_addr_wr || vram_data_rd) && (bgrender_state == VBLANK) && (vram_address_inc_sel)))
					vt_cntr1 <= vt_cntr1 + 1;
end

always @(posedge clk) 
begin
	if (rst)
		vt_cntr2 <= 2'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && (background_enabled || sprite_enabled)))
				vt_cntr2 <= vt_reg1; // hopefully good with timing
		else if (vt_cntr1 == 3'b111)
			vt_cntr2 <= vt_cntr2 + 1;
end

// Horizontal name table select (H) counter 
reg h_sel_cntr;

always @(posedge clk) 
begin
	if (rst)
		h_sel_cntr <= 1'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((bgrender_state != VBLANK) && (x_rendercntr == H_COPY)))
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
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && (background_enabled || sprite_enabled)))
				v_sel_cntr <= v_reg; // hopefully good with timing
		else if (vt_cntr2 == 2'b11)
			v_sel_cntr <= ~v_sel_cntr;
end

//Fine vertical scroll (FV) counter
reg [2:0] fv_cntr; 

localparam FINE_VERTICAL_CNT_UP = 11'd1155;			//(128 + 4*257) - 1 = 1155

always @(posedge clk) 
begin
	if (rst)
		fv_cntr <= 3'd0;
	else
		if ((second_write && vram_addr_wr)
			|| ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr >= START_OF_V_COPY) && (x_rendercntr <= END_OF_V_COPY) && (background_enabled || sprite_enabled)))
				fv_cntr <= fv_reg; 
		else if (((bgrender_state == BG_MSB) && (x_rendercntr == FINE_VERTICAL_CNT_UP))
				|| (( vram_addr_wr || vram_data_rd ) && (bgrender_state != VBLANK) && (background_enabled || sprite_enabled))
				|| ((vram_addr_wr || vram_data_rd) && (bgrender_state == VBLANK) && (~vram_address_inc_sel)))
					fv_cntr <= fv_cntr + 1;
end

// name_table addr
assign ppu_nt_addr = {fv_cntr, v_sel_cntr, h_sel_cntr, vt_cntr, ht_cntr};
assign ppu_at_addr = {3'b000, v_sel_cntr, h_sel_cntr, 4'b1111, vt_cntr[4:2], ht_cntr[4:2]}; // 3 zero for the same address size
assign bg_lsb_addr = {2'b00, background_pattern_sel, tile_index_reg, 1'b0, fv_cntr}; //one extra 0 for tha same address size
assign bg_msb_addr = {2'b00, background_pattern_sel, tile_index, 1'b1, fv_cntr}; //one extra 0 for tha same address size

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
//* addr out mux					                                          *
//*****************************************************************************

//we need to do this
//assign ppu_mem_addr = ppu_bg_addr_fetch;

endmodule
