`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:01 07/10/2023 
// Design Name: 
// Module Name:    memory_manager_top 
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
module memory_manager_top #(
	parameter NT_MIRRORING = 2'b01,
	parameter SRAM_CH_ROM_OFFSET = 18'h8000, //32 Kbyte program RAM h4000 16kbyte
	parameter SRAM_PROGRAM_START = 18'd0
)(
	//clock and rst signals
	input 	wire 				clk,
	input	wire				rst,
	input	wire				ph1_rising,
	input	wire				ph1_falling,
	input	wire				ph2_rising,
	input	wire				ph2_falling,

	//Output controll signals
	output	wire				ready, //low -> cpu stops at reading cycles
	output	wire				cpu_apu_rst,

	// external SRAM interface
	output 	wire 				sram_csn, 
	output 	wire 				sram_oen,
	output 	wire 				sram_wen,
	output 	wire 				sram_lbn,
	output 	wire 				sram_hbn,
	output 	wire 	[17:0] 		sram_addr,

	input 	wire 	[15:0] 		sram_data_in, //IO data bus
	output 	wire 	[15:0] 		sram_data_out,
	output 	wire 	[15:0] 		sram_data_t,

    // CPU interface for memory acess master
	output 	wire 	[15:0] 		cpu_addr,
	output 	wire 				cpu_rnw,
	output 	wire 				cpu_ce,
	output 	wire 	[7:0] 		cpu_data_out,
	input 	wire 	[7:0] 		cpu_data_in,

	// Memory inerface slave
	input 	wire 				ppu_mem_wr_req, //mem write request signal
	input 	wire 				ppu_mem_rd_req, //mem read request signal
	input 	wire 	[13:0] 		ppu_mem_addr,
	input 	wire 	[7:0] 		ppu_mem_din,
	output 	reg 	[7:0] 		ppu_mem_dout

	);
//CPU SRAM address
//*****************************************************************************
//* CPU SRAM address                                         				  *
//*****************************************************************************
wire [17:0] cpu_sram_address;
wire		cpu_sram_sel = (cpu_addr[15:13] != 3'b000);

localparam CPU_WORK_RAM_OFFSET = 18'd2048;

assign cpu_sram_address = {2'd0,cpu_addr} - CPU_WORK_RAM_OFFSET;

//PPU SRAM address
//*****************************************************************************
//* PPU SRAM address	                                           			  *
//*****************************************************************************
wire		ppu_sram_sel = ~ppu_mem_addr[13]; // when the PPU acces the character rom
wire [17:0] ppu_sram_address;

assign ppu_sram_address = {5'd0,ppu_mem_addr[12:0]} + SRAM_CH_ROM_OFFSET; //just 8kbyte 

//CPU address space ... 
// 2 kbyte of work ram for 
//*****************************************************************************
//* 2 KByte on board CPU memory	                                   			  *
//*****************************************************************************
(* ram_style = "block" *)
reg	 [7:0]	cpu_work_ram [2047:0];
reg	 [7:0]	cpu_work_ram_dout;
wire [10:0]	cpu_work_ram_addr = cpu_addr [10:0];			 //cpu inner memory access
wire		cpu_work_ram_sel  = (cpu_addr[15:13] == 3'b000); //0x0000-0x07FF and the mirrors until 0x1FFF
reg			cpu_work_ram_rd_ack;

always @ (posedge clk) 
begin
	if (rst || cpu_work_ram_rd_ack)
		cpu_work_ram_rd_ack <= 1'b0;
	else
		if (ph2_rising && cpu_rnw && cpu_work_ram_sel)
			cpu_work_ram_rd_ack <= 1'b1;
end

always @ (posedge clk)
begin
	if (cpu_work_ram_sel) 
	begin
		if (ph2_falling && (cpu_rnw == 0))
			cpu_work_ram[cpu_work_ram_addr] <= cpu_data_in;
		cpu_work_ram_dout <= cpu_work_ram[cpu_work_ram_addr];
	end
end

//PPU address space
//2 kbyte of name & attribute table ram
//*****************************************************************************
//* 2 KByte on board PPU name table memory                       			  *
//*	with the basic mirrorings and bases for future mappers					  *																		
//*****************************************************************************
reg  [1:0] 	ppu_name_table_addr_h;
reg	 [1:0]	mapper_mirroring; //in the future if we have a mapper

always @ (*)
begin
	case (NT_MIRRORING)
		// Horizontal Mirroring
		2'b00: ppu_name_table_addr_h <= {1'b0, ppu_mem_addr[11]};
		// Verical Mirroring
		2'b01: ppu_name_table_addr_h <= {1'b0, ppu_mem_addr[10]};
		// Mappers Mirroring
		2'b10: ppu_name_table_addr_h <= mapper_mirroring;
		// Four-screen mirroring 
		2'b11: ppu_name_table_addr_h <= {ppu_mem_addr[11:10]};
	endcase
end

(* ram_style = "block" *)
reg  [7:0] 		name_table_ram [2047:0];
reg  [7:0] 		name_table_ram_reg;
reg  [7:0] 		name_table_ram_dout;
wire [7:0]		ppu_name_table_dout;
wire [11:0]		ppu_name_table_addr = {ppu_name_table_addr_h, ppu_mem_addr[9:0]};
wire			ppu_name_table_sel = ppu_mem_addr[13]; //when the ppu would like to read NT or AT

//2 kbyte name table memory
always @(posedge clk)
begin
	if (ppu_name_table_sel) 
	begin
		if (ppu_mem_wr_req)
			name_table_ram[ppu_name_table_addr[10:0]] <= ppu_mem_din;
		name_table_ram_reg <= name_table_ram[ppu_name_table_addr[10:0]];
		name_table_ram_dout <= name_table_ram_reg;
	end
end

//Generating the SRAM access request and acknowledge signals
//*****************************************************************************
//* Generating the SRAM access request and acknowledge signals             	  *
//*****************************************************************************
reg		cpu_sram_read_req;
wire	cpu_sram_read	= ph2_rising & cpu_sram_sel & cpu_rnw; 
wire	cpu_sram_rd_req	= cpu_sram_read | cpu_sram_read_req;
wire	cpu_sram_wr_req	= ph2_falling & cpu_sram_sel & ~cpu_rnw;
wire	ppu_sram_rd_req	= ppu_mem_rd_req & ppu_sram_sel;

always @(posedge clk) // if cpu and ppu request comes in the same time we wait give the sram to the ppu
begin
	if (rst || cpu_sram_read_req)
		cpu_sram_read_req <= 1'b0;
	else
		if (ppu_sram_rd_req)
			cpu_sram_read_req <= cpu_sram_read;	
end

reg	[2:0]	cpu_sram_rd_ack;

always @(posedge clk) 
begin
	if (rst)
		cpu_sram_rd_ack <= 3'b000;
	else
		if (cpu_sram_read)
			if (ppu_sram_rd_req)
				cpu_sram_rd_ack <= 3'b001;
			else
				cpu_sram_rd_ack <= 3'b010;
		else
			cpu_sram_rd_ack <= {cpu_sram_rd_ack[1:0], 1'b0}; //we sift if we dont read
end	

//driving the sram address bus and the byte enable signals
//*****************************************************************************
//* Driving the sram address bus and the byte enable signals    			  *
//*****************************************************************************
localparam ADDR_LSB = 1;
localparam ADDR_MSB = 17; //18 addrwidth + addr_lsb - 1

(* iob = "force" *)
reg  [17:0] 		sram_address_reg;
wire [2:0] 			sram_address_sel;
wire				sram_din_sel;

//External SRAM address select signals
assign sram_address_sel[2] = cpu_sram_wr_req;
assign sram_address_sel[1] = ppu_sram_rd_req;
assign sram_address_sel[0] = cpu_sram_rd_req;

always @ (posedge clk)
begin
	casex (sram_address_sel)
		3'b1xx : sram_address_reg <= cpu_sram_address[ADDR_MSB:ADDR_LSB];
		3'b01x : sram_address_reg <= ppu_sram_address[ADDR_MSB:ADDR_LSB];
		3'b001 : sram_address_reg <= cpu_sram_address[ADDR_MSB:ADDR_LSB];
		default: sram_address_reg <= 18'h0000;
	endcase
end

assign sram_addr = sram_address_reg;

(* iob = "force" *)
reg	 [1:0]	sram_byte_mask_reg;
reg  [1:0]	sram_din_sel_reg;

always @ (posedge clk) 
begin
	casex (sram_addr_sel)
		3'b1xx : sram_byte_mask_reg <= {~cpu_sram_address[0], cpu_sram_address[0]};
		3'b01x : sram_byte_mask_reg <= {~ppu_sram_address[0], ppu_sram_address[0]};
		3'b001 : sram_byte_mask_reg <= {~cpu_sram_address[0], cpu_sram_address[0]};
		default: sram_byte_mask_reg <= 2'b11;
	endcase	
end

//external SRAM input data lower/upper byte select
always @ (posedge clk) 
begin
	casex (sram_addr_sel)
		3'b1xx : sram_din_sel_reg[0] <= cpu_sram_address[0];
		3'b01x : sram_din_sel_reg[0] <= ppu_sram_address[0];
		3'b001 : sram_din_sel_reg[0] <= cpu_sram_address[0];
		default: sram_din_sel_reg[0] <= 1'b0;
	endcase
	sram_din_sel_reg[1] <= sram_din_sel_reg[0];
end

assign sram_lbn	= sram_byte_mask_reg[0];
assign sram_hbn	= sram_byte_mask_reg[1];
assign sram_din_sel	= sram_din_sel_reg[1];

//*****************************************************************************
//* Driving SRAM data out bus	                                			  *
//*****************************************************************************
(* iob = "force" *)
reg [15:0] sram_data_out_reg;

always @ (posedge clk)
begin
	if (cpu_sram_wr_req) 
		sram_data_out_reg <= {cpu_data_in, cpu_data_in}; // {2 {cpu_data_in}}
end

assign sram_data_out = sram_data_out_reg;

//sram input data register
//*****************************************************************************
//* SRAM data input reg	                                           			  *
//*****************************************************************************

(* iob = "force" *)
reg	  [15:0] 	sram_data_in_reg;
wire			sram_data_in_reg_ld; //if SRAM in READ state
wire  [7:0]		sram_din; //case of NES just 8bit data is acquired

always @ (posedge clk)
begin
	if (sram_data_in_reg_ld)
		sram_data_in_reg <= sram_data_in;
end

//we get the choosen data (the upper or lover 8 bit)
assign sram_din = (sram_din_sel) ? sram_data_in_reg[15:8] : sram_data_in_reg[7:0];

//generating sram controll siganls
//*****************************************************************************
//* SRAM interface	                                            			  *
//*****************************************************************************

localparam SRAM_IDLE = 2'd0;
localparam SRAM_READ = 2'd1;
localparam SRAM_WRITE = 2'd2;

reg [1:0] sram_state;
(* iob = "force" *)
reg	sram_csn_reg = 1'b1;
(* iob = "force" *)
reg	sram_oen_reg = 1'b1;
(* iob = "force" *)
reg	sram_wen_reg = 1'b1;
(* iob = "force" *)
reg [15:0] sram_data_t_reg = 16'hFFFF; // t is type

always @ (posedge clk)
begin
	if (rst)
	begin //we set the registers and change to SRAM_IDLE
		sram_csn_reg <= 1'b1;
		sram_oen_reg <= 1'b1;
		sram_wen_reg <= 1'b1;
		sram_data_t_reg <= 16'hFFFF;
		sram_state <= SRAM_IDLE;
	end
	else
		case (sram_state)
			IDLE: 
				if (cpu_sram_wr_req) //if we get a cpu request
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b0;
						sram_data_t_reg <= 16'h0000;
						sram_state <= SRAM_WRITE;
					end
				else
					if (cpu_sram_rd_req || ppu_sram_rd_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b0;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 16'hFFFF;
						sram_state <= SRAM_READ;
					end
					else
					begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 16'hFFFF;
						sram_state <= SRAM_IDLE;
					end

			READ:
				if (cpu_sram_wr_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b0;
						sram_data_t_reg <= 16'h0000;
						sram_state <= SRAM_WRITE;
					end
				else
					if(cpu_sram_rd_req || ppu_sram_rd_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b0;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 16'hFFFF;
						sram_state <= SRAM_READ;
					end
					else
					begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 16'hFFFF;
						sram_state <= SRAM_IDLE;
					end

			WRITE:	begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 16'hFFFF;
						sram_state <= SRAM_IDLE;
					end

			default: sram_state <= SRAM_IDLE;
		endcase
end

//SRAM input data register load signal
assign sram_data_in_reg_ld = (sram_state == SRAM_READ);

//SRAM controll signals
assign sram_csn			=	sram_csn_reg;
assign sram_oen			=	sram_oen_reg;
assign sram_wen			=	sram_wen_reg;
assign sram_data_t		=	sram_data_t_reg;

//driving the cpu read data bus
//*****************************************************************************
//* CPU databus driving			                                              *
//*****************************************************************************
wire [1:0] cpu_mem_dout_sel;

assign cpu_mem_dout_sel[0]	=	cpu_sram_sel;
assign cpu_mem_dout_sel[1]	=	cpu_work_ram_sel;

always @ (*) // van olyan amikor nem kell meghelytani?
begin
	if (~cpu_sram_rd_ack[2] | ~cpu_work_ram_rd_ack)
		cpu_data_out <= 8'd0;
	else
	begin
		case (ppu_mem_dout_sel)
			2'b01:	 cpu_data_out <= sram_din;
			2'b10: 	 cpu_data_out <= cpu_work_ram_dout;
			default: cpu_data_out <= 8'd0;
		endcase	
	end
end

//driving the ppu read data bus
//*****************************************************************************
//* PPU databus driving			                                              *
//*****************************************************************************
wire [1:0] ppu_mem_dout_sel;

assign ppu_mem_dout_sel[0]	=	ppu_sram_sel;
assign ppu_mem_dout_sel[1]	=	ppu_name_table_sel;

always @ (*) 
begin
	case (ppu_mem_dout_sel)
		2'b01:	 ppu_mem_dout <= sram_din;
		2'b10: 	 ppu_mem_dout <= ppu_name_table_dout;
		default: ppu_mem_dout <= 8'd0;
	endcase	
end
//*****************************************************************************
//* PATTERN DATA SRAM interface	                                              *
//*****************************************************************************
/*
reg [1:0] sram_state;
reg [1:0] next_sram_state;

wire en_ppu_pt_read;
wire en_cpu_sram_read;
wire en_cpu_sram_write; // maybe not need because on run CPU does not write SRAM

assign en_ppu_pt_read = (ppu_read_request && (ppu_addr >= 14'h1FFF)) ? 1'b1 : 1'b0;
assign en_cpu_sram_read = cpu_rnw; // if we understand the cpu we can build from this
assign en_cpu_sram_write = ~cpu_rnw;

always @ (posedge clk)
begin
	if (rst)
		sram_state <= IDLE;
	else
		sram_state <= next_sram_state;
end

//PPU does not write the pattern table
always @ (*)
begin
	case (sram_state)
		IDLE: begin
			if (en_ppu_pt_read || en_cpu_sram_read)
				next_sram_state <= READ;
			else if (en_cpu_sram_write)
				next_sram_state <= WRITE;
			else
				next_sram_state <= IDLE;
		end
		READ: begin
			if (~en_ppu_pt_read || ~en_cpu_sram_read)
				next_sram_state <= IDLE;
			else
				next_sram_state <= READ;
		end
		WRITE: begin
			if (~en_cpu_sram_write)
				next_sram_state <= IDLE;
			else
				next_sram_state <= WRITE;
		end
		default: begin
			next_state <= 2'bxx;
		end
	endcase
end

// can be * too? pr posedge clk
// ce enable always enabeled? 
// hbn, lbn -> in read always
always @ (*)
begin
	case (sram_state)
		IDLE: begin
			sram_addr_reg <= 18'dx;
			sram_cen_reg <= 1'b1;
			sram_oen_reg <= 1'b1;
			sram_wen_reg <= 1'b1;
			sram_hbn_reg <= 1'b1;
			sram_lbn_reg <= 1'b1;
		end
		READ: begin
			if (en_ppu_pt_read)
			begin
				sram_addr_reg <= SRAM_PATTERN_START + {ppu_addr[13:1], 0};
				sram_cen_reg <= 1'b0;
				sram_oen_reg <= 1'b0;
				sram_hbn_reg <= 1'b0;
				sram_lbn_reg <= 1'b0;
				if (ppu_addr[0])
					sram_to_ppu_data_reg <= sram_dio [7:0];
				else
					sram_to_ppu_data_reg <= sram_dio [15:8];
			end
			else
			begin
				sram_addr_reg <= SRAM_PROGRAM_START + {cpu_addr[15:1], 0};
				sram_cen_reg <= 1'b0;
				sram_oen_reg <= 1'b0;
				sram_hbn_reg <= 1'b0;
				sram_lbn_reg <= 1'b0;
				if (cpu_addr[0])
					sram_to_cpu_data_reg <= sram_dio [7:0];
				else
					sram_to_cpu_data_reg <= sram_dio [15:8];
			end
		end
		WRITE: begin //undefined? hogy valósítsam meg az írást?
				sram_addr_reg <= SRAM_PROGRAM_START + cpu_addr[15:1];
				sram_cen_reg <= 1'b0;
				sram_wen_reg <= 1'b0;
				if (cpu_addr[0]) 
				begin
					sram_dio_reg <= {8'dx, cpu_data_in};
					sram_hbn_reg <= 1'b1;
					sram_lbn_reg <= 1'b0;
				end
				else
				begin
					sram_dio_reg <= {cpu_data_in, 8'dx};
					sram_hbn_reg <= 1'b0;
					sram_lbn_reg <= 1'b1;
				end
		end
		default: begin
			sram_addr_reg <= 18'dx;
			sram_cen_reg <= 1'b1;
			sram_oen_reg <= 1'b1;
			sram_wen_reg <= 1'b1;
			sram_hbn_reg <= 1'b1;
			sram_lbn_reg <= 1'b1;
		end
	endcase
end

assign sram_dio = (en_cpu_sram_read) ? 16'hZZZZ : sram_dio_reg; //not sure for hzzzz
assign sram_addr = sram_addr_reg;
assign sram_cen = sram_cen_reg;
assign sram_oen = sram_oen_reg;
assign sram_wen = sram_wen_reg;
assign sram_lbn = sram_lbn_reg;
assign sram_hbn = sram_hbn_reg;
*/

//*****************************************************************************
//* Nametable mirroring and addr PPU side                                     *
//*****************************************************************************
/*
wire en_ppu_NT;

//h2000 -> start of NT | h3EFF end of NT
assign en_ppu_NT = ((ppu_addr >= 14'h2000) && (ppu_addr <= 14'h3EFF) && ppu_read_request) ? 1'b1 : 1'b0;

parameter VERTICAL_MIRRORING = 2'd0;
parameter HORIZONTAL_MIRRORING = 2'd1;
parameter SINGLE_SCREEN = 2'd2;
parameter FOUR_SCREEN = 2'd3;

parameter START_OF_2ND_NR = 12'h400;
parameter END_OF_2ND_NR = 12'h7FF;
parameter START_OF_3RD_NT = 12'h800;
parameter END_OF_3RD_NT = 12'hBFF;
parameter START_OF_4TH_NT = 12'hC00;
parameter END_OF_4TH_NT = 12'hFFF;

reg [11:0] ppu_addr_reg;

always@(posedge clk)
begin
if (en_ppu_NT)
	case(NT_MIRRORING)
		VERTICAL_MIRRORING: begin
			if (ppu_addr[11:0] >= START_OF_3RD_NT && ppu_addr[11:0] <= END_OF_4TH_NT)
				ppu_addr_reg <= ppu_addr[11:0] - START_OF_3RD_NT;
			else
				ppu_addr_reg <= ppu_addr[11:0];			
		end
		HORIZONTAL_MIRRORING: begin
			if ((ppu_addr[11:0] >= START_OF_2ND_NR && ppu_addr[11:0] <= END_OF_2ND_NR) 
			|| (ppu_addr[11:0] >= START_OF_4TH_NT && ppu_addr[11:0] <= END_OF_4TH_NT))
				ppu_addr_reg <= ppu_addr[11:0] - START_OF_2ND_NR;
			else
				ppu_addr_reg <= ppu_addr[11:0];
		end
		SINGLE_SCREEN: begin
			if (ppu_addr[11:0] >= START_OF_2ND_NR && ppu_addr[11:0] <= END_OF_2ND_NR)
				ppu_addr_reg <= ppu_addr[11:0] - START_OF_2ND_NR;
			else if (ppu_addr[11:0] >= START_OF_3RD_NT && ppu_addr[11:0] <= END_OF_3RD_NT)
				ppu_addr_reg <= ppu_addr[11:0] - START_OF_3RD_NT;
			else if (ppu_addr[11:0] >= START_OF_4TH_NT && ppu_addr[11:0] <= END_OF_4TH_NT)
				ppu_addr_reg <= ppu_addr[11:0] - START_OF_4TH_NT;
			else
				ppu_addr_reg <= ppu_addr[11:0];
		end
		FOUR_SCREEN: begin
			ppu_addr_reg <= ppu_addr[11:0];
		end
		default: begin
			ppu_addr_reg <= ppu_addr[11:0];
		end
	endcase
end
*/
//*****************************************************************************
//* Nametable RAM		                                                      *
//*****************************************************************************
/*
//4k byte NT for four screen
(*ram_style = BLOCK*)
reg [7:0] nametable [4095:0];

reg [7:0] out_reg_ppu;
//reg [7:0] out_reg_cpu;

wire we_ppu;
//wire we_cpu;

//wire en_cpu_NT;

always @(posedge clk)
if (en_ppu_NT) 
begin
	if (we_ppu)
		nametable[ppu_addr_reg] <= ppu_data_in;
	out_reg_ppu <= nametable[ppu_addr_reg];
end
*/ 
/*
always @(posedge clk)
if (en_cpu_NT) 
begin
	if (we_cpu)
		nametable[addr_cpu] <= cpu_data_in;
	out_reg_cpu <= nametable[addr_cpu];
end
*/
//*****************************************************************************
//* Data outs			                                                      *
//*****************************************************************************
/*
wire [7:0] ppu_data_out_wire;

assign ppu_data_out_wire = (en_ppu_pt_read) ? sram_to_ppu_data_reg : out_reg_ppu;
assign ppu_data_out = (en_ppu_pt_read || en_ppu_NT) ? ppu_data_out_wire : 8'dx;
*/
endmodule
