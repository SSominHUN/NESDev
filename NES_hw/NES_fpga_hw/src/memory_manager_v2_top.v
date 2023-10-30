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
module memory_manager_v2_top #(
	parameter NT_MIRRORING = 2'b01
)(
	//clock and rst signals
	input 	wire 				clk,
	input	wire				rst,
	input	wire				ph2_rising,
	input	wire				ph2_falling,

    // CPU interface for memory acess master
	input 	wire 	[15:0] 		cpu_addr,
	input 	wire 				cpu_rnw, 
	output 	reg 	[7:0] 		cpu_data_out,
	input 	wire 	[7:0] 		cpu_data_in,

	// Memory inerface slave
	input 	wire 				ppu_wr_req, 
	//input 	wire 				ppu_rd_req, 
	input 	wire 	[13:0] 		ppu_addr,
	input 	wire 	[7:0] 		ppu_din,
	output 	reg 	[7:0] 		ppu_dout

	);
//*****************************************************************************
//* 2 KByte on board CPU memory	                                   			  *
//*****************************************************************************
(* ram_style = "block" *)
reg	 [7:0]	cpu_work_ram [2047:0];
reg	 [7:0]	cpu_work_ram_dout;
wire [10:0]	cpu_work_ram_addr = cpu_addr[10:0];			 //cpu inner memory access
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

//*****************************************************************************
//* 32 KByte NES cartridge program memory	                         		  *
//*****************************************************************************
(* ram_style = "block" *)
reg	 [7:0]	cpu_prog_rom [32767:0]; // 32 kbyte 32767
initial begin
	$readmemh( "src/games/Super_Mario_Bros_prg_rom_hex.txt" , cpu_prog_rom); //Super_Mario_Bros_prg_rom.txt
end
reg	 [7:0]	cpu_prog_rom_dout;
wire [14:0]	cpu_prog_rom_addr = cpu_addr[14:0];			 
wire		cpu_prog_rom_sel  = cpu_addr[15]; 
reg			cpu_prog_rom_rd_ack;

always @ (posedge clk) 
begin
	if (rst || cpu_prog_rom_rd_ack)
		cpu_prog_rom_rd_ack <= 1'b0;
	else
		if (ph2_rising && cpu_rnw && cpu_prog_rom_sel)
			cpu_prog_rom_rd_ack <= 1'b1;
end

always @ (posedge clk)
begin
	//if (cpu_prog_rom_sel) 
	//begin
		//if (ph2_falling && (cpu_rnw == 0))
		//	cpu_prog_rom[{1'd0, cpu_prog_rom_addr}] <= cpu_data_in;
		cpu_prog_rom_dout <= cpu_prog_rom[{1'd0, cpu_prog_rom_addr}];
	//end
end

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
		2'b00: ppu_name_table_addr_h <= {1'b0, ppu_addr[11]};
		// Verical Mirroring
		2'b01: ppu_name_table_addr_h <= {1'b0, ppu_addr[10]};
		// Mappers Mirroring
		2'b10: ppu_name_table_addr_h <= mapper_mirroring;
		// Four-screen mirroring 
		2'b11: ppu_name_table_addr_h <= {ppu_addr[11:10]};
	endcase
end

(* ram_style = "block" *)
reg  [7:0] 		name_table_ram [2047:0];
reg  [7:0] 		name_table_ram_reg;
reg  [7:0] 		name_table_ram_dout;
wire [11:0]		ppu_name_table_addr = {ppu_name_table_addr_h, ppu_addr[9:0]};
wire			ppu_name_table_sel = ppu_addr[13]; //when the ppu would like to read NT or AT

//2 kbyte name table memory
always @(posedge clk)
begin
	if (ppu_name_table_sel) 
	begin
		if (ppu_wr_req)
			name_table_ram[ppu_name_table_addr[10:0]] <= ppu_din;
		name_table_ram_reg <= name_table_ram[ppu_name_table_addr[10:0]];
	end
end

always @(posedge clk) 
begin
	if (ppu_name_table_sel) 
		name_table_ram_dout <= name_table_ram_reg;
end

//*****************************************************************************
//* 8 KByte NES cartridge character ROM		                     			  *
//*	Pattern Table															  *
//*****************************************************************************
(* ram_style = "block" *)
reg  [7:0] 		ch_rom [8191:0];
initial begin
	$readmemh( "src/games/Super_Mario_Bros_chr_rom_hex.txt" , ch_rom); //Super_Mario_Bros_chr_rom.txt
end
reg  [7:0] 		ch_rom_reg;
reg  [7:0] 		ch_rom_dout;
wire [12:0] 	ppu_ch_rom_address = ppu_addr[12:0];
wire			ppu_ch_rom_sel = ~ppu_addr[13]; // when the PPU acces the character rom
// maybe we need ppu_rd_req 

//2 kbyte name table memory
always @(posedge clk)
begin
	//if (ppu_ch_rom_sel) 
	//begin
		ch_rom_reg <= ch_rom[ppu_ch_rom_address];
	//end
end

always @(posedge clk) 
begin
	//if (ppu_ch_rom_sel) 
		ch_rom_dout <= ch_rom_reg;
end

//*****************************************************************************
//* CPU databus driving			                                              *
//*****************************************************************************
wire [1:0] cpu_mem_dout_sel;

assign cpu_mem_dout_sel[0]	=	cpu_prog_rom_rd_ack;
assign cpu_mem_dout_sel[1]	=	cpu_work_ram_rd_ack;

//we use cpu data out just when its necessary other wise byte of 0 
always @ (posedge clk)
begin
	if (rst || ph2_falling)
		cpu_data_out <= 8'd0;
	else
	begin
		case (cpu_mem_dout_sel)
			2'b01:	 cpu_data_out <= cpu_prog_rom_dout;
			2'b10: 	 cpu_data_out <= cpu_work_ram_dout;
		endcase	
	end
end

//*****************************************************************************
//* PPU databus driving			                                              *
//*****************************************************************************
wire [1:0] ppu_mem_dout_sel;

assign ppu_mem_dout_sel[0]	=	ppu_ch_rom_sel;
assign ppu_mem_dout_sel[1]	=	ppu_name_table_sel;

always @ (*) 
begin
	case (ppu_mem_dout_sel)
		2'b01:	 ppu_dout <= ch_rom_dout; //pattern rom
		2'b10: 	 ppu_dout <= name_table_ram_dout;
		default: ppu_dout <= 8'd0;
	endcase	
end

endmodule
