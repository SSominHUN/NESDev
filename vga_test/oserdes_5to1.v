//******************************************************************************
//* FPGA implementation of the Nintendo Entertainment System (NES).            *
//*                                                                            *
//* 5 bit to 1 bit serializer with differential output.                        *
//* Version      : 1.0                                                         *
//* Last modified: 2011.10.11.                                                 *
//*                                                                            *
//* Copyright (c) 2010-2011 Tamas Raikovich (rtamas@mit.bme.hu)                *
//* All rights reserved.                                                       *
//*                                                                            *
//* For educational purposes only. Redistribution of the source code or the    *
//* synthesized form, with or without modification, is not permitted.          *
//******************************************************************************
module oserdes_5to1(
   //Clock and reset.
   input wire       clk,               //1x clock input.
   input wire       clk_5x,            //5x clock input.
   input wire       rst,               //Asynchronous reset signal.
   
   //Input data.
   input wire [4:0] data_in,           //5 bit data input.
   input wire       serdes_strobe,     //Serdes data capture signal.
   
   //Differential serial data output.
   output wire      dout_p,            //Serial data output (+).
   output wire      dout_n             //Serial data output (-).
);

//*****************************************************************************
//* Master OSERDES.                                                           *
//*****************************************************************************
wire [7:0] oserdes_din = {3'd0, data_in};
wire       iob_dout;
wire       cascade_di;
wire       cascade_do;
wire       cascade_ti;
wire       cascade_to;

OSERDES2 #(
   .BYPASS_GCLK_FF("FALSE"),           // Bypass CLKDIV syncronization registers (TRUE/FALSE)
   .DATA_RATE_OQ("SDR"),               // Output Data Rate ("SDR" or "DDR")
   .DATA_RATE_OT("SDR"),               // 3-state Data Rate ("SDR" or "DDR")
   .DATA_WIDTH(5),                     // Parallel data width (2-8)
   .OUTPUT_MODE("DIFFERENTIAL"),       // "SINGLE_ENDED" or "DIFFERENTIAL" 
   .SERDES_MODE("MASTER"),             // "NONE", "MASTER" or "SLAVE" 
   .TRAIN_PATTERN(0)                   // Training Pattern (0-15)
) master_oserdes (
   .OQ(iob_dout),                      // 1-bit output: Data output to pad or IODELAY2
   .SHIFTOUT1(cascade_di),             // 1-bit output: Cascade data output
   .SHIFTOUT2(cascade_ti),             // 1-bit output: Cascade 3-state output
   .SHIFTOUT3(),                       // 1-bit output: Cascade differential data output
   .SHIFTOUT4(),                       // 1-bit output: Cascade differential 3-state output
   .TQ(),                              // 1-bit output: 3-state output to pad or IODELAY2
   .CLK0(clk_5x),                      // 1-bit input: I/O clock input
   .CLK1(1'b0),                        // 1-bit input: Secondary I/O clock input
   .CLKDIV(clk),                       // 1-bit input: Logic domain clock input
   .D1(oserdes_din[4]),                // D1 - D4: 1-bit (each) input: Parallel data inputs
   .D2(oserdes_din[5]),
   .D3(oserdes_din[6]),
   .D4(oserdes_din[7]),
   .IOCE(serdes_strobe),               // 1-bit input: Data strobe input
   .OCE(1'b1),                         // 1-bit input: Clock enable input
   .RST(rst),                          // 1-bit input: Asynchrnous reset input
   .SHIFTIN1(1'b1),                    // 1-bit input: Cascade data input
   .SHIFTIN2(1'b1),                    // 1-bit input: Cascade 3-state input
   .SHIFTIN3(cascade_do),              // 1-bit input: Cascade differential data input
   .SHIFTIN4(cascade_to),              // 1-bit input: Cascade differential 3-state input
   .T1(1'b0),                          // T1 - T4: 1-bit (each) input: 3-state control inputs
   .T2(1'b0),
   .T3(1'b0),
   .T4(1'b0),
   .TCE(1'b1),                         // 1-bit input: 3-state clock enable input
   .TRAIN(1'b0)                        // 1-bit input: Training pattern enable input
);


//*****************************************************************************
//* Slave OSERDES.                                                            *
//***************************************************************************** 
OSERDES2 #(
   .BYPASS_GCLK_FF("FALSE"),           // Bypass CLKDIV syncronization registers (TRUE/FALSE)
   .DATA_RATE_OQ("SDR"),               // Output Data Rate ("SDR" or "DDR")
   .DATA_RATE_OT("SDR"),               // 3-state Data Rate ("SDR" or "DDR")
   .DATA_WIDTH(5),                     // Parallel data width (2-8)
   .OUTPUT_MODE("DIFFERENTIAL"),       // "SINGLE_ENDED" or "DIFFERENTIAL" 
   .SERDES_MODE("SLAVE"),              // "NONE", "MASTER" or "SLAVE" 
   .TRAIN_PATTERN(0)                   // Training Pattern (0-15)
) slave_oserdes (
   .OQ(),                              // 1-bit output: Data output to pad or IODELAY2
   .SHIFTOUT1(),                       // 1-bit output: Cascade data output
   .SHIFTOUT2(),                       // 1-bit output: Cascade 3-state output
   .SHIFTOUT3(cascade_do),             // 1-bit output: Cascade differential data output
   .SHIFTOUT4(cascade_to),             // 1-bit output: Cascade differential 3-state output
   .TQ(),                              // 1-bit output: 3-state output to pad or IODELAY2
   .CLK0(clk_5x),                      // 1-bit input: I/O clock input
   .CLK1(1'b0),                        // 1-bit input: Secondary I/O clock input
   .CLKDIV(clk),                       // 1-bit input: Logic domain clock input
   .D1(oserdes_din[0]),                // D1 - D4: 1-bit (each) input: Parallel data inputs
   .D2(oserdes_din[1]),
   .D3(oserdes_din[2]),
   .D4(oserdes_din[3]),
   .IOCE(serdes_strobe),               // 1-bit input: Data strobe input
   .OCE(1'b1),                         // 1-bit input: Clock enable input
   .RST(rst),                          // 1-bit input: Asynchrnous reset input
   .SHIFTIN1(cascade_di),              // 1-bit input: Cascade data input
   .SHIFTIN2(cascade_ti),              // 1-bit input: Cascade 3-state input
   .SHIFTIN3(1'b1),                    // 1-bit input: Cascade differential data input
   .SHIFTIN4(1'b1),                    // 1-bit input: Cascade differential 3-state input
   .T1(1'b0),                          // T1 - T4: 1-bit (each) input: 3-state control inputs
   .T2(1'b0),
   .T3(1'b0),
   .T4(1'b0),
   .TCE(1'b1),                         // 1-bit input: 3-state clock enable input
   .TRAIN(1'b0)                        // 1-bit input: Training pattern enable input
);
 
 
//*****************************************************************************
//* Differential output buffer.                                               *
//*****************************************************************************
OBUFDS output_buffer(.I(iob_dout), .O(dout_p), .OB(dout_n));


endmodule
