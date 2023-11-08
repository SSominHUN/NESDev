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
    if (rst || ~bground_read) // reset
        pixel_cnt <= 8'd0;
    else
        if (next_pixel) // we count only when we are in bg read to get the realy pixel cnt
            pixel_cnt <= pixel_cnt + 8'd1;
end

reg saved_sprite_valid;

always @(posedge clk) 
begin
    if (rst)
        saved_sprite_valid <= 1'd0;
    else
        if (pattern0_ld)
            saved_sprite_valid <= valid_sprite; 
end

reg [3:0] saved_sprite_attr;

always @(posedge clk) 
begin
    if (rst)
        saved_sprite_attr <= 4'd0;
    else
        if (pattern0_ld)
            saved_sprite_attr <= sprite_attr_in; 
end

reg [7:0] saved_x_coord;

always @(posedge clk) 
begin
    if (rst)
        saved_x_coord <= 8'd0;
    else
        if (pattern0_ld)
            saved_x_coord <= sprite_x_in; 
end
/*
reg [7:0] cnt_down;

always @(posedge clk) 
begin
    if (rst)
        cnt_down <= 8'b0;
    else
        if (pattern0_ld)
            cnt_down <= sprite_x_in;
        else if (next_pixel & bground_read & (cnt_down != 0))
            cnt_down <= cnt_down - 1;
end
*/
/*
reg shr_enable;

always @(posedge clk) 
begin
    if (rst)
        shr_enable <= 1'b0;
    else
        if (scanline_begin)
            shr_enable <= 1'b1;     
end
*/
reg [7:0] sprite_lsb_reg;

always @ (posedge clk) 
begin
    if (rst)
        sprite_lsb_reg <= 8'd0;
    else
        if (pattern0_ld)
            sprite_lsb_reg <= pattern_in;
end

reg [7:0] sprite_lsb_buff_reg;


 // reset buffers in hblank after rendering line
always @ (posedge clk) 
begin
    if (rst)
        sprite_lsb_buff_reg <= 8'd0;
    else
        if (pattern1_ld)
            sprite_lsb_buff_reg <= sprite_lsb_reg;
		else if (next_pixel && bground_read && (pixel_cnt >= saved_x_coord)) // next_pixel && bground_read && (pixel_cnt >= saved_x_coord) cnt_down == 8'b0
                if((saved_sprite_attr[3]))
					sprite_lsb_buff_reg <= {1'b0, sprite_lsb_buff_reg[7:1]};
                else
                    sprite_lsb_buff_reg <= {sprite_lsb_buff_reg[6:0], 1'b0};
                    
end

reg [7:0] sprite_msb_reg;

always @ (posedge clk) 
begin
    if (rst)
        sprite_msb_reg <= 8'd0;
    else
        if (pattern1_ld)
            sprite_msb_reg <= pattern_in;
		else if (next_pixel && bground_read && (pixel_cnt >= saved_x_coord)) // next_pixel && bground_read && (pixel_cnt >= saved_x_coord) cnt_down == 8'b0
                if ((saved_sprite_attr[3]))
					sprite_msb_reg <= {1'b0, sprite_msb_reg[7:1]};
                else
                    sprite_msb_reg <= {sprite_msb_reg[6:0], 1'b0};
                    
end

//valid_sprite && (pixel_cnt >= sprite_x_in) && (pixel_cnt <= sprite_x_in + 8)
assign sprite_pixel = (saved_sprite_valid && (pixel_cnt >= saved_x_coord)) // && (pixel_cnt >= saved_x_coord)  cnt_down == 8'b0
                        ? ((saved_sprite_attr[3]) ? ({saved_sprite_attr[1:0], sprite_msb_reg[0], sprite_lsb_buff_reg[0]}) 
                        : ({saved_sprite_attr[1:0], sprite_msb_reg[7], sprite_lsb_buff_reg[7]})) 
                        : (4'b0000);

// && valid_sprite && (pixel_cnt >= sprite_x_in) && (pixel_cnt <= sprite_x_in + 8)
assign sprite_priority = saved_sprite_attr[2]; // if sprite does not exist it cant hurt you

endmodule
