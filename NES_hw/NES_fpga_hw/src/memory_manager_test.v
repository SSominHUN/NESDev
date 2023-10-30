`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:58:54 10/30/2023
// Design Name:   memory_manager_v2_top
// Module Name:   D:/NESDev/NES-hw/src/memory_manager_test.v
// Project Name:  NES-hw
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory_manager_v2_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memory_manager_test;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] cpu_addr;
	reg cpu_rnw;
	reg [7:0] cpu_data_in;
	reg ppu_wr_req;
	reg [13:0] ppu_addr;
	reg [7:0] ppu_din;

	// Outputs
	wire [7:0] cpu_data_out;
	wire [7:0] ppu_dout;

//*****************************************************************************
//* CPU clock generation			                                          *
//*****************************************************************************
reg ph2_rising;
reg ph2_falling;

// clock genereation enable
reg		clkgen_cnt_en;

//clock generation timer
reg	[3:0]	clkgen_cnt;

always @ (posedge clk)
begin
	if (rst)
		clkgen_cnt <= 4'd0;
	else
		if (clkgen_cnt_en)
			if (clkgen_cnt == 4'd11)
				clkgen_cnt <= 4'd0;
			else
				clkgen_cnt <= clkgen_cnt + 4'd1;
end

always @ (posedge clk)
begin
	ph2_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd6);
	ph2_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd11);
end

	// Instantiate the Unit Under Test (UUT)
	memory_manager_v2_top uut (
		.clk(clk), 
		.rst(rst), 
		.ph2_rising(ph2_rising), 
		.ph2_falling(ph2_falling), 
		.cpu_addr(cpu_addr), 
		.cpu_rnw(cpu_rnw), 
		.cpu_data_out(cpu_data_out), 
		.cpu_data_in(cpu_data_in), 
		.ppu_wr_req(ppu_wr_req), 
		.ppu_addr(ppu_addr), 
		.ppu_din(ppu_din), 
		.ppu_dout(ppu_dout)
	);


initial begin 
    forever begin
    clk = 0;
    #25 clk = ~clk;
 	end 
end
initial begin
	// Initialize Inputs
	clkgen_cnt_en = 1;
	rst = 1;
	cpu_addr = 0;
	cpu_rnw = 0;
	cpu_data_in = 0;
	ppu_wr_req = 0;
	ppu_addr = 0;
	ppu_din = 0;

	// Wait 100 ns for global reset to finish
	#50;
    rst = 0;   
	// Add stimulus here

end
      
endmodule

