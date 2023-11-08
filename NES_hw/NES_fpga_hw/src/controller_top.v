`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:48 10/21/2023 
// Design Name: 
// Module Name:    controller_top 
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
module controller_top(
    //clock
    input wire clk,
    input wire rst,
    input wire ph2_falling,

    // CPU interface for memory acess master
	input 	wire 	[15:0] 		cpu_addr,
	input 	wire 				cpu_rnw, 
	output 	reg 	[7:0] 		cpu_data_out = 8'd0,
	input 	wire 	     		cpu_data_in, //just one bit the $4016 write strobe

    //controller output signals
    input  wire         controller_data1,    // joypad 1 input signal
    input  wire         controller_data2,    // joypad 2 input signal
    output reg          controller1_out_clk,      // joypad output clk signal
    output reg          controller2_out_clk,      // joypad output clk signal
    output wire         controller_out_latch     // joypad output latch signal
    );

//*****************************************************************************
//* Generating controll signals                                          	  *
//*****************************************************************************
localparam [15:0] CONTROLLER1_ADDR = 16'h4016;
localparam [15:0] CONTROLLER2_ADDR = 16'h4017;

//register write enable signals
wire shift_register_strobe_wr = ph2_falling & ~cpu_rnw & (cpu_addr == CONTROLLER1_ADDR);

wire controller1_rd = cpu_rnw && (cpu_addr == CONTROLLER1_ADDR);
wire controller2_rd = cpu_rnw && (cpu_addr == CONTROLLER2_ADDR);

//*****************************************************************************
//* controller latch register write                                           *
//*****************************************************************************
//(* iob = "force" *)
reg controller_latch;

always @(posedge clk) 
begin
    if (rst)
        controller_latch <= 1'b0;
    else
        if (shift_register_strobe_wr)
            controller_latch <= cpu_data_in;
end

assign controller_out_latch = controller_latch;

//*****************************************************************************
//* $4016 & $4017                                                             *
//* controller reads                                                          *
//*****************************************************************************

//(* iob = "force" *)
//reg controller_clk;

//assign controller_out_clk = controller_clk;

//assign controller1_out_clk = ~( cpu_rnw & (cpu_addr == CONTROLLER1_ADDR));
//assign controller2_out_clk = ~( cpu_rnw & (cpu_addr == CONTROLLER2_ADDR));

always @(posedge clk) 
begin
    controller1_out_clk <= ~( cpu_rnw & (cpu_addr == CONTROLLER1_ADDR));
    controller2_out_clk <= ~( cpu_rnw & (cpu_addr == CONTROLLER2_ADDR));
end

//controller 1 data sampling
reg [1:0] controller1_rd_req_shr = 2'b0;

always @(posedge clk) 
begin
    if(rst)
        controller1_rd_req_shr <= 2'b0;
    else
        if (controller1_rd)
            controller1_rd_req_shr <= {controller1_rd_req_shr[0], 1'b1};
        else
            controller1_rd_req_shr <= {controller1_rd_req_shr[0], 1'b0};
end


reg controller1_data_reg= 1'b1;

always @(posedge clk) 
begin
    if (rst)
        controller1_data_reg <= 1'b1;
    else
        if (controller1_rd_req_shr == 2'b01)
            controller1_data_reg <= ~controller_data1;      
end

//controller 2 data sampling
reg [1:0] controller2_rd_req_shr = 2'b0;

always @(posedge clk) 
begin
    if(rst)
        controller2_rd_req_shr <= 2'b0;
    else
        if (controller2_rd)
            controller2_rd_req_shr <= {controller2_rd_req_shr[0], 1'b1};
        else
            controller2_rd_req_shr <= {controller2_rd_req_shr[0], 1'b0};
end


reg controller2_data_reg = 1'b1;

always @(posedge clk) 
begin
    if (rst)
        controller2_data_reg <= 1'b1;
    else
        if (controller2_rd_req_shr == 2'b01)
            controller2_data_reg <= ~controller_data2;      
end

//mintavételezés a az olvasás engedélyezés felfutó élére cpu data out a két belső
wire [7:0] controller1_data = {7'd0, controller1_data_reg}; // ezeket alakítsd át
wire [7:0] controller2_data = {7'd0, controller2_data_reg};

wire [1:0] read_sel; 

assign read_sel[0] = controller1_rd;
assign read_sel[1] = controller2_rd;

always @(posedge clk) 
begin
	if (rst || ph2_falling)
		cpu_data_out <= 8'd0;
	else
        casex (read_sel)
            2'bx1: cpu_data_out <= controller1_data;
            2'b10: cpu_data_out <= controller2_data;
            default: cpu_data_out <= 8'd0;
        endcase
end

endmodule
