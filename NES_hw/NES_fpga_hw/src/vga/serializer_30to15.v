//******************************************************************************
//* FPGA implementation of the Nintendo Entertainment System (NES).            *
//*                                                                            *
//* 30 bit to 15 bit serializer for the DVI/HDMI interface.                    *
//* Version      : 1.0                                                         *
//* Last modified: 2011.10.11.                                                 *
//*                                                                            *
//* Copyright (c) 2010-2011 Tamas Raikovich (rtamas@mit.bme.hu)                *
//* All rights reserved.                                                       *
//*                                                                            *
//* For educational purposes only. Redistribution of the source code or the    *
//* synthesized form, with or without modification, is not permitted.          *
//******************************************************************************
module serializer_30to15(
   //Clock and reset.
   input  wire        clk,          //1x clock input.
   input  wire        rst,          //Reset signal for the 1x clock domain.
   input  wire        clk_2x,       //2x clock input.
   input  wire        rst_2x,       //Reset signal for the 2x clock domain.
   
   //Data input and output.
   input  wire [29:0] data_in,      //Input data.
   output reg  [14:0] data_out      //Output data at 2x clock speed.
);

//*****************************************************************************
//* Write address counter for the distributed RAM.                            *
//*****************************************************************************
reg [3:0] wr_address;

always @(posedge clk)
begin
   if (rst)
      wr_address <= 4'd8;
   else
      wr_address <= wr_address + 4'd1;
end


//*****************************************************************************
//* Read address counter for the distributed RAM.                             *
//*****************************************************************************
reg [4:0] rd_address;

always @(posedge clk_2x)
begin
   if (rst_2x)
      rd_address <= 5'd0;
   else
      rd_address <= rd_address + 5'd1;
end


//*****************************************************************************
//* 16 x 30 bit dual-port distributed RAM.                                    *
//*****************************************************************************
wire [29:0] ram_dout;
reg  [29:0] ram_dout_reg;

dpram_16x30bit ram(
   //Clock.
   .clk(clk),                 //Clock input.
   
   //A port: read/write
   //Write is synchronous to the clk, read is asynchronous.
   .addr_a(wr_address),       //Address input.
   .wren_a(1'b1),             //Write enable input.
   .din_a(data_in),           //Input data.
   .dout_a(),                 //Output data.
   
   //B port: read only
   //Read is asynchronous.
   .addr_b(rd_address[4:1]),  //Address input.
   .dout_b(ram_dout)          //Output data.
);

always @(posedge clk_2x)
begin
   if (rd_address[0])
      ram_dout_reg <= ram_dout;
end

always @(posedge clk_2x)
begin
   data_out <= (rd_address[0]) ? ram_dout_reg[29:15] : ram_dout_reg[14:0];
end


endmodule
