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
   input wire clk_in, // 50MHz
   input wire rstn_in, //Active-low reset input
	
   input  wire ctrl1_data,    // joypad 1 input signal
   input  wire ctrl2_data,    // joypad 2 input signal
   output wire ctrl1_clk,      // joypad output clk signal
   output wire ctrl2_clk,     // joypad output latch signal
   output wire ctrl1_latch,     // joypad output latch signal
   output wire ctrl2_latch,     // joypad output latch signal ctrl1_latch
	
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
   .CLKFBOUT_MULT(10),              // Multiply value for all CLKOUT clock outputs (1-64)
   .CLKFBOUT_PHASE(0.0),            // Phase offset in degrees of the clock feedback output (0.0-360.0).
   .CLKIN_PERIOD(20.0),             // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
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

wire rst = sync_shift_reg[7];// SZINKRONIZÁLT!!

//*****************************************************************************
//* PPU                                                                       *
//*****************************************************************************
//cpu
wire rnw;
wire [7:0]  cpu_dout;

wire ph1_rising;
wire ph1_falling;
wire ph2_rising;
wire ph2_falling;

wire [7:0] ppu_to_cpu_din;
wire nmi;

wire [7:0]  ppu_mem_din;
wire [7:0]  ppu_mem_dout;
wire [13:0] ppu_mem_addr;
wire        ppu_mem_wr_request;
//wire        ppu_mem_read_request;

ppu_top ppu(
   .clk(clk), // 25 MHz
	.rst(rst),
	.clk_2x(clk_2x), // 50 MHz clock signal
   .clk_10x(clk_10x), // 250 MHz
	.bufpll_locked(bufpll_locked),
   .serdes_strobe(serdes_strobe),

   // Clk En outputs for peripheral	
	.ph1_rising_outw(ph1_rising),
	.ph1_falling_outw(ph1_falling),
	.ph2_rising_outw(ph2_rising),
	.ph2_falling_outw(ph2_falling),

    // register interface or interface to cpu
	.slv_mem_addr(cpu_addr[2:0]),      // register interface reg select (#2000-#2007)
	.slv_mem_cs((cpu_addr[15:13] == 3'b001)),       // register interface enable (#2000 - #3FFF just when it is active)
	.slv_mem_rnw(rnw),       // register interface cpu read not write
	.slv_mem_din(cpu_dout),       // register interface data in (cpu data lane)
	.slv_mem_dout(ppu_to_cpu_din),       // register interface data out (cpu data lane)

	.irq(nmi),

	// PPU interface for memory access
	.ppu_mem_din(ppu_mem_din),
	.ppu_mem_dout(ppu_mem_dout),
	.ppu_mem_addr(ppu_mem_addr),
	.ppu_mem_wr_request(ppu_mem_wr_request),
	//.ppu_mem_read_request(ppu_mem_read_request),

	//Output TMDS signals.
   .tmds_data0_out_p(tmds_data0_out_p),    //TMDS DATA0 line.
   .tmds_data0_out_n(tmds_data0_out_n),
   .tmds_data1_out_p(tmds_data1_out_p),    //TMDS DATA1 line.
   .tmds_data1_out_n(tmds_data1_out_n),
   .tmds_data2_out_p(tmds_data2_out_p),    //TMDS DATA2 line.
   .tmds_data2_out_n(tmds_data2_out_n),
   .tmds_clock_out_p(tmds_clock_out_p),    //TMDS CLOCK signal.
   .tmds_clock_out_n(tmds_clock_out_n) 
);

//*****************************************************************************
//* CPU                                                                       *
//*****************************************************************************
wire ready;
wire [7:0] cpu_din = (memory_manager_cpu_din | ppu_to_cpu_din | controller_cpu_din);
wire [15:0] ag6502_addr;
wire [7:0]  ag6502_dout;
wire ag6502_rnw;

nes_cpu6502 cpu(
   //Clock and reset.
   .clk(clk),                //System clock signal.
   .rst(rst),                //System reset signal.
   .ph1_rising(ph1_rising),         //Rising edge of the phase 1 clock.
   .ph1_falling(ph1_falling),        //Falling edge of the phase 1 clock.
   .ph2_rising(ph2_falling),         //Rising edge of the phase 2 clock.
   .ph2_falling(ph2_falling),        //Falling edge of the phase 2 clock.
   
   //Master bus interface.
   .mst_mem_rnw(ag6502_rnw),        //Read/write select signal.
   .mst_mem_address(ag6502_addr),    //Address bus.
   .mst_mem_dout(ag6502_dout),       //Data bus.
   .mst_mem_din(cpu_din),
   
   //Interrupt and DMA request.
   .int_n(1'b1),              //INT request signal (active-low).
   .nmi_n(nmi),              //NMI request signal (falling edge).
   .ready(ready)               //When low, the CPU stops at read cycles.
);

//*****************************************************************************
//* Sprite DMA                                                                *
//*****************************************************************************
wire [15:0] dma_cpu_addr;
wire [7:0]  dma_cpu_dout;
wire        dma_cpu_avalid;
wire        dma_cpu_rnw;
wire [15:0] cpu_addr;


reg even_cycle;

always @(posedge clk) 
begin
   if (rst)
      even_cycle <= 1'b0;
   else
      if (ph2_falling)
         even_cycle <= ~even_cycle;   
end

sprite_dma sprite_dma(
   .clk(clk),
   .rst(rst),
   .ph1_rising(ph1_rising),
   .ph2_rising(ph2_rising),
   .ph2_falling(ph2_falling),

   // control signal
   .even_cycle(even_cycle), // even cpu clock cycles

   // out control signals
   // used for block cpu until dma cycles
   .ready(ready),      // when low the cpu stops at read cycles

   // Slave bus interface (cpu adress space, write only)
   // Using for the time when cpu activates oam and dmc dma
   .slv_mem_select(ag6502_addr[15:14] == 2'b01), 
   .slv_mem_rnw(ag6502_rnw),    
   .slv_mem_addr(ag6502_addr[4:0]),  // [4:0] ag6502_addr
   .slv_mem_din(ag6502_dout),  // [7:0]

    // Master bus interface
    // CPU bus interface overtaken when DMA is active
   .mst_mem_rnw(dma_cpu_rnw),    
   .mst_mem_address(dma_cpu_addr),
   .mst_mem_avalid(dma_cpu_avalid),
   .mst_mem_dout(dma_cpu_dout),
   .mst_mem_din(cpu_din)
);

assign cpu_addr = (dma_cpu_avalid) ? (dma_cpu_addr) : (ag6502_addr);
assign cpu_dout = (dma_cpu_dout | ag6502_dout);
assign rnw = (dma_cpu_rnw | ag6502_rnw);

//*****************************************************************************
//* Memory manager                                                            *
//*****************************************************************************
wire [7:0] memory_manager_cpu_din;

memory_manager_v2_top  #(.NT_MIRRORING(2'b01)) memory_manager (
	//clock and rst signals
	.clk(clk),
	.rst(rst),
	.ph2_rising(ph2_rising),
	.ph2_falling(ph2_falling),

    // CPU interface for memory acess master
	.cpu_addr(cpu_addr), //[15:0]
	.cpu_rnw(rnw), 
	.cpu_data_out(memory_manager_cpu_din), // output [7:0]
	.cpu_data_in(cpu_dout), // [7:0]

	// Memory inerface slave
	.ppu_wr_req(ppu_mem_wr_request), 
	//.ppu_rd_req(ppu_mem_read_request), 
	.ppu_addr(ppu_mem_addr), // [13:0]
	.ppu_din(ppu_mem_dout), // [7:0]
	.ppu_dout(ppu_mem_din) //output [7:0]
);

//*****************************************************************************
//* Controller ports                                                          *
//*****************************************************************************

wire [7:0] controller_cpu_din;

wire controller_clk;
wire controller_latch;

controller_top controller_top(
    //clock
   .clk(clk),
   .rst(rst),
   .ph2_falling(ph2_falling),

    // CPU interface for memory acess master
	.cpu_addr(cpu_addr), // [15:0]
	.cpu_rnw(rnw), 
	.cpu_data_out(controller_cpu_din), // output [7:0]
	.cpu_data_in(cpu_dout[0]), //just one bit the $4016 write strobe

    //controller output signals
   .controller_data1(ctrl1_data),    // joypad 1 input signal
   .controller_data2(ctrl2_data),    // joypad 2 input signal
   .controller1_out_clk(ctrl1_clk),      // joypad output clk signal
   .controller2_out_clk(ctrl2_clk),      // joypad output clk signal
   .controller_out_latch(controller_latch)     // joypad output latch signal
);

assign ctrl1_latch = controller_latch;     
assign ctrl2_latch = controller_latch;


/*
vga_top vga_top(
   .clk(clk), // 25 MHz clock signal 
   .clk_2x(clk_2x), // 50 MHz clock signal
   .clk_10x(clk_10x), // 250 MHz
	.bufpll_locked(bufpll_locked),
   .serdes_strobe(serdes_strobe),
   .rst(rst),

   .blue_din(8'd0),     // Blue data in
   .green_din(8'd128),     // Green data in
   .red_din(8'd0),        // Red data in

   //Output TMDS signals.
   .tmds_data0_out_p(tmds_data0_out_p),    //TMDS DATA0 line.
   .tmds_data0_out_n(tmds_data0_out_n),
   .tmds_data1_out_p(tmds_data1_out_p),    //TMDS DATA1 line.
   .tmds_data1_out_n(tmds_data1_out_n),
   .tmds_data2_out_p(tmds_data2_out_p),    //TMDS DATA2 line.
   .tmds_data2_out_n(tmds_data2_out_n),
   .tmds_clock_out_p(tmds_clock_out_p),    //TMDS CLOCK signal.
   .tmds_clock_out_n(tmds_clock_out_n)
);
*/
endmodule
