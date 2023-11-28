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
/*
//Szinkron és kioltó jelek.
reg [9:0] h_cnt = 10'd0;
reg [9:0] v_cnt = 10'd0;

reg hsync = 1'b1;   //Horizontális szinkron pulzus.
reg vsync = 1'b0;   //Vertikális szinkron pulzus.
reg blank;   //Kioltó jel.
*/

//*****************************************************************************
/*
wire vga_en = (startupcntr == START_OF_VGA_RENDERING);

parameter START_OF_VGA_RENDERING = 12'd3203; // a rendszernek lehet extra késleltetése ez csak a 2 sor (1600 + 1600 + 4) - 1

reg [11:0] startupcntr = 12'd0;

always @ (posedge pclk)
begin
	if (rst)
		startupcntr <= 12'd0;
	else if (~vga_en)
		startupcntr <= startupcntr + 12'd1;
end
*/
//*****************************************************************************

/*
vga_timing timing(
   .clk(pclk),
   .rst(rst),
   .en(vga_en),

   .h_cnt(h_cnt),
   .v_cnt(v_cnt),

   .h_sync(hsync),
   .v_sync(vsync),
   .blank(blank)
);
*/


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

always @(posedge pclk)
begin
   if (rst || (h_cnt == H_BLANK_END))
      h_cnt <= 0;
   else
      //if (vga_en)
         h_cnt <= h_cnt + 10'd1;
end


//*****************************************************************************
//* Vertical counter.                                                         *
//*****************************************************************************
reg [9:0] v_cnt;

always @(posedge pclk)
begin
   if (rst)
      v_cnt <= 0;
   else
      if ((h_cnt == H_BLANK_END)) //&& vga_en
         if (v_cnt == V_BLANK_END)
            v_cnt <= 0;
         else
            v_cnt <= v_cnt + 10'd1;
end


//*****************************************************************************
//* Generating the horizontal sync signal.                                    *
//*****************************************************************************
reg h_sync = 1'b1;

always @(posedge pclk)
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

always @(posedge pclk)
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

always @(posedge pclk)
begin
   if (rst || (h_cnt == H_BLANK_END))
      h_blank <= 0;
   else
      if (h_cnt == H_BLANK_BEGIN)
         h_blank <= 1;
end

always @(posedge pclk)
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
//* Generating controll signals for                                           *
//*****************************************************************************
/*
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;

parameter END_OF_PPU_RENDERING = 11'd1599;
parameter END_OF_VGA_RENDERING = 10'd799;

reg [10:0] x_ppucntr = 11'd0;

always @ (posedge pclk)
begin
	if (rst || (x_ppucntr == END_OF_PPU_RENDERING) || (startupcntr == 12'd3))
		x_ppucntr <= 11'd0;
	else
		x_ppucntr <= x_ppucntr + 11'd1;
end

reg buff_sel = 1'd0;

//we change the written buffers
always @ (posedge pclk) 
begin
   if (rst)
      buff_sel <= 1'd0;
   else if (x_ppucntr == END_OF_PPU_RENDERING)
      buff_sel <= ~buff_sel;
end

reg [9:0] x_writecntr = 10'd0;

//cntr for writing the two buffers

always @ (posedge pclk)
begin
	if (rst || (x_writecntr == END_OF_VGA_RENDERING) || (startupcntr == 12'd3))
		x_writecntr <= 10'd0;
	else if(x_ppucntr[0] == 1'b0)
		x_writecntr <= x_writecntr + 10'd1;
end
*/
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
   if(buff_sel)
      if (x_ppucntr[0] == 1'b0)
         buffer_1[x_writecntr] <= {blue_din, green_din, red_din};
   else
      buff1_dout <= buffer_1[h_cnt];
end

(*ram_style = "BLOCK"*)
reg [23:0] buffer_2 [1023:0];

always@(posedge pclk)
begin
   if(~buff_sel)
      if (x_ppucntr[0] == 1'b0)
         buffer_2[x_writecntr] <= {blue_din, green_din, red_din};
   else
      buff2_dout <= buffer_2[h_cnt];
end

assign red = (buff_sel)   ? buff2_dout[7:0]   : buff1_dout[7:0];
assign green = (buff_sel) ? buff2_dout[15:8]  : buff1_dout[15:8];
assign blue = (buff_sel)  ? buff2_dout[23:16] : buff1_dout[23:16];
*/
//*****************************************************************************
//* Generating the picture data.                                              *
//*****************************************************************************
reg [7:0] red_reg;
reg [7:0] green_reg;
reg [7:0] blue_reg;
reg       hsync_reg;
reg       vsync_reg;
reg       blank_reg;

always @(posedge pclk)
begin
   red_reg   <= red_din;
   green_reg <= green_din;
   blue_reg  <= blue_din;
   hsync_reg <= h_sync;
   vsync_reg <= v_sync;
   blank_reg <= h_blank | v_blank;
end

//*****************************************************************************
//* RGB in dual port BRAM                                                     *
//*****************************************************************************

//wire buff_we = (x_ppucntr[1:0] == 2'b10); // minden második órajelben vesszük el a pixelt így 1600 -> 800 lesz
/*
reg [23:0] buff_dout_a = 24'd0;
reg [23:0] buff_dout_b = 24'd0;

reg [23:0] buff_dout = 24'd0;

(*ram_style = "BLOCK"*)
reg [23:0] buffer [2047:0];


// we write every second pixel data into the buffer
always@(posedge pclk)
begin
   if(buff_sel && (x_ppucntr[0] == 1'b0))
      buffer[x_writecntr] <= {blue_din, green_din, red_din};
   buff_dout_a <= buffer[h_cnt];
end

always@(posedge pclk)
begin
   if(~buff_sel && (x_ppucntr[0] == 1'b0))
      buffer[x_writecntr + 1024] <= {blue_din, green_din, red_din};
   buff_dout_b <= buffer[h_cnt + 1024];
end

assign red = (buff_sel)   ? buff_dout_b[7:0]   : buff_dout_a[7:0];
assign green = (buff_sel) ? buff_dout_b[15:8]  : buff_dout_a[15:8];
assign blue = (buff_sel)  ? buff_dout_b[23:16] : buff_dout_a[23:16];
*/

//*****************************************************************************
//* RGB REGISTERS                                                             *
//*****************************************************************************

/*

always @ (posedge pclk)
begin
   if (buff_sel)
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

*/

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
