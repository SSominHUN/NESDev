`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:48:46 07/03/2023 
// Design Name: 
// Module Name:    vga_top 
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
module vga_top(
   input  wire       pclk, // 25 MHz clock signal 
   input  wire       pclk_2x, // 50 MHz clock signal
   input  wire       pclk_10x, // 250 MHz
	input	 wire			bufpll_locked,
   input  wire       serdes_strobe,
   input  wire       rst,

   input  wire [7:0] blue_din,       // Blue data in
   input  wire [7:0] green_din,      // Green data in
   input  wire [7:0] red_din,        // Red data in

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
//* Generating hsync vsynck and blank                                         *
//*****************************************************************************

//Szinkron és kioltó jelek.
wire [9:0] h_cnt;
wire [9:0] v_cnt;

wire hsync_reg;   //Horizontális szinkron pulzus.
wire vsync_reg;   //Vertikális szinkron pulzus.
wire blank;             //Kioltó jel.

reg blank_reg;

always @ (posedge pclk) begin
   blank_reg <= blank;
end

reg vga_en = 1'b0;

always @ (posedge pclk) 
begin
   if(rst)
      vga_en <= 1'b0;
   else if(startupcntr == START_OF_VGA_RENDERING)
      vga_en <= 1'b1;
end

parameter START_OF_VGA_RENDERING = 12'd3199;

reg [11:0] startupcntr = 12'd0;

always @ (posedge pclk)
begin
	if (rst)
		startupcntr <= 12'd0;
	else if (~vga_en)
		startupcntr <= startupcntr + 12'd1;
end

wire vga_en_wire;
assign vga_en_wire = vga_en;

vga_timing timing(
   .clk(pclk),
   .rst(rst),
   .en(vga_en_wire),

   .h_cnt(h_cnt),
   .v_cnt(v_cnt),

   .h_sync(hsync_reg),
   .v_sync(vsync_reg),
   .blank(blank)
);

//*****************************************************************************
//* Receiving picture data from buffers.                                      *
//*****************************************************************************
reg [7:0] red_reg;
reg [7:0] green_reg;
reg [7:0] blue_reg;

parameter END_OF_PPU_RENDERING = 11'd1599;
parameter END_OF_VGA_RENDERING = 10'd799;

reg [10:0] x_ppucntr = 11'd0;

always @ (posedge pclk)
begin
	if (rst || (x_ppucntr == END_OF_PPU_RENDERING))
		x_ppucntr <= 11'd0;
	else
		x_ppucntr <= x_ppucntr + 11'd1;
end

reg buff_we = 1'd0;

//we change the written buffers
always @ (posedge pclk) 
begin
   if (rst)
      buff_we <= 1'd0;
   else if (x_ppucntr == END_OF_PPU_RENDERING)
      buff_we <= ~buff_we;
end

reg [9:0] x_writecntr = 10'd0;

//cntr for writing the two buffers
always @ (posedge pclk)
begin
	if (rst || (x_writecntr == END_OF_VGA_RENDERING))
		x_writecntr <= 10'd0;
	else if(x_ppucntr[0] == 1'b0)
		x_writecntr <= x_writecntr + 10'd1;
end

//*****************************************************************************
//* RGB in one BRAM                                                           *
//*****************************************************************************

/*
reg [23:0] buff1_dout = 24'd0;
reg [23:0] buff2_dout = 24'd0;

(*ram_style = "BLOCK"*)
reg [23:0] buffer_1 [1023:0];

always@(posedge pclk)
begin
   if(buff_we)
      if (x_ppucntr[0] == 1'b0)
         buffer_1[x_writecntr] <= {blue_din, green_din, red_din};
   else
      buff1_dout <= buffer_1[h_cnt];
end

(*ram_style = "BLOCK"*)
reg [23:0] buffer_2 [1023:0];

always@(posedge pclk)
begin
   if(~buff_we)
      if (x_ppucntr[0] == 1'b0)
         buffer_2[x_writecntr] <= {blue_din, green_din, red_din};
   else
      buff2_dout <= buffer_2[h_cnt];
end
*/

//*****************************************************************************
//* RGB in dual port BRAM                                                     *
//*****************************************************************************

reg [23:0] buff_dout_a = 24'd0;
reg [23:0] buff_dout_b = 24'd0;

(*ram_style = "BLOCK"*)
reg [23:0] buffer [2047:0];

always@(posedge pclk)
begin
   if(buff_we)
      if (x_ppucntr[0] == 1'b0)
         buffer[x_writecntr] <= {blue_din, green_din, red_din};
   else
      buff_dout_a <= buffer[h_cnt];
end

always@(posedge pclk)
begin
   if(~buff_we)
      if (x_ppucntr[0] == 1'b0)
         buffer[x_writecntr + 1024] <= {blue_din, green_din, red_din};
   else
      buff_dout_b <= buffer[h_cnt + 1024];
end


//*****************************************************************************
//* RGB REGISTERS                                                             *
//*****************************************************************************

always @ (posedge pclk)
begin
   if (buff_we)
	begin
      red_reg <= buff_dout_b[7:0];
      green_reg <= buff_dout_b[15:8];
      blue_reg <= buff_dout_b[23:16];
	end
   else
	begin
      red_reg <= buff_dout_a[7:0];
      green_reg <= buff_dout_a[15:8];
      blue_reg <= buff_dout_a[23:16];
	end
end

//*****************************************************************************
//* Instantiating the TMDS transmitter module.                                *
//*****************************************************************************
tmds_transmitter tmds_transmitter(
   //Clock and reset.
   .clk(pclk),                            //Pixel clock input.
   .rst(rst),                             //Reset signal for the 1x clock domain.
   .clk_2x(pclk_2x),                      //2x pixel clock input.
   .clk_10x(pclk_10x),                    //10x pixel clock input.
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
