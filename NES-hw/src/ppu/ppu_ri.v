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

//*****************************************************************************
//* External State Registers                                                  *
//*****************************************************************************
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

endmodule
