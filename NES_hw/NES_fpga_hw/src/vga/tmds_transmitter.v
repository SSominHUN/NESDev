//******************************************************************************
//* FPGA implementation of the Nintendo Entertainment System (NES).            *
//*                                                                            *
//* TMDS transmitter module for the DVI/HDMI interface.                        *
//* Version      : 1.0                                                         *
//* Last modified: 2011.10.11.                                                 *
//*                                                                            *
//* Copyright (c) 2010-2011 Tamas Raikovich (rtamas@mit.bme.hu)                *
//* All rights reserved.                                                       *
//*                                                                            *
//* For educational purposes only. Redistribution of the source code or the    *
//* synthesized form, with or without modification, is not permitted.          *
//******************************************************************************
module tmds_transmitter(
   //Clock and reset.
   input  wire       clk,                 //Pixel clock input.
   input  wire       rst,                 //Reset signal for the 1x clock domain.
   input  wire       clk_2x,              //2x pixel clock input.
   input  wire       clk_10x,             //10x pixel clock input.
   input  wire       bufpll_locked,       //PLL locked signal from BUFPLL.
   input  wire       serdes_strobe,       //Serdes data capture signal from BUFPLL.
   
   //Input video data.
   input  wire [7:0] red_in,              //Red video signal.
   input  wire [7:0] green_in,            //Green video signal.
   input  wire [7:0] blue_in,             //Blue video signal.
   input  wire       blank_in,            //Blanking signal.
   input  wire       hsync_in,            //Horizontal sync signal.
   input  wire       vsync_in,            //Vertical sync signal.
   
   //Output TMDS signals.
   output wire       tmds_data0_out_p,    //TMDS DATA0 line.
   output wire       tmds_data0_out_n,
   output wire       tmds_data1_out_p,    //TMDS DATA1 line.
   output wire       tmds_data1_out_n,
   output wire       tmds_data2_out_p,    //TMDS DATA2 line.
   output wire       tmds_data2_out_n,
   output wire       tmds_clock_out_p,    //TMDS CLOCK signal.
   output wire       tmds_clock_out_n
);

//*****************************************************************************
//* Synchronize the reset signal with the 2x pixel clock.                     *
//*****************************************************************************
(* shreg_extract = "no" *)
(* register_balancing = "no" *)
(* register_duplication = "no" *)
(* equivalent_register_removal = "no" *)
reg  [2:0] rst_sync_reg;
wire       rst_2x = rst_sync_reg[2];

always @(posedge clk)
begin
   rst_sync_reg[0] <= rst;
end

always @(posedge clk_2x)
begin
   rst_sync_reg[2:1] <= rst_sync_reg[1:0];
end


//*****************************************************************************
//* Instantiating the TMDS encoders.                                          *
//*****************************************************************************
wire [9:0] tmds_red;
wire [9:0] tmds_green;
wire [9:0] tmds_blue;

tmds_encoder encoder_r(
   //Clock and reset.
   .clk(clk),                       //Clock input.
   .rst(rst),                       //Asynchronous reset input.
   
   //Input data.
   .data_in(red_in),                //Input pixel data to encode.
   .data_en(~blank_in),             //Input data enable signal.
   .ctrl0_in(1'b0),                 //Control signals.
   .ctrl1_in(1'b0),
   
   //Output data.
   .tmds_out(tmds_red)              //TMDS data output.
);

tmds_encoder encoder_g(
   //Clock and reset.
   .clk(clk),                       //Clock input.
   .rst(rst),                       //Asynchronous reset input.
   
   //Input data.
   .data_in(green_in),              //Input pixel data to encode.
   .data_en(~blank_in),             //Input data enable signal.
   .ctrl0_in(1'b0),                 //Control signals.
   .ctrl1_in(1'b0),
   
   //Output data.
   .tmds_out(tmds_green)            //TMDS data output.
);

tmds_encoder encoder_b(
   //Clock and reset.
   .clk(clk),                       //Clock input.
   .rst(rst),                       //Asynchronous reset input.
   
   //Input data.
   .data_in(blue_in),               //Input pixel data to encode.
   .data_en(~blank_in),             //Input data enable signal.
   .ctrl0_in(hsync_in),             //Control signals.
   .ctrl1_in(vsync_in),
   
   //Output data.
   .tmds_out(tmds_blue)             //TMDS data output.
);

//*****************************************************************************
//* Instantiating the 30 bit to 15 bit serializer.                            *
//*****************************************************************************
wire [29:0] serializer_din;
wire [14:0] serializer_dout;

assign serializer_din[4:0]   = tmds_blue[4:0];
assign serializer_din[9:5]   = tmds_green[4:0];
assign serializer_din[14:10] = tmds_red[4:0];
assign serializer_din[19:15] = tmds_blue[9:5];
assign serializer_din[24:20] = tmds_green[9:5];
assign serializer_din[29:25] = tmds_red[9:5];

serializer_30to15 serializer(
   //Clock and reset.
   .clk(clk),                       //1x clock input.
   .rst(rst),                       //Reset signal for the 1x clock domain.
   .clk_2x(clk_2x),                 //2x clock input.
   .rst_2x(rst_2x),                 //Reset signal for the 2x clock domain.
   
   //Data input and output.
   .data_in(serializer_din),        //Input data.
   .data_out(serializer_dout)       //Output data at 2x clock speed.
);


//*****************************************************************************
//* Instantiating the 5 bit to 1 bit serializers (OSERDES).                   *
//*****************************************************************************
wire       serdes_rst  = rst_2x | ~bufpll_locked;
wire [4:0] serdes0_din = serializer_dout[4:0];
wire [4:0] serdes1_din = serializer_dout[9:5];
wire [4:0] serdes2_din = serializer_dout[14:10];

oserdes_5to1 oserdes0(
   //Clock and reset.
   .clk(clk_2x),                    //1x clock input.
   .clk_5x(clk_10x),                //5x clock input.
   .rst(serdes_rst),                //Asynchronous reset signal.
   
   //Input data.
   .data_in(serdes0_din),           //5 bit data input.
   .serdes_strobe(serdes_strobe),   //Serdes data capture signal.
   
   //Differential serial data output.
   .dout_p(tmds_data0_out_p),       //Serial data output (+).
   .dout_n(tmds_data0_out_n)        //Serial data output (-).
);

oserdes_5to1 oserdes1(
   //Clock and reset.
   .clk(clk_2x),                    //1x clock input.
   .clk_5x(clk_10x),                //5x clock input.
   .rst(serdes_rst),                //Asynchronous reset signal.
   
   //Input data.
   .data_in(serdes1_din),           //5 bit data input.
   .serdes_strobe(serdes_strobe),   //Serdes data capture signal.
   
   //Differential serial data output.
   .dout_p(tmds_data1_out_p),       //Serial data output (+).
   .dout_n(tmds_data1_out_n)        //Serial data output (-).
);

oserdes_5to1 oserdes2(
   //Clock and reset.
   .clk(clk_2x),                    //1x clock input.
   .clk_5x(clk_10x),                //5x clock input.
   .rst(serdes_rst),                //Asynchronous reset signal.
   
   //Input data.
   .data_in(serdes2_din),           //5 bit data input.
   .serdes_strobe(serdes_strobe),   //Serdes data capture signal.
   
   //Differential serial data output.
   .dout_p(tmds_data2_out_p),       //Serial data output (+).
   .dout_n(tmds_data2_out_n)        //Serial data output (-).
);


//*****************************************************************************
//* Driving the TMDS clock output.                                            *
//*****************************************************************************
reg tmds_clk;

always @(posedge clk_2x or posedge serdes_rst)
begin
   if (serdes_rst)
      tmds_clk <= 1'b0;
   else
      tmds_clk <= ~tmds_clk;
end

oserdes_5to1 oserdes_clk(
   //Clock and reset.
   .clk(clk_2x),                    //1x clock input.
   .clk_5x(clk_10x),                //5x clock input.
   .rst(serdes_rst),                //Asynchronous reset signal.
   
   //Input data.
   .data_in({5{tmds_clk}}),         //5 bit data input.
   .serdes_strobe(serdes_strobe),   //Serdes data capture signal.
   
   //Differential serial data output.
   .dout_p(tmds_clock_out_p),       //Serial data output (+).
   .dout_n(tmds_clock_out_n)        //Serial data output (-).
);


endmodule
