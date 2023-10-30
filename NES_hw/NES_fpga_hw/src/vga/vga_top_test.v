`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:03:56 10/25/2023
// Design Name:   vga_top
// Module Name:   D:/NESDev/NES-hw/src/vga/vga_top_test.v
// Project Name:  NES-hw
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_top_test;

// Inputs
reg clk;
reg rst;

localparam END_OF_RENDERING_LINE = 11'd1599;
localparam PRERENDERING_ROW = 9'd261;		
localparam FIRST_RENDERING_ROW = 9'd0;

localparam START_OF_SHIFT = 11'd131;
localparam FINE_VERTICAL_CNT_UP = 11'd1155;	
localparam END_OF_VISIBLE_FRAME_ROW = 9'd239;

//ppu background rendering counters
reg [10:0] x_rendercntr = 11'd0;
reg [8:0] y_renderingcntr = 9'd0;
//nes x rendering
always @ (posedge clk)
begin
	if (rst || (x_rendercntr == END_OF_RENDERING_LINE))
		x_rendercntr <= 11'd0;
	else
		x_rendercntr <= x_rendercntr + 11'd1;
end
//original nes y rendering
always @ (posedge clk)
begin
	if (rst)
		y_renderingcntr <= PRERENDERING_ROW;
	else if (x_rendercntr == END_OF_RENDERING_LINE)
		if (y_renderingcntr == PRERENDERING_ROW)
			y_renderingcntr <= 9'd0;
		else 
			y_renderingcntr <= y_renderingcntr + 9'd1;
end

// rgb data to render vga 
(* ram_style = "block" *)
reg  [23:0] 	palette_rgb_rom [511:0];
initial begin
	$readmemh( "src/ppu/rgb_rom/rgb_rom_888_24bit.txt" , palette_rgb_rom); 
end
reg  [23:0] 	palette_rgb_rom_dout;

// MASK for blank black value
// 0-256 x_rendercnt

wire [8:0] 		palette_rgb_rom_address = 	((x_rendercntr > START_OF_SHIFT) 
											&& (x_rendercntr <= FINE_VERTICAL_CNT_UP) 
											&& (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW)) ? 
											(9'd19) : (9'd13); 
											
//9'd13 is black //&& (x_rendercntr <= FINE_VERTICAL_CNT_UP) && (y_renderingcntr <= END_OF_VISIBLE_FRAME_ROW) && ~(~background_clipping && first_column)

//wire [8:0] 		palette_rgb_rom_address = 9'd13;

always @(posedge clk)
begin
	palette_rgb_rom_dout <= palette_rgb_rom[palette_rgb_rom_address];
end

wire [7:0] blue_din = palette_rgb_rom_dout[23:16];
wire [7:0] green_din = palette_rgb_rom_dout[15:8];
wire [7:0] red_din = palette_rgb_rom_dout[7:0];


//*****************************************************************************
//* Generating hsync vsynck and blank                                         *
//*****************************************************************************
wire vga_en = (startupcntr == START_OF_VGA_RENDERING);

localparam START_OF_VGA_RENDERING = 12'd3201; // a rendszernek lehet extra késleltetése ez csak a 2 sor (1600 + 1600 + 4) - 1

reg [11:0] startupcntr = 12'd0;

always @ (posedge clk)
begin
	if (rst)
		startupcntr <= 12'd0;
	else if (~vga_en)
		startupcntr <= startupcntr + 12'd1;
end

//*****************************************************************************
//* 640 x 480 @ 60 Hz VGA timing parameters (25 MHz pixel clock).             *
//*****************************************************************************
localparam H_VISIBLE = 10'd640;
localparam H_FRONT_PORCH = 10'd16;
localparam H_SYNC_PULSE = 10'd96;
localparam H_BACK_PORCH = 10'd48;

localparam V_VISIBLE = 10'd480;
localparam V_FRONT_PORCH = 10'd10;
localparam V_SYNC_PULSE = 10'd2;
localparam V_BACK_PORCH = 10'd32;

localparam H_BLANK_BEGIN = H_VISIBLE - 1;
localparam H_SYNC_BEGIN = H_BLANK_BEGIN + H_FRONT_PORCH;
localparam H_SYNC_END = H_SYNC_BEGIN + H_SYNC_PULSE;
localparam H_BLANK_END = H_SYNC_END + H_BACK_PORCH;

localparam V_BLANK_BEGIN = V_VISIBLE - 1;
localparam V_SYNC_BEGIN = V_BLANK_BEGIN + V_FRONT_PORCH;
localparam V_SYNC_END = V_SYNC_BEGIN + V_SYNC_PULSE;
localparam V_BLANK_END = V_SYNC_END + V_BACK_PORCH;

//*****************************************************************************
//* Horizontal counter.                                                       *
//*****************************************************************************
reg [9:0] h_cnt = 10'd0;

always @(posedge clk)
begin
   if (rst || (h_cnt == H_BLANK_END))
      h_cnt <= 10'd0;
   else
      if (vga_en)
         h_cnt <= h_cnt + 10'd1;
end


//*****************************************************************************
//* Vertical counter.                                                         *
//*****************************************************************************
reg [9:0] v_cnt = 10'd0;


//&& vga_en
always @(posedge clk)
begin
   if (rst)
      v_cnt <= 10'd0;
   else
      if ((h_cnt == H_BLANK_END) && vga_en) 
         if (v_cnt == V_BLANK_END)
            v_cnt <= 10'd0;
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

wire blank = (h_blank | v_blank);

//*****************************************************************************
//* Generating controll signals for                                           *
//*****************************************************************************
parameter END_OF_PPU_RENDERING = 11'd1599;
parameter END_OF_VGA_RENDERING = 10'd799;

reg [10:0] x_ppucntr = 11'd0;

//|| (startupcntr == 12'd3) 3203 || (startupcntr == 12'd0)
always @ (posedge clk)
begin
	if (rst || (x_ppucntr == END_OF_PPU_RENDERING)) 
		x_ppucntr <= 11'd0;
	else
      if(startupcntr > 12'd0)
		   x_ppucntr <= x_ppucntr + 11'd1;
end

reg buff_sel = 1'd0;

//we change the written buffers
always @ (posedge clk) 
begin
   if (rst)
      buff_sel <= 1'd0;
   else if (x_ppucntr == END_OF_PPU_RENDERING)
      buff_sel <= ~buff_sel;
end

// reg buff sel for 

reg [9:0] x_writecntr = 10'd0;

//cntr for writing the two buffers
//|| (startupcntr == 12'd3)|| (startupcntr == 12'd0)
always @ (posedge clk)
begin
	if (rst) 
		x_writecntr <= 10'd0;
	else if(x_ppucntr[0] == 1'b0)
      //if(startupcntr > 12'd3)
         if (x_writecntr == END_OF_VGA_RENDERING)
            x_writecntr <= 10'd0;
         else
		      x_writecntr <= x_writecntr + 10'd1;
end

//*****************************************************************************
//* RGB in one BRAM                                                           *
//*****************************************************************************
reg [23:0] buff1_dout;
reg [23:0] buff2_dout;

(*ram_style = "BLOCK"*)
reg [23:0] buffer_1 [1023:0];

always@(posedge clk)
begin
   if (buff_sel)//&& (x_ppucntr[0] == 1'b0)
      buffer_1[x_writecntr] <= {blue_din, green_din, red_din};
   buff1_dout <= buffer_1[h_cnt];
end

(*ram_style = "BLOCK"*)
reg [23:0] buffer_2 [1023:0];

always@(posedge clk)
begin
   if (~buff_sel) // && (x_ppucntr[0] == 1'b0)
      buffer_2[x_writecntr] <= {blue_din, green_din, red_din};
   buff2_dout <= buffer_2[h_cnt];
end

//olvasásnál buff sel késlelteni kell
wire [7:0] red = (buff_sel)   ? (buff2_dout[7:0])   : (buff1_dout[7:0]);
wire [7:0] green = (buff_sel) ? (buff2_dout[15:8])  : (buff1_dout[15:8]);
wire [7:0] blue = (buff_sel)  ? (buff2_dout[23:16]) : (buff1_dout[23:16]);

//*****************************************************************************
//* Generating the picture data.                                              *
//*****************************************************************************
reg [7:0] red_reg = 8'd0;
reg [7:0] green_reg = 8'd0;
reg [7:0] blue_reg = 8'd0;
reg       hsync_reg = 1'b1;
reg       vsync_reg = 1'b1;
reg       blank_reg = 1'b0;

always @(posedge clk)
begin
   hsync_reg <= h_sync;
   vsync_reg <= v_sync;
   blank_reg <= (h_blank | v_blank);
end

vga_top vga_top(
   	.clk(clk), // 25 MHz clock signal 
   	.clk_2x(), // 50 MHz clock signal
   	.clk_10x(), // 250 MHz
	   .bufpll_locked(),
   	.serdes_strobe(),
   	.rst(rst),

   	.blue_din(blue_din),     // Blue data in
   	.green_din(green_din),     // Green data in
   	.red_din(red_din),        // Red data in

   	//Output TMDS signals.
   	.tmds_data0_out_p(),    //TMDS DATA0 line.
   	.tmds_data0_out_n(),
   	.tmds_data1_out_p(),    //TMDS DATA1 line.
   	.tmds_data1_out_n(),
   	.tmds_data2_out_p(),    //TMDS DATA2 line.
   	.tmds_data2_out_n(),
   	.tmds_clock_out_p(),    //TMDS CLOCK signal.
   	.tmds_clock_out_n()
   	);

initial begin 
    forever begin
    clk = 0;
    #10 clk = ~clk;
 end 
 end

initial begin
	// Initialize Inputs
	rst = 1;

	// Wait 100 ns for global reset to finish
	#50;
	rst = 0;
        
	// Add stimulus here

end
      
endmodule

