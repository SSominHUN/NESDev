`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:49 06/28/2023 
// Design Name: 
// Module Name:    vga_timing 
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

//******************************************************************************
//* 640 x 480 @ 60 Hz VGA időzítés generátor. *
//******************************************************************************
module vga_timing(
     //Órajel és reset.
    input wire clk, //Pixel órajel bemenet.
    input wire rst, //Reset bemenet.
    input wire en,

    //Az aktuális pixel pozíció.
    output reg [9:0] h_cnt = 10'd0, //X-koordináta.
    output reg [9:0] v_cnt = 10'd0, //Y-koordináta.

    //Szinkron és kioltó jelek.
    output reg h_sync = 1'b1, //Horizontális szinkron pulzus.
    output reg v_sync = 1'b0, //Vertikális szinkron pulzus.
    output wire blank //Kioltó jel.
);

//******************************************************************************
//* Időzítési paraméterek. *
//******************************************************************************
localparam H_VISIBLE = 10'd640;
localparam H_FRONT_PORCH = 10'd16;
localparam H_SYNC_PULSE = 10'd96;
localparam H_BACK_PORCH = 10'd48;

localparam V_VISIBLE = 10'd480;
localparam V_FRONT_PORCH = 10'd10;
localparam V_SYNC_PULSE = 10'd2;
localparam V_BACK_PORCH = 10'd32; // +3 there is 524 line in  (29)

localparam H_BLANK_BEGIN = H_VISIBLE - 1;
localparam H_SYNC_BEGIN = H_BLANK_BEGIN + H_FRONT_PORCH;
localparam H_SYNC_END = H_SYNC_BEGIN + H_SYNC_PULSE;
localparam H_BLANK_END = H_SYNC_END + H_BACK_PORCH;

localparam V_BLANK_BEGIN = V_VISIBLE - 1;
localparam V_SYNC_BEGIN = V_BLANK_BEGIN + V_FRONT_PORCH;
localparam V_SYNC_END = V_SYNC_BEGIN + V_SYNC_PULSE;
localparam V_BLANK_END = V_SYNC_END + V_BACK_PORCH;

//******************************************************************************
//* A horizontális és vertikális számlálók. *
//******************************************************************************
always @(posedge clk)
begin
    if (rst || (h_cnt == H_BLANK_END))
        h_cnt <= 10'd0;
    else
        if (en)
            h_cnt <= h_cnt + 10'd1;
end

always @(posedge clk)
begin
    if (rst)
        v_cnt <= 10'd0;
    else
        if (h_cnt == H_BLANK_END)
            if (v_cnt == V_BLANK_END)
                v_cnt <= 10'd0;
            else
                if(en)
                    v_cnt <= v_cnt + 10'd1;
end

//******************************************************************************
//* A szinkron pulzusok generálása. *
//******************************************************************************
always @(posedge clk)
begin
    if (rst || (h_cnt == H_SYNC_END))
        h_sync <= 1'b1;
    else
        if (h_cnt == H_SYNC_BEGIN)
            h_sync <= 1'b0;
end
always @(posedge clk)
begin
    if (rst)
        v_sync <= 1'b0;
    else
        if (h_cnt == H_BLANK_END)
            if (v_cnt == V_SYNC_BEGIN)
                v_sync <= 1'b1;
            else
                if (v_cnt == V_SYNC_END)
                    v_sync <= 1'b0;
end
//******************************************************************************
//* A kioltó jel előállítása. *
//******************************************************************************
reg h_blank = 1'b0;
reg v_blank = 1'b0;

always @(posedge clk)
begin
    if (rst || (h_cnt == H_BLANK_END))
        h_blank <= 1'b0;
    else
        if (h_cnt == H_BLANK_BEGIN)
            h_blank <= 1'b1;
end

always @(posedge clk)
begin
    if (rst)
        v_blank <= 1'b0;
    else
        if (h_cnt == H_BLANK_END)
            if (v_cnt == V_BLANK_BEGIN)
                v_blank <= 1'b1;
            else
                if (v_cnt == V_BLANK_END)
                    v_blank <= 1'b0;
end

assign blank = h_blank | v_blank;

endmodule
