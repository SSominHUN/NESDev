`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:16 10/29/2023
// Design Name:   ppu_top
// Module Name:   D:/NESDev/NES-hw/src/ppu/ppu_clock_test.v
// Project Name:  NES-hw
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ppu_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ppu_clock_test;

	// Inputs
	reg clk;
	reg rst;
	reg clk_2x;
	reg clk_10x;
	reg bufpll_locked;
	reg serdes_strobe;
	reg [2:0] slv_mem_addr;
	reg slv_mem_cs;
	reg slv_mem_rnw;
	reg [7:0] slv_mem_din;
	reg [7:0] ppu_mem_din;

	// Outputs
	wire ph1_rising_outw;
	wire ph2_rising_outw;
	wire ph2_falling_outw;
	wire [7:0] slv_mem_dout;
	wire irq;
	wire [7:0] ppu_mem_dout;
	wire [13:0] ppu_mem_addr;
	wire ppu_mem_wr_request;
	wire tmds_data0_out_p;
	wire tmds_data0_out_n;
	wire tmds_data1_out_p;
	wire tmds_data1_out_n;
	wire tmds_data2_out_p;
	wire tmds_data2_out_n;
	wire tmds_clock_out_p;
	wire tmds_clock_out_n;



//*****************************************************************************
//* CPU clock generation			                                          *
//*****************************************************************************
reg ph1_rising;
//reg ph1_falling;
reg ph2_rising;
reg ph2_falling;

// clock genereation enable
reg		clkgen_cnt_en;

always @ (posedge clk)
begin
	if (rst || bgrender_state == SLEEP) // Is it correct with the (*) in the upper state machine
		clkgen_cnt_en <= 1'b0;
	else // every other option next_state != SLEEP -> working processor
		clkgen_cnt_en <= 1'b1;
end	

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
	ph1_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd0);
	//ph1_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd5);
	ph2_rising	<= clkgen_cnt_en & (clkgen_cnt == 4'd6);
	ph2_falling <= clkgen_cnt_en & (clkgen_cnt == 4'd11);
end

assign ph1_rising_outw = ph1_rising;
//assign ph1_falling_outw = ph1_falling;
assign ph2_rising_outw = ph2_rising;
assign ph2_falling_outw = ph2_falling;

initial begin 
    forever begin
    clk = 0;
    #10 clk = ~clk;
 	end 
end

initial begin
	// Initialize Inputs
	clk = 0;
	rst = 0;
	clk_2x = 0;
	clk_10x = 0;
	bufpll_locked = 0;
	serdes_strobe = 0;
	slv_mem_addr = 0;
	slv_mem_cs = 0;
	slv_mem_rnw = 0;
	slv_mem_din = 0;
	ppu_mem_din = 0;

	// Wait 100 ns for global reset to finish
	#100;
        
	// Add stimulus here

end
      
endmodule

