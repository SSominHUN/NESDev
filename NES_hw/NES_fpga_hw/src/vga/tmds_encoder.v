//******************************************************************************
//* FPGA implementation of the Nintendo Entertainment System (NES).            *
//*                                                                            *
//* TMDS encoder for the DVI/HDMI interface.                                   *
//* Version      : 1.0                                                         *
//* Last modified: 2011.10.11.                                                 *
//*                                                                            *
//* Copyright (c) 2010-2011 Tamas Raikovich (rtamas@mit.bme.hu)                *
//* All rights reserved.                                                       *
//*                                                                            *
//* For educational purposes only. Redistribution of the source code or the    *
//* synthesized form, with or without modification, is not permitted.          *
//******************************************************************************
module tmds_encoder(
   //Clock and reset.
   input  wire       clk,        //Clock input.
   input  wire       rst,        //Asynchronous reset input.
   
   //Input data.
   input  wire [7:0] data_in,    //Input pixel data to encode.
   input  wire       data_en,    //Input data enable signal.
   input  wire       ctrl0_in,   //Control signals.
   input  wire       ctrl1_in,
   
   //Output data.
   output reg  [9:0] tmds_out    //TMDS data output.
);

//*****************************************************************************
//* Counting the number of ones (1) in the input pixel data.                  *
//* Number of pipeline stages: 1                                              *
//*****************************************************************************
reg [7:0] data_in_reg;
reg [3:0] din_num_of_1s;

always @(posedge clk)
begin
   data_in_reg   <= data_in;
   din_num_of_1s <= ((data_in[0] + data_in[1]) + (data_in[2] + data_in[3])) +
                    ((data_in[4] + data_in[5]) + (data_in[6] + data_in[7]));
end


//*****************************************************************************
//* Stage 1 of the TMDS encoding: 8 bit -> 9 bit.                             *
//* Number of pipeline stages: 1                                              *
//*****************************************************************************
wire       decision1 = (din_num_of_1s > 4'd4) | ((din_num_of_1s == 4'd4) & ~data_in_reg[0]);
wire [8:0] stage1;
reg  [8:0] stage1_out;

assign stage1[0] = data_in_reg[0];
assign stage1[1] = (stage1[0] ^ data_in_reg[1]) ^ decision1;
assign stage1[2] = (stage1[1] ^ data_in_reg[2]) ^ decision1;
assign stage1[3] = (stage1[2] ^ data_in_reg[3]) ^ decision1;
assign stage1[4] = (stage1[3] ^ data_in_reg[4]) ^ decision1;
assign stage1[5] = (stage1[4] ^ data_in_reg[5]) ^ decision1;
assign stage1[6] = (stage1[5] ^ data_in_reg[6]) ^ decision1;
assign stage1[7] = (stage1[6] ^ data_in_reg[7]) ^ decision1;
assign stage1[8] = ~decision1;

always @(posedge clk)
begin
   stage1_out <= stage1;
end


//*****************************************************************************
//* Counting the number of ones (1) and zeroes (0) in the stage 1 output.     *
//* Number of pipeline stages: 1                                              *
//*****************************************************************************
reg  [8:0] stage2_in;
reg  [3:0] s1_num_of_1s;
reg  [3:0] s1_num_of_0s;

wire [3:0] s1_bit_sum = ((stage1_out[0] + stage1_out[1]) + (stage1_out[2] + stage1_out[3])) +
                        ((stage1_out[4] + stage1_out[5]) + (stage1_out[6] + stage1_out[7]));

always @(posedge clk)
begin
   stage2_in    <= stage1_out;
   s1_num_of_1s <= s1_bit_sum;
   s1_num_of_0s <= 4'd8 - s1_bit_sum;
end


//*****************************************************************************
//* Pipeline registers for the data enable and the control signals.           *
//*****************************************************************************
reg [2:0] data_en_reg;
reg [5:0] ctrl_reg;

always @(posedge clk)
begin
   if (rst)
      data_en_reg <= 3'd0;
   else
      data_en_reg <= {data_en_reg[1:0], data_en};
end

always @(posedge clk)
begin
   if (rst)
      ctrl_reg <= 6'd0;
   else
      ctrl_reg <= {ctrl_reg[3:0], ctrl1_in, ctrl0_in};
end


//*****************************************************************************
//* Stage 2 of the TMDS encoding: 9 bit -> 10 bit.                            *
//*****************************************************************************
localparam CTRL_TOKEN_0 = 10'b1101010100;
localparam CTRL_TOKEN_1 = 10'b0010101011;
localparam CTRL_TOKEN_2 = 10'b0101010100;
localparam CTRL_TOKEN_3 = 10'b1010101011;

//Disparity counter (MSB is the sign bit).
reg [4:0] cnt;

wire decision2 = (cnt == 5'd0) | (s1_num_of_1s == s1_num_of_0s);
wire decision3 = (~cnt[4] & (s1_num_of_1s > s1_num_of_0s)) | (cnt[4] & (s1_num_of_1s < s1_num_of_0s));


always @(posedge clk or posedge rst)
begin
   if (rst || (data_en_reg[2] == 0))
      cnt <= 5'd0;
   else
      if (decision2)
         cnt <= (stage2_in[8]) ? (cnt + (s1_num_of_1s - s1_num_of_0s)) : (cnt + (s1_num_of_0s - s1_num_of_1s));
      else
         if (decision3)
            cnt <= cnt + {stage2_in[8], 1'b0}  + (s1_num_of_0s - s1_num_of_1s);
         else
            cnt <= cnt - {~stage2_in[8], 1'b0} + (s1_num_of_1s - s1_num_of_0s);
end

always @(posedge clk or posedge rst)
begin
   if (rst)
      tmds_out <= 10'd0;
   else
      if (data_en_reg[2])
         if (decision2)
            tmds_out <= {~stage2_in[8], stage2_in[8], stage2_in[7:0] ^ {8{~stage2_in[8]}}};
         else
            if (decision3)
               tmds_out <= {1'b1, stage2_in[8], ~stage2_in[7:0]};
            else
               tmds_out <= {1'b0, stage2_in[8], stage2_in[7:0]};
      else
         case (ctrl_reg[5:4])
            2'b00: tmds_out <= CTRL_TOKEN_0;
            2'b01: tmds_out <= CTRL_TOKEN_1;
            2'b10: tmds_out <= CTRL_TOKEN_2;
            2'b11: tmds_out <= CTRL_TOKEN_3;
         endcase
end


endmodule
