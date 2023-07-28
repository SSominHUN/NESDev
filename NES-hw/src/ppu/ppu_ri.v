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
    input  wire        clk,           // 25 MHz
    input  wire        rst_in,        // reset signal

    input  wire        vblank_in,         // high during vertical blank

    // PPU interface for memory acess
	input  wire [ 7:0] ppu_d_in,
    input  wire [13:0] ppu_addr, 
	output wire [ 7:0] ppu_d_out,
    output wire 	   write_request,
	output wire 	   read_request,
	
    input  wire [ 7:0] spr_ram_d_in,      // sprite ram data (for 0x2004 reads)
    input  wire        spr_overflow_in,   // more than 8 sprites hit on a scanline during last frame
    input  wire        spr_pri_col_in,    // primary object collision in last frame

    // register interface or interface to cpu
	input  wire [ 2:0] sel_in,         // register interface reg select (#2000-#2007)
	input  wire        ncs_in,         // register interface enable (#2000 - #3FFF just when it is active)
	input  wire        r_nw_in,        // register interface cpu read not write
	input  wire [ 7:0] cpu_d_in,       // register interface data in (cpu data lane)
	output wire [ 7:0] cpu_d_out       // register interface data out (cpu data lane)
    );


//*****************************************************************************
//* Scroll Registers                                                          *
//*****************************************************************************
reg [2:0] q_fv,  d_fv;   // fine vertical scroll latch
reg [4:0] q_vt,  d_vt;   // vertical tile index latch
reg [2:0] q_fh,  d_fh;   // fine horizontal scroll latch
reg [4:0] q_ht,  d_ht;   // horizontal tile index latch
reg       q_s,   d_s;    // playfield pattern table selection latch

//
// Output Latches
//
reg [7:0] q_cpu_d_out,     d_cpu_d_out;      // output data bus latch for 0x2007 reads
reg       q_upd_cntrs_out, d_upd_cntrs_out;  // output latch for upd_cntrs_out

//*****************************************************************************
//* External State Registers                                                  *
//*****************************************************************************
reg q_nmi_en,      d_nmi_en;            // 0x2000[7]: enables an NMI interrupt on vblank

reg q_spr_size,    d_spr_size;          // 0x2000[5]: select 8/16 scanline high sprites
reg q_spr_pt_sel,  d_spr_pt_sel;        // 0x2000[3]: sprite pattern table select (0: $0000; 1: $1000; ignored in 8x16 mode)
reg q_addr_incr,   d_addr_incr;         // 0x2000[2]: amount to increment addr on 0x2007 access.
                                        // (0: add 1, going across; 1: add 32, going down)
reg       q_h,      d_h;    // horizontal name table, selection latch          0x2000[1]-> base NT address
reg       q_v,      d_v;    // vertical name table, selection latch            0x2000[0]-> base NT address
                            // (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
// 0x2000[6]-> master/slave select, 0x2000[4]-> background pattern table address

reg q_emphasize_blue,   d_emphasize_blue;       // 0x2001[7]: Emphasize blue
reg q_emphasize_green,  d_emphasize_green;      // 0x2001[6]: Emphasize green 
reg q_emphasize_red,    d_emphasize_red;        // 0x2001[5]: Emphasize red 
reg q_spr_en,           d_spr_en;               // 0x2001[4]: enables sprite rendering
reg q_bg_en,            d_bg_en;                // 0x2001[3]: enables background rendering
reg q_spr_ls_clip,      d_spr_ls_clip;          // 0x2001[2]: left side screen column (8 pixel) object clipping
reg q_bg_ls_clip,       d_bg_ls_clip;           // 0x2001[1]: left side screen column (8 pixel) bg clipping
// 0x2001[0]: Greyscale (0: normal color, 1: produce a greyscale display)

// spr_overflow_in, spr_pri_col_in
reg q_vblank,           d_vblank;               // 0x2002[7]: indicates a vblank is occurring

//
// Internal State Registers
//
reg       q_byte_sel,  d_byte_sel;   // tracks if next 0x2005/0x2006 write is high or low byte
reg [7:0] q_rd_buf,    d_rd_buf;     // internal latch for buffered 0x2007 reads
reg       q_rd_rdy,    d_rd_rdy;     // controls q_rd_buf updates
reg [7:0] q_spr_ram_a, d_spr_ram_a;  // sprite ram pointer (set on 0x2003 write)

// detect falling edges
reg       q_ncs_in;                  // last ncs signal
reg       q_vblank_in;               // last vblank_in signal

always @ (posedge clk)
begin
    if (rst)
    begin
      q_ncs_in      <= 1'h1;  
    end
    else
    begin
      q_ncs_in      <= ncs_in;  
    end
end

always @ (*)
begin
    // detection of ncs once because CPU is slower then PPU
    if (q_ncs_in & ~ncs_in)
    begin
        
    end
end

endmodule
