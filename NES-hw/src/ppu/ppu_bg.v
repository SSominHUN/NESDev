`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:08 05/14/2023 
// Design Name: 
// Module Name:    ppu_bg 
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

module ppu_bg(
    input clk, // 25MHz 
    input rst,
    input ppu_en,
    input cpu_en
    );

parameter end_of_rendering_line = 11'd1599;
parameter prerendering_row = 9'd261;

//ppu background rendering counters
reg [10:0] x_rendercntr;
reg [8:0] y_renderingcntr;
//nes x rendering
always @ (posedge clk)
begin
	if (rst | x_rendercntr == end_of_rendering_line)
		x_rendercntr <= 11'd0;
	else
		x_rendercntr <= x_rendercntr + 1;
end
//original nes y rendering
always@(posedge clk)
begin
	if(rst)
		y_renderingcntr <= 9'd261; // we start with -1 Pre-Rendering
	else if(y_renderingcntr == 9'd261 & x_rendercntr[9:0] == 10'd681) // 262
		y_renderingcntr <= 9'd0;
//From 240 we don't render 2 line
	else if(y_renderingcntr >= 9'd240)begin
		if (x_rendercntr[9:0] == 10'd681) // 682
			y_renderingcntr <= y_renderingcntr + 1;
	end
	else if (x_rendercntr == 11'd1363)
		y_renderingcntr <= y_renderingcntr + 1;
end

always @ (posedge clk)
begin
	if (rst) begin
		y_renderingcntr <= prerendering_row;
	end else if (x_rendercntr == end_of_rendering_line) begin
		y_renderingcntr <= y_renderingcntr +1;
	end
end

reg oddframe;
// We find odd frames to render
always@(posedge clk)
begin
	if (rst)
		oddframe <= 1'd0;
	else if (y_renderingcntr == 9'd261)
		oddframe <= oddframe + 1;
end

//FSM for BG rendering
parameter IDLE = 4'b0000;
parameter NT = 4'b0001;
parameter AT = 4'b0010;
parameter BG_Lsb = 4'b0011;
parameter BG_Msb = 4'b0100;
parameter GB_NT_1 = 4'b0101;
parameter GB_NT_2 = 4'b0110;
parameter SP_Lsb  = 4'b0111;
parameter SP_Msb  = 4'b1000;
parameter SLEEP  = 4'b1001; // in this state the ppu and the cpu is not enabled
parameter VBLANK = 4'b1010;

reg [3:0] bgrender_state;
reg [3:0] next_state;


always@(posedge clk)
begin
	if(rst)
		bgrender_state <= IDLE;
	else
		bgrender_state <= next_state;
end

//rendering in visible frame
always@(*)
begin
	case (bgrender_state)
		IDLE:begin
			if (x_rendercntr[1:0] == 2'b01) // stay in visible frame or Pre rendering maybe should use this (& y_renderingcntr <= 9'd239 | x_rendercntr[1:0] == 2'b01 & y_renderingcntr == 9'd261)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT:begin
			if (x_rendercntr[9:0] == 10'd681 & y_renderingcntr == 9'd261)begin // (341*2)-1 = 681 odd frame jump to NT in the last line of PPU rendering
				if(oddframe)
					next_state <= NT;
				else
					next_state <= IDLE;
			end
			else if (x_rendercntr[9:0] == 10'd681 & y_renderingcntr <= 9'd239) // (341*2)-1 = 681 sleep just between 0-239
				next_state <= SLEEP;
			else if (x_rendercntr[9:0] == 10'd677) // (339*2)-1 = 677
				next_state <= NT;
			else if (x_rendercntr[1:0] == 2'b01) 
				next_state <= AT;
			else 
				next_state <= NT;
		end
		AT:begin
			if (x_rendercntr[1:0] == 2'b01) 
				next_state <= BG_Lsb;
			else
				next_state <= AT;
		end
		BG_Lsb:begin
			if (x_rendercntr[1:0] == 2'b01) 
				next_state <= BG_Msb;
			else
				next_state <= BG_Lsb;
		end
		BG_Msb:begin
			if (x_rendercntr[9:0] == 10'd513) // (257*2)-1 = 513
				next_state <= GB_NT_1;
			else if (x_rendercntr[1:0] == 2'b01) 
				next_state <= NT;
			else
				next_state <= BG_Msb;
		end
		GB_NT_1:begin
			if (x_rendercntr[1:0] == 2'b01) 
				next_state <= GB_NT_2;
			else
				next_state <= GB_NT_1;
		end
		GB_NT_2:begin
			if (x_rendercntr[1:0] == 2'b01) 
				next_state <= SP_Lsb;
			else
				next_state <= GB_NT_2;
		end
		SP_Lsb:begin
			if (x_rendercntr[1:0] == 2'b01) 
				next_state <= SP_Msb;
			else
				next_state <= SP_Lsb;
		end
		SP_Msb:begin
			if (x_rendercntr[9:0] == 10'b641) // (321*2)-1 = 641
				next_state <= NT;
			else if (x_rendercntr[1:0] == 2'b01) 
				next_state <= GB_NT_1;
			else
				next_state <= SP_Msb;
		end
//PPU and CPU en off just VGA rendering goes
		SLEEP:begin
			if (x_rendercntr == 11'd1363 & y_renderingcntr == 9'd239)
				next_state <= VBLANK;
			else if (x_rendercntr == 11'd1363 & y_renderingcntr < 9'd239) // (341*4)-1 = 1363
				next_state <= IDLE;	
			else
				next_state <= SLEEP;
		end
//I take prost-rendering line and VBlank together just one bit set in thissection
		VBLANK:begin
			if (x_rendercntr[9:0] == 10'd681 & y_renderingcntr <= 9'd260) //(341*2)-1 = 681
				next_state <= IDLE;
			else 
				next_state <= VBLANK;
		end
		default:
			next_state <= 4'bxxxx;
	endcase
end



endmodule
