`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:41:39 07/03/2023 
// Design Name: 
// Module Name:    nes_top 
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
module nes_top(
    input wire sys_clk, // 50MHz

    input wire rstn_in //Active-low reset input
    );

//*****************************************************************************
//* Clock generator.                                                          *
//*****************************************************************************
wire pll_clkfbout;
wire pll_locked;
wire pll_clkout0;
wire pll_clkout1;
wire pll_clkout2;
wire clk;
wire clk_2x;
wire clk_10x;
wire bufpll_locked;
wire serdes_strobe;

PLL_BASE #(
   .BANDWIDTH("OPTIMIZED"),         // "HIGH", "LOW" or "OPTIMIZED" 
   .CLKFBOUT_MULT(10),              // Multiply value for all CLKOUT clock outputs (1-64)
   .CLKFBOUT_PHASE(0.0),            // Phase offset in degrees of the clock feedback output (0.0-360.0).
   .CLKIN_PERIOD(9.0),              // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
   .CLKOUT0_DIVIDE(2),              // Divide amount for CLKOUT# clock output (1-128)
   .CLKOUT1_DIVIDE(20),
   .CLKOUT2_DIVIDE(10),
   .CLKOUT3_DIVIDE(1),
   .CLKOUT4_DIVIDE(1),
   .CLKOUT5_DIVIDE(1),
   .CLKOUT0_DUTY_CYCLE(0.5),        // Duty cycle for CLKOUT# clock output (0.01-0.99).
   .CLKOUT1_DUTY_CYCLE(0.5),
   .CLKOUT2_DUTY_CYCLE(0.5),
   .CLKOUT3_DUTY_CYCLE(0.5),
   .CLKOUT4_DUTY_CYCLE(0.5),
   .CLKOUT5_DUTY_CYCLE(0.5),
   .CLKOUT0_PHASE(0.0),             //Output phase relationship for CLKOUT# clock output (-360.0-360.0).
   .CLKOUT1_PHASE(0.0),
   .CLKOUT2_PHASE(0.0),
   .CLKOUT3_PHASE(0.0),
   .CLKOUT4_PHASE(0.0),
   .CLKOUT5_PHASE(0.0),
   .CLK_FEEDBACK("CLKFBOUT"),       // Clock source to drive CLKFBIN ("CLKFBOUT" or "CLKOUT0")
   .COMPENSATION("INTERNAL"),       // "SYSTEM_SYNCHRONOUS", "SOURCE_SYNCHRONOUS", "EXTERNAL" 
   .DIVCLK_DIVIDE(1),               // Division value for all output clocks (1-52)
   .REF_JITTER(0.1),                // Reference Clock Jitter in UI (0.000-0.999).
   .RESET_ON_LOSS_OF_LOCK("FALSE")  // Must be set to FALSE
) PLL_BASE_inst (
   .CLKFBOUT(pll_clkfbout),         // 1-bit output: PLL_BASE feedback output
   .CLKOUT0(pll_clkout0),           // Clock outputs
   .CLKOUT1(pll_clkout1),
   .CLKOUT2(pll_clkout2),
   .CLKOUT3(),
   .CLKOUT4(),
   .CLKOUT5(),
   .LOCKED(pll_locked),             // 1-bit output: PLL_BASE lock status output
   .CLKFBIN(pll_clkfbout),          // 1-bit input: Feedback clock input
   .CLKIN(sys_clk),                  // 1-bit input: Clock input
   .RST(~rstn_in)                   // 1-bit input: Reset input
);

//Clock buffer for the pixel clock.
BUFG clk_buf(.I(pll_clkout1), .O(clk));

//Clock buffer for the 2x pixel clock.
BUFG clk_2x_buf(.I(pll_clkout2), .O(clk_2x));

//Clock buffer for the 10x pixel clock.
BUFPLL #(
   .DIVIDE(5)
) ioclk_buf (
   .PLLIN(pll_clkout0),
   .GCLK(clk_2x),
   .LOCKED(pll_locked),
   .IOCLK(clk_10x),
   .SERDESSTROBE(serdes_strobe),
   .LOCK(bufpll_locked)
);

//*****************************************************************************
//* Generating the vga reset signal.                                          *
//*****************************************************************************
reg [7:0] sync_shift_reg;

initial	sync_shift_reg = 8'hFF; // 8 bites shift reg 7. bit az utolso 

wire shr_rst = ~pll_locked | ~rstn_in;

always @(posedge clk or posedge shr_rst) 
begin
   if (shr_rst)
      sync_shift_reg <= 8'hFF;
   else
      sync_shift_reg <= {sync_shift_reg[6:0], 1'b0};
end

wire rst = ~sync_shift_reg[7];// SZINKRONIZÁLT!!

//*****************************************************************************
//* PPU                                                                       *
//*****************************************************************************
wire [ 7:0] ppu_ri_dout;

assign ppu_ri_sel  = cpu_addr[2:0];
assign ppu_ri_cs  = (cpu_addr[15:13] == 3'b001); // 0x2000-0x2007 every 8 bytes mirrored through 0x3FFF
assign ppu_ri_r_nw = cpu_r_nw;
assign ppu_ri_din  = cpu_din;

ppu_top ppu(
   .clk(clk),
   .rst(rst),
   // register interface
   .ri_sel_in(ppu_ri_sel),
   .ri_cs_in(ppu_ri_cs),
   .ri_r_nw_in(ppu_ri_r_nw),
   .ri_d_in(ppu_ri_din),
   .ri_d_out(ppu_ri_dout),
   // PPU interface
   .data_in(), 
	.data_out(),
	.addr(),
	.write_request(),
	.read_request()
);

endmodule
