`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:12 09/30/2023 
// Design Name: 
// Module Name:    sprite_dma 
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
module sprite_dma(
    input wire        clk,
    input wire        rst,
    input wire        ph1_rising,
    input wire        ph2_rising,
    input wire        ph2_falling,

    // control signal
    input wire        even_cycle, // even cpu clock cycles

    // out control signals
    // used for block cpu until dma cycles
    output reg        ready,      // when low the cpu stops at read cycles

    // Slave bus interface (cpu adress space, write only)
    // Using for the time when cpu activates oam and dmc dma
    input wire        slv_mem_select, 
    input wire        slv_mem_rnw,    
    input wire [4:0]  slv_mem_addr,   
    input wire [7:0]  slv_mem_din,    

    // Master bus interface
    // CPU bus interface overtaken when DMA is active
    output reg        mst_mem_rnw,    
    output reg [15:0] mst_mem_address,
    output reg        mst_mem_avalid,
    output reg  [7:0] mst_mem_dout,
    input  wire [7:0] mst_mem_din
    );
//*****************************************************************************
//* 0x14 and oam dma select -> addr decode                         			  *
//*****************************************************************************
wire ppu_dma_reg_wr = slv_mem_select & ~slv_mem_rnw & (slv_mem_addr == 5'b10100);

//*****************************************************************************
//* PPU OAM DMA address cntr	                                   			  *
//*****************************************************************************
reg [7:0] oam_dma_addr_lsb; // least significant byte (lower 8 bit)
reg [7:0] oam_dma_addr_msb; // most significant byte (higher 8 bit)
wire      oam_dma_addr_ld = ph2_falling && ppu_dma_reg_wr;
wire      oam_dma_addr_inc;
wire      last_oam_dma_cycle = (oam_dma_addr_lsb == 8'hFF);

always @(posedge clk) 
begin
    if (rst || oam_dma_addr_ld)
        oam_dma_addr_lsb <= 8'd0;
    else
        if (oam_dma_addr_inc)
            oam_dma_addr_lsb <= oam_dma_addr_lsb + 8'd1;    
end

always @(posedge clk) 
begin
    if (rst)
        oam_dma_addr_msb <= 8'd0;
    else
        if (oam_dma_addr_ld)
            oam_dma_addr_msb <= slv_mem_din;    
end

//*****************************************************************************
//* PPU OAM DMA input data register                               			  *
//*****************************************************************************
reg [7:0] oam_dma_din_reg;
wire      oam_dma_din_reg_ld;

always @(posedge clk) 
begin
    if (oam_dma_din_reg_ld)
        oam_dma_din_reg <= mst_mem_din;    
end

//*****************************************************************************
//* PPU OAM DMA controller FSM                                    			  *
//*****************************************************************************
localparam OAM_DMA_IDLE = 3'd0;
localparam OAM_DMA_WAIT1 = 3'd1;
localparam OAM_DMA_WAIT2 = 3'd2;
localparam OAM_DMA_READ = 3'd3;
localparam OAM_DMA_WRITE = 3'd4;

reg [2:0] oam_dma_state;

always @(posedge clk) 
begin
    if (rst)
        oam_dma_state <= OAM_DMA_IDLE;
    else
        case (oam_dma_state)
            // in IDLE we wait for dma_reg 4014 to be written in this ready is high
            OAM_DMA_IDLE:   if (ppu_dma_reg_wr)
                                if (even_cycle)
                                    oam_dma_state <= OAM_DMA_WAIT2;
                                else
                                    oam_dma_state <= OAM_DMA_WAIT1;
                            else
                                oam_dma_state <= OAM_DMA_IDLE;
            // if we were on non even cycle then we have to wait two
            OAM_DMA_WAIT1: oam_dma_state <= OAM_DMA_WAIT2;
            // if we were on an even cycle we need to wait one
            OAM_DMA_WAIT2: oam_dma_state <= OAM_DMA_READ;
            //Read and write cycles until we reach 256
            OAM_DMA_READ: oam_dma_state <= OAM_DMA_WRITE;

            OAM_DMA_WRITE:  if (last_oam_dma_cycle)
                                oam_dma_state <= OAM_DMA_IDLE;
                            else
                                oam_dma_state <= OAM_DMA_READ;

            default: oam_dma_state <= OAM_DMA_IDLE;
        endcase    
end

//OAM DMA address cntr increment signal
assign oam_dma_addr_inc = ph2_falling & (oam_dma_state == OAM_DMA_WRITE);

//OAM DMA input data register load signal
assign oam_dma_din_reg_ld = ph2_falling & (oam_dma_state == OAM_DMA_READ);

//*****************************************************************************
//* Generating ready signal for CPU                                			  *
//*****************************************************************************
always @(posedge clk) 
begin
    if (rst)
        ready <= 1'b1;
    else
        if (ph1_rising)
            ready <= (oam_dma_state == OAM_DMA_IDLE);   // idealy the dmc dma hardver have to be idle too to crate this signal 
                                                        //dmc_dma have to be in idle too   
end

//*****************************************************************************
//* Master bus interface signals for OAM DMA                                  *
//*****************************************************************************

//*****************************************************************************
//* Read/Write select signal of the master bus interface                      *
//*****************************************************************************
always @(posedge clk) 
begin
    if (rst)
        mst_mem_rnw <= 1'b1;
    else
        if (ph1_rising)
            mst_mem_rnw <= ~(oam_dma_state == OAM_DMA_WRITE);    
end

//*****************************************************************************
//* Driving the address bus of the master bus interface                       *
//*****************************************************************************
wire [1:0] address_sel;

assign address_sel[1] = (oam_dma_state == OAM_DMA_READ);
assign address_sel[0] = (oam_dma_state == OAM_DMA_WRITE);

always @(posedge clk) 
begin
    if (rst)
        mst_mem_address <= 16'd0;
    else
        if (ph1_rising)
            casex (address_sel)
                2'b1x: mst_mem_address <= {oam_dma_addr_msb, oam_dma_addr_lsb}; // read from the cpu_work_ram
                2'b01: mst_mem_address <= 16'h2004; // write into the PPU #2004
            endcase    
end

//*****************************************************************************
//* Address valid signal of the master bus interface                          *
//*****************************************************************************
always @(posedge clk) 
begin
    if (rst)
        mst_mem_avalid <= 1'b0;
    else
        if (ph1_rising)
            mst_mem_avalid <= |address_sel;    
end

//*****************************************************************************
//* Output data of the master bus interface                                   *
//*****************************************************************************
always @(posedge clk) 
begin
    if (rst || ph2_falling)
        mst_mem_dout <= 8'd0;
    else
        if (ph2_rising && (oam_dma_state == OAM_DMA_WRITE))
            mst_mem_dout <= oam_dma_din_reg;    
end

endmodule
