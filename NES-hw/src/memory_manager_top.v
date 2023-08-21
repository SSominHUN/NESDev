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
	parameter NT_MIRRORING = 0,
	parameter SRAM_PATTERN_START = 18'd0,
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
	output 	wire 	[17:0] 		sram_addr, // size is 18 bit?
	input 	wire 	[7:0] 		sram_din,
	output 	wire 	[7:0] 		sram_dout,
	output 	wire 	[7:0] 		sram_data_t,

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
//SRAM_AWIDTH = 17, SRAM_DWIDTH = 8
//*****************************************************************************
//* SRAM data input reg	                                           			  *
//*****************************************************************************

(* iob = "force" *)


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
reg [15:0] sram_data_t_reg = 16'hFFFF; // what is t? {SRAM_WIDTH {1'b1}} replicator operator sram_width = 3 reg = 3'b111;

always @ (posedge clk)
begin
	if (rst)
	begin //we set the registers and change to SRAM_IDLE
		sram_csn_reg <= 1'b1;
		sram_oen_reg <= 1'b1;
		sram_wen_reg <= 1'b1;
		sram_data_t_reg <= 8'hFF;
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
						sram_data_t_reg <= 8'h00;
						sram_state <= SRAM_WRITE;
					end
				else
					if (cpu_sram_rd_req || ppu_sram_rd_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b0;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 8'hFF;
						sram_state <= SRAM_READ;
					end
					else
					begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 8'hFF;
						sram_state <= SRAM_IDLE;
					end

			READ:
				if (cpu_sram_wr_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b0;
						sram_data_t_reg <= 8'h00;
						sram_state <= SRAM_WRITE;
					end
				else
					if(cpu_sram_rd_req || ppu_sram_rd_req)
					begin
						sram_csn_reg <= 1'b0;
						sram_oen_reg <= 1'b0;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 8'hFF;
						sram_state <= SRAM_READ;
					end
					else
					begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 8'hFF;
						sram_state <= SRAM_IDLE;
					end

			WRITE:	begin
						sram_csn_reg <= 1'b1;
						sram_oen_reg <= 1'b1;
						sram_wen_reg <= 1'b1;
						sram_data_t_reg <= 8'hFF;
						sram_state <= SRAM_IDLE;
					end

			default: sram_state <= SRAM_IDLE;
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

//*****************************************************************************
//* Nametable RAM		                                                      *
//*****************************************************************************

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
wire [7:0] ppu_data_out_wire;

assign ppu_data_out_wire = (en_ppu_pt_read) ? sram_to_ppu_data_reg : out_reg_ppu;
assign ppu_data_out = (en_ppu_pt_read || en_ppu_NT) ? ppu_data_out_wire : 8'dx;

endmodule
