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

parameter end_of_rendering_line = 11'd1599;
parameter prerendering_row = 9'd261;
parameter first_rendering_row = 9'd1;

//ppu background rendering counters
reg [10:0] x_rendercntr;
reg [8:0] y_renderingcntr;
//nes x rendering
always @ (posedge clk)
begin
	if (rst || (x_rendercntr == end_of_rendering_line))
		x_rendercntr <= 11'd0;
	else
		x_rendercntr <= x_rendercntr + 1;
end
//original nes y rendering
always @ (posedge clk)
begin
	if (rst) begin
		y_renderingcntr <= prerendering_row;
	end else if ((y_renderingcntr == prerendering_row) && (x_rendercntr == end_of_rendering_line)) begin
		y_renderingcntr <= 9'd0;
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
	else if ((y_renderingcntr == prerendering_row) && (x_rendercntr == end_of_rendering_line))
		oddframe <= oddframe + 1;
end

//FSM for BG rendering
parameter SLEEP  = 3'b000;
parameter IDLE = 3'b001;
parameter NT = 3'b010;
parameter AT = 3'b011;
parameter BG_Lsb = 3'b100;
parameter BG_Msb = 3'b101;
parameter VBLANK = 3'b110;

parameter start_rendering_line = 11'd127; 
parameter start_of_last_NT = 11'd1482; 
parameter end_of_BG_renderingline = 11'd1490;
parameter bg_next_step_condition = 3'b011;

parameter oddframe_end_of_first_NT = 11'd131;
parameter oddframe_end_of_BG_renderingline = 11'd1486;

parameter end_of_visible_frame_row = 9'd239;
parameter end_of_VBLANK_row = 9'd260;

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
			if ((x_rendercntr == end_of_rendering_line) && (y_renderingcntr == end_of_visible_frame_row))
				next_state <= VBLANK;
			else if ((x_rendercntr == start_rendering_line) && oddframe && (y_renderingcntr == first_rendering_row))
				next_state <= NT;
			else if (x_rendercntr == start_rendering_line)
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT: begin
			if ((x_rendercntr == end_of_BG_renderingline) || ((y_renderingcntr == prerendering_row) && oddframe && (x_rendercntr == oddframe_end_of_BG_renderingline)))
				next_state <= SLEEP;
				// oddframe_end_of_first_NT is good here because x_rendercntr will always be higher then this just in the first line 
			else if ((x_rendercntr == oddframe_end_of_first_NT) || (x_rendercntr == start_of_last_NT))
				next_state <= NT;
			else if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= AT;
			else
				next_state <= NT;
		end
		AT: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= BG_Lsb;
			else
				next_state <= AT;
		end
		BG_Lsb: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= BG_Msb;
			else
				next_state <= BG_Lsb;
		end
		BG_Msb: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= NT;
			else
				next_state <= BG_Msb;
		end
		VBLANK: begin
			if ((x_rendercntr == end_of_rendering_line) && (y_renderingcntr == end_of_VBLANK_row))
				next_state <= SLEEP;
			else
				next_state <= VBLANK;
		end
		default:
			next_state <= 3'bxxx;
	endcase
end

// BG rendering without oddframe counting withou VBLANK
always @ (*)
begin
	case (bgrender_state)
		SLEEP: begin
			if (x_rendercntr == start_rendering_line && ((y_renderingcntr == prerendering_row) || (y_renderingcntr <= end_of_visible_frame_row)))
				next_state <= IDLE;
			else
				next_state <= SLEEP;
		end
		IDLE: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= NT;
			else
				next_state <= IDLE;
		end
		NT: begin
			if (x_rendercntr == end_of_BG_renderingline)
				next_state <= SLEEP;
			else if (x_rendercntr == start_of_last_NT)
				next_state <= NT;
			else if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= AT;
			else
				next_state <= NT;
		end
		AT: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= BG_Lsb;
			else
				next_state <= AT;
		end
		BG_Lsb: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= BG_Msb;
			else
				next_state <= BG_Lsb;
		end
		BG_Msb: begin
			if (x_rendercntr[2:0] == bg_next_step_condition)
				next_state <= NT;
			else
				next_state <= BG_Msb;
		end
		default:
			next_state <= 3'bxxx;
	endcase
end

endmodule
