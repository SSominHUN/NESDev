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
    input wire valid_sprite, // if sprite is invalid then 00 invisible sprite
    input wire [3:0] sprite_attr_in, // 3 - horizontal flip, 2 - Priority (0: in front of background; 1: behind background), 1-0 attribute
    input wire [7:0] sprite_x_in,
    input wire [7:0] pattern_in,

    //Data out
    output wire [3:0] sprite_pixel,
    output wire       sprite_priority
    );

reg [7:0] pixel_cnt = 8'd0;

always @(posedge clk) 
begin
    if (rst)
        pixel_cnt <= 8'd0;
    else
        if (next_pixel && bground_read) // we count only when we are in bg read to get the realy pixel cnt
            pixel_cnt <= pixel_cnt + 1;
end

reg [7:0] sprite_lsb_reg;

always @ (posedge clk) 
begin
    if (rst)
        sprite_lsb_reg <= 8'd0;
    else
        if (pattern0_ld)
            sprite_lsb_reg <= ppu_mem_din;
end

reg [7:0] sprite_lsb_buff_reg;

always @ (posedge clk) 
begin
    if (rst)
        sprite_lsb_buff_reg <= 8'd0;
    else
        if (pattern1_ld)
            sprite_lsb_buff_reg <= bg_lsb_reg;
		else if (next_pixel && bground_read && (pixel_cnt >= sprite_x_coord) && (pixel_cnt <= sprite_x_coord + 8))
                if(sprite_attr_in[3])
					sprite_lsb_buff_reg <= {sprite_lsb_buff_reg[6:0], sprite_lsb_buff_reg[7]};
                else
                    sprite_lsb_buff_reg <= {sprite_lsb_buff_reg[0], sprite_lsb_buff_reg[7:1]};
end

reg [7:0] sprite_msb_reg;

always @ (posedge clk) 
begin
    if (rst)
        sprite_msb_reg <= 8'd0;
    else
        if (pattern1_ld)
            sprite_msb_reg <= ppu_mem_din;
		else if (next_pixel && bground_read (pixel_cnt >= sprite_x_coord) && (pixel_cnt <= sprite_x_coord + 8))
                if (sprite_attr_in[3])
					sprite_msb_reg <= {sprite_msb_reg[6:0], sprite_msb_reg[7]};
                else
                    sprite_msb_reg <= {sprite_msb_reg[0], sprite_msb_reg[7:1]};
end

assign sprite_pixel = (valid_sprite) ? ((sprite_attr_in[3]) ? ({sprite_attr_in[1:0], sprite_msb_reg[7], sprite_lsb_buff_reg[7]}) : ({sprite_attr_in[1:0], sprite_msb_reg[0], sprite_lsb_buff_reg[0]})) 
                        : (4'b0000);

assign sprite_priority = sprite_attr_in[2] && valid_sprite; // if sprite does not exist it cant hurt you

endmodule
