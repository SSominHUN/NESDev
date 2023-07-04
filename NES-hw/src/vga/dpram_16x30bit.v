//******************************************************************************
//* FPGA implementation of the Nintendo Entertainment System (NES).            *
//*                                                                            *
//* 16 x 30 bit dual-port distributed RAM.                                     *
//* Version      : 1.0                                                         *
//* Last modified: 2011.10.11.                                                 *
//*                                                                            *
//* Copyright (c) 2010-2011 Tamas Raikovich (rtamas@mit.bme.hu)                *
//* All rights reserved.                                                       *
//*                                                                            *
//* For educational purposes only. Redistribution of the source code or the    *
//* synthesized form, with or without modification, is not permitted.          *
//******************************************************************************
module dpram_16x30bit(
   //Clock.
   input  wire        clk,          //Clock input.
   
   //A port: read/write
   //Write is synchronous to the clk, read is asynchronous.
   input  wire [3:0]  addr_a,       //Address input.
   input  wire        wren_a,       //Write enable input.
   input  wire [29:0] din_a,        //Input data.
   output wire [29:0] dout_a,       //Output data.
   
   //B port: read only
   //Read is asynchronous.
   input  wire [3:0]  addr_b,       //Address input.
   output wire [29:0] dout_b        //Output data.
);

//*****************************************************************************
//* 16 x 30 bit dual-port distributed RAM.                                    *
//*****************************************************************************
(* ram_style="distributed" *)
reg [29:0] dpram [15:0];

always @(posedge clk)
begin
   if (wren_a)
      dpram[addr_a] <= din_a;
end

assign dout_a = dpram[addr_a];
assign dout_b = dpram[addr_b];


endmodule
