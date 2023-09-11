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

	// register interface
	input  wire [ 2:0] ri_sel_in,     // register interface reg select (#2000-#2007)
	input  wire        ri_cs_in,      // register interface enable (#2000 - #3FFF just when it is active)
	input  wire        ri_r_nw_in,    // register interface cpu read not write
	input  wire [ 7:0] ri_d_in,       // register interface data in (cpu data lane)
	output wire [ 7:0] ri_d_out,      // register interface data out (cpu data lane)

	// PPU interface for memory acess
	input  wire [ 7:0] data_in, 
	output wire [ 7:0] data_out,
	output wire [13:0] addr,
	output wire 	   write_request,
	output wire 	   read_request
	);


endmodule
