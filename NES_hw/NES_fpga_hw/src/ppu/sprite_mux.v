`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:09 10/16/2023 
// Design Name: 
// Module Name:    sprite_mux 
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
module sprite_mux(
    //input controll signals
    input wire sprite_enabled,
    input wire no_sprite_clip, // 1 we see the pixels
    input wire first_column, //first background

    //data input
    //input wire [3:0] sprite_buff_pixel [7:0],
    input wire [3:0] sprite_pixel_0,
    input wire [3:0] sprite_pixel_1,
    input wire [3:0] sprite_pixel_2,
    input wire [3:0] sprite_pixel_3,
    input wire [3:0] sprite_pixel_4,
    input wire [3:0] sprite_pixel_5,
    input wire [3:0] sprite_pixel_6,
    input wire [3:0] sprite_pixel_7,
    input wire [7:0] sprite_priority_buff,

    //data outputs
    output reg [3:0] sprite_pixel,
    output reg       sprite_priority
    );

wire [7:0] sprite_sel = {(|sprite_pixel_7[1:0]), 
                         (|sprite_pixel_6[1:0]),
                         (|sprite_pixel_5[1:0]),
                         (|sprite_pixel_4[1:0]),
                         (|sprite_pixel_3[1:0]),
                         (|sprite_pixel_2[1:0]),
                         (|sprite_pixel_1[1:0]),
                         (|sprite_pixel_0[1:0])};

always @(*) 
begin
    if (~sprite_enabled | (~no_sprite_clip && first_column))
        sprite_pixel <= 4'b0000;
    else
        casex (sprite_sel)
            8'bxxxxxxx1: sprite_pixel <= sprite_pixel_0;
            8'bxxxxxx10: sprite_pixel <= sprite_pixel_1;
            8'bxxxxx100: sprite_pixel <= sprite_pixel_2;
            8'bxxxx1000: sprite_pixel <= sprite_pixel_3;
            8'bxxx10000: sprite_pixel <= sprite_pixel_4;
            8'bxx100000: sprite_pixel <= sprite_pixel_5;
            8'bx1000000: sprite_pixel <= sprite_pixel_6;
            8'b10000000: sprite_pixel <= sprite_pixel_7; 
            default: sprite_pixel <= 4'b0000;
        endcase    
end

always @(*) 
begin
    if (~sprite_enabled | (~no_sprite_clip && first_column))
        sprite_priority <= 1'b1;
    else
        casex (sprite_sel)
            8'bxxxxxxx1: sprite_priority <= sprite_priority_buff[0];
            8'bxxxxxx10: sprite_priority <= sprite_priority_buff[1];
            8'bxxxxx100: sprite_priority <= sprite_priority_buff[2];
            8'bxxxx1000: sprite_priority <= sprite_priority_buff[3];
            8'bxxx10000: sprite_priority <= sprite_priority_buff[4];
            8'bxx100000: sprite_priority <= sprite_priority_buff[5];
            8'bx1000000: sprite_priority <= sprite_priority_buff[6];
            8'b10000000: sprite_priority <= sprite_priority_buff[7]; 
            default: sprite_priority <= 1'b1; // back ground is rendered in the front
        endcase
end

endmodule
