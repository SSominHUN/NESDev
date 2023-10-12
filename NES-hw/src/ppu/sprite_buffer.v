`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:43 10/11/2023 
// Design Name: 
// Module Name:    sprite_buffer 
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
module sprite_buffer(
    //Clock and reset
    input wire clk,
    input wire rst,

    // input controll signals
    input wire bground_read,
    input wire next_pixel,
    input wire pattern0_ld,
    input wire pattern1_ld,

    //Data input
    input wire valid_sprite,
    input wire [3:0] sprite_attr_in,
    input wire [7:0] sprite_x_in,
    input wire [7:0] pattern_in,

    //Data out
    output wire [3:0] sprite_pixel,
    output wire       sprite_priority
    );

reg [7:0] bg_lsb_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_lsb_reg <= 8'd0;
    else
        if (pattern0_ld)
            bg_lsb_reg <= ppu_mem_din;
end

reg [7:0] bg_lsb_buff_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_lsb_buff_reg <= 8'd0;
    else
        if (pattern1_ld)
            bg_lsb_buff_reg <= bg_lsb_reg; // shift reg
		else if (next_pixel)
					bg_lsb_buff_reg <= {bg_lsb_buff_reg[6:0], bg_lsb_buff_reg[7]};
end

reg [7:0] bg_msb_reg;

always @ (posedge clk) 
begin
    if (rst)
        bg_msb_reg <= 8'd0;
    else
        if (pattern1_ld)
            bg_msb_reg <= ppu_mem_din;
		else if (next_pixel)
					bg_msb_reg <= {bg_msb_reg[6:0], bg_msb_reg[7]};
end




endmodule
