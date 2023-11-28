`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:31 10/23/2023 
// Design Name: 
// Module Name:    vga_test 
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
module vga_test(
   //Clock and reset.
   input  wire clk_in,              //25 MHz clock input.
   input  wire rstn_in,             //Active-low reset input.
   
   //Output TMDS signals.
   output wire tmds_data0_out_p,    //TMDS DATA0 line.
   output wire tmds_data0_out_n,
   output wire tmds_data1_out_p,    //TMDS DATA1 line.
   output wire tmds_data1_out_n,
   output wire tmds_data2_out_p,    //TMDS DATA2 line.
   output wire tmds_data2_out_n,
   output wire tmds_clock_out_p,    //TMDS CLOCK signal.
   output wire tmds_clock_out_n
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
   .CLKFBOUT_MULT(20),              // Multiply value for all CLKOUT clock outputs (1-64)
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
   .CLKIN(clk_in),                  // 1-bit input: Clock input
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
//* Generating the reset signal.                                              *
//*****************************************************************************
wire rst = ~rstn_in | ~pll_locked;


//*****************************************************************************
//* 640 x 480 @ 60 Hz VGA timing parameters (25 MHz pixel clock).             *
//*****************************************************************************
localparam H_BLANK_BEGIN     = 10'd639;
localparam H_SYNC_BEGIN      = 10'd655;
localparam H_SYNC_END        = 10'd751;
localparam H_BLANK_END       = 10'd799;

localparam V_BLANK_BEGIN     = 10'd479;
localparam V_SYNC_BEGIN      = 10'd490;
localparam V_SYNC_END        = 10'd492;
localparam V_BLANK_END       = 10'd523;


//*****************************************************************************
//* Horizontal counter.                                                       *
//*****************************************************************************
reg [9:0] h_cnt;

always @(posedge clk)
begin
   if (rst || (h_cnt == H_BLANK_END))
      h_cnt <= 0;
   else
      h_cnt <= h_cnt + 10'd1;
end


//*****************************************************************************
//* Vertical counter.                                                         *
//*****************************************************************************
reg [9:0] v_cnt;

always @(posedge clk)
begin
   if (rst)
      v_cnt <= 0;
   else
      if (h_cnt == H_BLANK_END)
         if (v_cnt == V_BLANK_END)
            v_cnt <= 0;
         else
            v_cnt <= v_cnt + 10'd1;
end


//*****************************************************************************
//* Generating the horizontal sync signal.                                    *
//*****************************************************************************
reg h_sync = 1'b1;

always @(posedge clk)
begin
   if (rst || (h_cnt == H_SYNC_END))
      h_sync <= 1;
   else
      if (h_cnt == H_SYNC_BEGIN)
         h_sync <= 0;
end


//*****************************************************************************
//* Generating the vertical sync signal.                                      *
//*****************************************************************************
reg v_sync = 1'b1;

always @(posedge clk)
begin
   if (rst)
      v_sync <= 1;
   else
      if (h_cnt == H_BLANK_END)
         if (v_cnt == V_SYNC_BEGIN)
            v_sync <= 0;
         else
            if (v_cnt == V_SYNC_END)
               v_sync <= 1;
end


//*****************************************************************************
//* Generating the blanking signal.                                           *
//*****************************************************************************
reg h_blank;
reg v_blank;

always @(posedge clk)
begin
   if (rst || (h_cnt == H_BLANK_END))
      h_blank <= 0;
   else
      if (h_cnt == H_BLANK_BEGIN)
         h_blank <= 1;
end

always @(posedge clk)
begin
   if (rst)
      v_blank <= 0;
   else
      if (h_cnt == H_BLANK_END)
         if (v_cnt == V_BLANK_BEGIN)
            v_blank <= 1;
         else
            if (v_cnt == V_BLANK_END)
               v_blank <= 0;
end


//*****************************************************************************
//* Generating the picture data.                                              *
//*****************************************************************************
reg [7:0] red_reg;
reg [7:0] green_reg;
reg [7:0] blue_reg;
reg       hsync_reg;
reg       vsync_reg;
reg       blank_reg;

always @(posedge clk)
begin
   red_reg   <= {8{h_cnt[4] ^ v_cnt[4]}};
   green_reg <= {8{h_cnt[5] ^ v_cnt[5]}};
   blue_reg  <= {8{h_cnt[6] ^ v_cnt[6]}};
   hsync_reg <= h_sync;
   vsync_reg <= v_sync;
   blank_reg <= h_blank | v_blank;
end


//*****************************************************************************
//* Instantiating the TMDS transmitter module.                                *
//*****************************************************************************
tmds_transmitter tmds_transmitter(
   //Clock and reset.
   .clk(clk),                             //Pixel clock input.
   .rst(rst),                             //Reset signal for the 1x clock domain.
   .clk_2x(clk_2x),                       //2x pixel clock input.
   .clk_10x(clk_10x),                     //10x pixel clock input.
   .bufpll_locked(bufpll_locked),         //PLL locked signal from BUFPLL.
   .serdes_strobe(serdes_strobe),         //Serdes data capture signal from BUFPLL.
   
   //Input video data.
   .red_in(red_reg),                      //Red video signal.
   .green_in(green_reg),                  //Green video signal.
   .blue_in(blue_reg),                    //Blue video signal.
   .blank_in(blank_reg),                  //Blanking signal.
   .hsync_in(hsync_reg),                  //Horizontal sync signal.
   .vsync_in(vsync_reg),                  //Vertical sync signal.
   
   //Output TMDS signals.
   .tmds_data0_out_p(tmds_data0_out_p),   //TMDS DATA0 line.
   .tmds_data0_out_n(tmds_data0_out_n),
   .tmds_data1_out_p(tmds_data1_out_p),   //TMDS DATA1 line.
   .tmds_data1_out_n(tmds_data1_out_n),
   .tmds_data2_out_p(tmds_data2_out_p),   //TMDS DATA2 line.
   .tmds_data2_out_n(tmds_data2_out_n),
   .tmds_clock_out_p(tmds_clock_out_p),   //TMDS CLOCK signal.
   .tmds_clock_out_n(tmds_clock_out_n)
);


endmodule
