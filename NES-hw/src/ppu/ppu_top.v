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
	input wire       clk,

	// PPU interface for memory acess
	input wire [7:0] data_in, 
	output wire [7:0] data_out,
	output wire [13:0] addr,
	output wire write_request,
	output wire read_request
	);


endmodule
