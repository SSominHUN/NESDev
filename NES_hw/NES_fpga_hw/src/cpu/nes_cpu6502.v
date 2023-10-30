`timescale 1ns / 1ps

module nes_cpu6502(
   //Clock and reset.
   input  wire        clk,                //System clock signal.
   input  wire        rst,                //System reset signal.
   input  wire        ph1_rising,         //Rising edge of the phase 1 clock.
   input  wire        ph1_falling,        //Falling edge of the phase 1 clock.
   input  wire        ph2_rising,         //Rising edge of the phase 2 clock.
   input  wire        ph2_falling,        //Falling edge of the phase 2 clock.
   
   //Master bus interface.
   output wire        mst_mem_rnw,        //Read/write select signal.
   output wire [15:0] mst_mem_address,    //Address bus.
   output wire [7:0]  mst_mem_dout,       //Data bus.
   input  wire [7:0]  mst_mem_din,
   
   //Interrupt and DMA request.
   input  wire        int_n,              //INT request signal (active-low).
   input  wire        nmi_n,              //NMI request signal (falling edge).
   input  wire        ready               //When low, the CPU stops at read cycles.
);


endmodule
