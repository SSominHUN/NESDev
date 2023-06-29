`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:08 05/14/2023 
// Design Name: 
// Module Name:    ppu_rendering_FSM 
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

module ppu_rendering_FSM(
    input clk, // 25MHz 
    input rst,
    input ppu_en,
    input cpu_en
    );

parameter END_OF_RENDERING_LINE = 11'd1599;
parameter PRERENDERING_ROW = 9'd261;
parameter FIRST_RENDERING_ROW = 9'd0;

//ppu background rendering counters
reg [10:0] x_rendercntr;
reg [8:0] y_renderingcntr;
//nes x rendering
always @ (posedge clk)
begin
	if (rst || (x_rendercntr == END_OF_RENDERING_LINE))
		x_rendercntr <= 11'd0;
	else
		x_rendercntr <= x_rendercntr + 11'd1;
end
//original nes y rendering
always @ (posedge clk)
begin
	if (rst)
		y_renderingcntr <= PRERENDERING_ROW;
	else if (x_rendercntr == END_OF_RENDERING_LINE)
		if (y_renderingcntr == PRERENDERING_ROW)
			y_renderingcntr <= 9'd0;
		else 
			y_renderingcntr <= y_renderingcntr + 11'd1;
end

reg oddframe;
// We find odd frames to render
always@(posedge clk)
begin
	if (rst)
		oddframe <= 1'd0;
	else 
		if ((y_renderingcntr == PRERENDERING_ROW) && (x_rendercntr == END_OF_RENDERING_LINE))
			oddframe <= ~oddframe;
end

//FSM for BG rendering
parameter SLEEP  = 3'b000;
parameter IDLE = 3'b001;
parameter NT = 3'b010;
parameter AT = 3'b011;
parameter BG_LSB = 3'b100;
parameter BG_MSB = 3'b101;
parameter VBLANK = 3'b110;

parameter FIRST_SCANLINE_PIXEL = 11'd127;
parameter START_OF_LAST_NT = 11'd1482; 
parameter END_OF_BG_RENDERING_LINE = 11'd1490;
parameter BG_NEXT_STEP_CONDITION = 3'b011;

parameter ODDFRAME_END_OF_FIRST_NT = 11'd131;
parameter ODDFRAME_END_OF_BG_RENDERING_LINE = 11'd1486;

parameter END_OF_VISIBLE_FRAME_ROW = 9'd239;
parameter END_OF_VBLANK_ROW = 9'd260;

reg [2:0] bgrender_state;
reg [2:0] next_state;

always@(posedge clk)
begin
	if(rst)
		bgrender_state <= SLEEP;
	else
		bgrender_state <= next_state;
end

//PPU BG rendering state machine with oddframe changes
always @ (*)
begin
	case (bgrender_state)
		SLEEP: begin
			if ((x_rendercntr == END_OF_RENDERING_LINE) && (y_renderingcntr == END_OF_VISIBLE_FRAME_ROW))
				next_state <= VBLANK;
			else if ((x_rendercntr == FIRST_SCANLINE_PIXEL) && oddframe && (y_renderingcntr == FIRST_RENDERING_ROW))
				next_state <= NT;
			else if (x_rendercntr == FIRST_SCANLINE_PIXEL)
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT: begin
			if ((x_rendercntr == END_OF_BG_RENDERING_LINE) 
			|| ((y_renderingcntr == PRERENDERING_ROW) && oddframe && (x_rendercntr == ODDFRAME_END_OF_BG_RENDERING_LINE)))
				next_state <= SLEEP;
				// ODDFRAME_END_OF_FIRST_NT is good here because x_rendercntr will always be higher then this just in the first line 
			else if ((x_rendercntr == ODDFRAME_END_OF_FIRST_NT) || (x_rendercntr == START_OF_LAST_NT))
				next_state <= NT;
			else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= AT;
			else
				next_state <= NT;
		end
		AT: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_LSB;
			else
				next_state <= AT;
		end
		BG_LSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_MSB;
			else
				next_state <= BG_LSB;
		end
		BG_MSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= BG_MSB;
		end
		VBLANK: begin
			if ((x_rendercntr == END_OF_RENDERING_LINE) && (y_renderingcntr == END_OF_VBLANK_ROW))
				next_state <= SLEEP;
			else
				next_state <= VBLANK;
		end
		default:
			next_state <= 3'bxxx;
	endcase
end

/*
// BG rendering without oddframe counting withou VBLANK
always @ (*)
begin
	case (bgrender_state)
		SLEEP: begin
			if ((x_rendercntr == FIRST_SCANLINE_PIXEL) 
			&& ((y_renderingcntr == PRERENDERING_ROW) || (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW)))
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT: begin
			if (x_rendercntr == END_OF_BG_RENDERING_LINE)
				next_state <= SLEEP;
			else if (x_rendercntr == START_OF_LAST_NT)
				next_state <= NT;
			else if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= AT;
			else
				next_state <= NT;
		end
		AT: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_LSB;
			else
				next_state <= AT;
		end
		BG_LSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= BG_MSB;
			else
				next_state <= BG_LSB;
		end
		BG_MSB: begin
			if (x_rendercntr[2:0] == BG_NEXT_STEP_CONDITION)
				next_state <= NT;
			else
				next_state <= BG_MSB;
		end
		default:
			next_state <= 3'bxxx;
	endcase
end
*/


endmodule
