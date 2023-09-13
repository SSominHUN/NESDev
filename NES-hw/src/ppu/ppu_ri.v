`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:07 07/24/2023 
// Design Name: 
// Module Name:    ppu_ri 
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
module ppu_ri(
    input  wire        clk,        // 25 MHz
    input  wire        rst,        // reset signal
    input  wire 	   ph1_rising,
	input  wire		   ph1_falling,
	input  wire		   ph2_rising,
	input  wire		   ph2_falling,

    //input  wire        vblank_in,         // high during vertical blank

    // PPU interface for memory access
	input  wire [ 7:0] ppu_mem_din,
    input  wire [13:0] ppu_mem_addr, 
	output wire [ 7:0] ppu_mem_dout,
    output wire 	   ppu_mem_wr_req,
	output wire 	   ppu_mem_rd_req,
	
    //input  wire [ 7:0] spr_ram_d_in,      // sprite ram data (for 0x2004 reads)
    //input  wire        spr_overflow_in,   // more than 8 sprites hit on a scanline during last frame
    //input  wire        spr_pri_col_in,    // primary object collision in last frame

    // register interface or interface to cpu
	input  wire [ 2:0] slv_mem_addr,      // register interface reg select (#2000-#2007)
	input  wire        slv_mem_cs,       // register interface enable (#2000 - #3FFF just when it is active)
	input  wire        slv_mem_rnw,       // register interface cpu read not write
	input  wire [ 7:0] slv_mem_din,       // register interface data in (cpu data lane)
	output wire [ 7:0] slv_mem_dout       // register interface data out (cpu data lane)
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

wire vram_address_inc_sel   = control_reg[0]; //  
wire sprite_pattern_sel     = control_reg[1]; // Sprite pattern table address for 8x8 sprites
wire background_pattern_sel = control_reg[2]; // Background pattern table address (0: $0000; 1: $1000)
wire sprite_size            = control_reg[3]; // 0: 8x8 pixels; 1: 8x16 pixels
wire vram_irq_enable        = control_reg[4]; // Generate an NMI at the start of the vertical blanking interval (0: off; 1: on)

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
        irq <= interupt_flag & vblank_irq_enable; //irq is missing yet where is it??
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



/*
reg [2:0] fv;   // fine vertical scroll latch
reg [4:0] vt;   // vertical tile index latch
reg [2:0] fh;   // fine horizontal scroll latch
reg [4:0] ht;   // horizontal tile index latch
reg       s;    // playfield pattern table selection latch

//
// Output Latches
//
reg [7:0] cpu_d_out;      // output data bus latch for 0x2007 reads
reg       upd_cntrs_out;  // output latch for upd_cntrs_out


reg nmi_en;            // 0x2000[7]: enables an NMI interrupt on vblank

reg spr_size;          // 0x2000[5]: select 8/16 scanline high sprites
reg spr_pt_sel;        // 0x2000[3]: sprite pattern table select (0: $0000; 1: $1000; ignored in 8x16 mode)
reg addr_incr;         // 0x2000[2]: amount to increment addr on 0x2007 access.
                                        // (0: add 1, going across; 1: add 32, going down)
reg nt_h;    // horizontal name table, selection latch          0x2000[1]-> base NT address
reg nt_v;    // vertical name table, selection latch            0x2000[0]-> base NT address
                            // (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
// 0x2000[6]-> master/slave select, 0x2000[4]-> background pattern table address

reg emphasize_blue;       // 0x2001[7]: Emphasize blue
reg emphasize_green;      // 0x2001[6]: Emphasize green 
reg emphasize_red;        // 0x2001[5]: Emphasize red 
reg spr_en;               // 0x2001[4]: enables sprite rendering
reg bg_en;                // 0x2001[3]: enables background rendering
reg spr_ls_clip;          // 0x2001[2]: left side screen column (8 pixel) object clipping
reg bg_ls_clip;           // 0x2001[1]: left side screen column (8 pixel) bg clipping
// 0x2001[0]: Greyscale (0: normal color, 1: produce a greyscale display)

// spr_overflow_in, spr_pri_col_in
reg vblank;               // 0x2002[7]: indicates a vblank is occurring

//
// Internal State Registers
//
reg       byte_sel;   // tracks if next 0x2005/0x2006 write is high or low byte
reg [7:0] rd_buf;     // internal latch for buffered 0x2007 reads
reg       rd_rdy;     // controls q_rd_buf updates
reg [7:0] spr_ram_a;  // sprite ram pointer (set on 0x2003 write)

// detect falling edges
reg       q_ncs_in;                  // last ncs signal
reg       q_vblank_in;               // last vblank_in signal

always @ (posedge clk)
begin
    if (rst)
      q_ncs_in      <= 1'b1;
    else
      q_ncs_in      <= ncs_in;
end

parameter PPUCTRL = 3'd0;
parameter PPUMASK = 3'd1;
parameter PPUSTATUS = 3'd2;
parameter OAMADDR = 3'd3;
parameter OAMDATA = 3'd4;
parameter PPUSCROLL = 3'd5;
parameter PPUADDR = 3'd6;
parameter PPUDATA = 3'd7;
*/

/*
always @ (posedge clk)
begin
    if (rst)
    begin
        //reset all the registers
        
    end
    else
    begin
        // detection of ncs once because CPU is slower then PPU
        if (q_ncs_in & ~ncs_in)
        begin
            if (r_nw_in) // if we performew a read
            begin
                case(sel_in)
                    PPUSTATUS: begin
                        
                    end
                    OAMDATA: begin
                        
                    end
                    PPUDATA: begin
                        
                    end
                endcase
            end
            else // if we performe a write
            begin
                case(sel_in)
                    PPUCTRL: begin
                        
                    end
                    PPUMASK: begin
                        
                    end
                    OAMADDR: begin
                        
                    end
                    OAMDATA: begin
                        
                    end
                    PPUSCROLL:begin
                        
                    end
                    PPUADDR:begin
                        
                    end
                    PPUDATA:begin
                        
                    end
                endcase
            end
        end
    end
end
*/
endmodule
