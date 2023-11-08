////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: nes_cpu_test.v
// /___/   /\     Timestamp: Wed Nov 01 00:47:12 2023
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -ofmt verilog -sim -w -dir D:\NESDev\NES_hw\NES_fpga_hw\src\cpu D:\NESDev\NES_hw\NES_fpga_hw\src\cpu\nes_cpu6502.ngc nes_cpu_test.v 
// Device	: xc6slx9-2-tqg144
// Input file	: D:/NESDev/NES_hw/NES_fpga_hw/src/cpu/nes_cpu6502.ngc
// Output file	: D:\NESDev\NES_hw\NES_fpga_hw\src\cpu\nes_cpu_test.v
// # of Modules	: 1
// Design Name	: nes_cpu6502
// Xilinx        : D:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module nes_cpu6502 (
  clk, rst, ph1_rising, ph1_falling, ph2_rising, ph2_falling, int_n, nmi_n, ready, mst_mem_rnw, mst_mem_din, mst_mem_address, mst_mem_dout
);
  input clk;
  input rst;
  input ph1_rising;
  input ph1_falling;
  input ph2_rising;
  input ph2_falling;
  input int_n;
  input nmi_n;
  input ready;
  output mst_mem_rnw;
  input [7 : 0] mst_mem_din;
  output [15 : 0] mst_mem_address;
  output [7 : 0] mst_mem_dout;
  wire \NlwRenamedSig_OI_cpu6502/controller/mem_rnw ;
  wire N0;
  wire N1;
  wire \cpu6502/decoder/_n0035 ;
  wire \cpu6502/decoder/_n0040_0 ;
  wire \cpu6502/Reset_OR_DriverANDClockEnable ;
  wire \cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ;
  wire \cpu6502/alu_en ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>_54 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6> ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<0> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<1> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<2> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<3> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<4> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<5> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<6> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<7> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<8> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<9> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<10> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<11> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<12> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<13> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<14> ;
  wire \cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<15> ;
  wire \cpu6502/alu/c_flag_81 ;
  wire \cpu6502/alu/z_flag_82 ;
  wire \cpu6502/alu/i_flag_83 ;
  wire \cpu6502/alu/d_flag_84 ;
  wire \cpu6502/alu/v_flag_85 ;
  wire \cpu6502/alu/n_flag_86 ;
  wire \cpu6502/pc/pc_8_119 ;
  wire \cpu6502/pc/pc_9_120 ;
  wire \cpu6502/pc/pc_10_121 ;
  wire \cpu6502/pc/pc_11_122 ;
  wire \cpu6502/pc/pc_12_123 ;
  wire \cpu6502/pc/pc_13_124 ;
  wire \cpu6502/pc/pc_14_125 ;
  wire \cpu6502/pc/pc_15_126 ;
  wire \cpu6502/controller/set_next_state_127 ;
  wire \cpu6502/controller/b_flag_value_128 ;
  wire \cpu6502/controller/set_i_flag_129 ;
  wire \cpu6502/controller/mem_din_reg_we_130 ;
  wire \cpu6502/controller/alu_enable_131 ;
  wire \cpu6502/controller/inst_reg_we_143 ;
  wire \cpu6502/controller/inst_reg_clr_144 ;
  wire \cpu6502/controller/no_pcl_carry_reg_145 ;
  wire \cpu6502/controller/current_state_FSM_FFd11_148 ;
  wire \cpu6502/addr_gen/address_carry_165 ;
  wire \cpu6502/sreg_to_dout ;
  wire \cpu6502/branch_flag_val ;
  wire \cpu6502/index_reg_sel ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<7>_239 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<6>_240 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<6>_241 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<5>_242 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<5>_243 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<4>_244 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<4>_245 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<3>_246 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<3>_247 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<2>_248 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<2>_249 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<1>_250 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<1>_251 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<0>_252 ;
  wire \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<0>_253 ;
  wire \cpu6502/addr_gen/_n0086_inv ;
  wire \cpu6502/addr_gen/_n0102_inv ;
  wire \cpu6502/addr_gen/_n0094_inv ;
  wire \cpu6502/addr_gen/_n0080_inv ;
  wire \cpu6502/addr_gen/address_carry_GND_7_o_MUX_198_o ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<0> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<1> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<2> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<3> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<4> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<5> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<6> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<7> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<0> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<1> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<2> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<4> ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<5>_280 ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<6>_281 ;
  wire \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<7>_282 ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<0> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<1> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<2> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<3> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<4> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<5> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<6> ;
  wire \cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<7> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<0> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<1> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<2> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<3> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<4> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<5> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<6> ;
  wire \cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<7> ;
  wire \cpu6502/controller/current_state_address_sel<0>2_299 ;
  wire \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 ;
  wire \cpu6502/controller/current_state_FSM_FFd7_301 ;
  wire \cpu6502/controller/current_state_FSM_FFd8_302 ;
  wire \cpu6502/controller/current_state_FSM_FFd19_303 ;
  wire \cpu6502/controller/current_state_FSM_FFd21_304 ;
  wire \cpu6502/controller/current_state_FSM_FFd1-In_305 ;
  wire \cpu6502/controller/current_state_FSM_FFd2-In ;
  wire \cpu6502/controller/current_state_FSM_FFd3-In ;
  wire \cpu6502/controller/current_state_FSM_FFd4-In ;
  wire \cpu6502/controller/current_state_FSM_FFd5-In ;
  wire \cpu6502/controller/current_state_FSM_FFd6-In ;
  wire \cpu6502/controller/current_state_FSM_FFd7-In ;
  wire \cpu6502/controller/current_state_FSM_FFd8-In ;
  wire \cpu6502/controller/current_state_FSM_FFd9-In_313 ;
  wire \cpu6502/controller/current_state_FSM_FFd10-In_314 ;
  wire \cpu6502/controller/current_state_FSM_FFd11-In_315 ;
  wire \cpu6502/controller/current_state_FSM_FFd12-In_316 ;
  wire \cpu6502/controller/current_state_FSM_FFd13-In_317 ;
  wire \cpu6502/controller/current_state_FSM_FFd14-In ;
  wire \cpu6502/controller/current_state_FSM_FFd15-In ;
  wire \cpu6502/controller/current_state_FSM_FFd16-In ;
  wire \cpu6502/controller/current_state_FSM_FFd17-In_321 ;
  wire \cpu6502/controller/current_state_FSM_FFd18-In_322 ;
  wire \cpu6502/controller/current_state_FSM_FFd19-In_323 ;
  wire \cpu6502/controller/current_state_FSM_FFd20-In ;
  wire \cpu6502/controller/current_state_FSM_FFd21-In ;
  wire \cpu6502/controller/current_state_FSM_FFd22-In_326 ;
  wire \cpu6502/controller/current_state_FSM_FFd23-In ;
  wire \cpu6502/controller/current_state_FSM_FFd24-In ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In ;
  wire \cpu6502/controller/current_state_FSM_FFd20-In111 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In22 ;
  wire \cpu6502/controller/current_state_FSM_FFd16-In1 ;
  wire \cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT2 ;
  wire \cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT1 ;
  wire \cpu6502/controller/Reset_OR_DriverANDClockEnable2 ;
  wire \cpu6502/controller/Reset_OR_DriverANDClockEnable1_336 ;
  wire \cpu6502/controller/Reset_OR_DriverANDClockEnable ;
  wire \cpu6502/controller/current_state[4]_PWR_4_o_select_108_OUT<2> ;
  wire \cpu6502/controller/current_state[4]_PWR_4_o_select_83_OUT<3> ;
  wire \cpu6502/controller/current_state[4]_reduce_nor_174_o ;
  wire \cpu6502/controller/branch_taken ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<1> ;
  wire \cpu6502/controller/current_state_FSM_FFd18_343 ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<3> ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<4> ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<5> ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<6> ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<7> ;
  wire \cpu6502/controller/current_state[4]_GND_4_o_Select_62_o_349 ;
  wire \cpu6502/controller/_n0433 ;
  wire \cpu6502/controller/_n0425 ;
  wire \cpu6502/controller/current_state[4]_operation_type[2]_Select_182_o ;
  wire \cpu6502/controller/_n0437 ;
  wire \cpu6502/controller/current_state[4]_mem_operation[1]_Select_167_o ;
  wire \cpu6502/controller/_n0556 ;
  wire \cpu6502/controller/current_state_FSM_FFd12_356 ;
  wire \cpu6502/controller/current_state_FSM_FFd22_357 ;
  wire \cpu6502/controller/current_state_FSM_FFd23_358 ;
  wire \cpu6502/controller/is_interrupt ;
  wire \cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o ;
  wire \cpu6502/controller/operation_type[2]_PWR_4_o_equal_90_o ;
  wire \cpu6502/controller/addr_mode[2]_GND_4_o_equal_25_o ;
  wire \cpu6502/controller/ready_mem_rnw_OR_4_o ;
  wire \cpu6502/controller/int_n_INV_5_o ;
  wire \cpu6502/controller/ph2_rising_nmi_recognized_AND_11_o ;
  wire \cpu6502/controller/ph1_falling_set_next_state_AND_61_o ;
  wire \cpu6502/controller/ph1_falling_current_state[4]_AND_34_o ;
  wire \cpu6502/controller/rst_set_i_flag_OR_110_o ;
  wire \cpu6502/controller/nmi_recognized_369 ;
  wire \cpu6502/controller/nmi_active_370 ;
  wire \cpu6502/controller/int_active_371 ;
  wire \cpu6502/controller/nmi_sample_372 ;
  wire \cpu6502/controller/current_state_FSM_FFd10_373 ;
  wire \cpu6502/controller/current_state_FSM_FFd9_374 ;
  wire \cpu6502/controller/current_state_FSM_FFd15_375 ;
  wire \cpu6502/controller/current_state_FSM_FFd1_376 ;
  wire \cpu6502/controller/current_state_FSM_FFd2_377 ;
  wire \cpu6502/controller/current_state_FSM_FFd5_378 ;
  wire \cpu6502/controller/current_state_FSM_FFd6_379 ;
  wire \cpu6502/controller/current_state_FSM_FFd14_380 ;
  wire \cpu6502/controller/current_state_FSM_FFd13_381 ;
  wire \cpu6502/controller/current_state_FSM_FFd24_382 ;
  wire \cpu6502/controller/current_state_FSM_FFd25_383 ;
  wire \cpu6502/controller/current_state_FSM_FFd3_384 ;
  wire \cpu6502/controller/current_state_FSM_FFd4_385 ;
  wire \cpu6502/controller/current_state_FSM_FFd17_386 ;
  wire \cpu6502/controller/current_state_FSM_FFd16_387 ;
  wire \cpu6502/controller/current_state_FSM_FFd20_388 ;
  wire \cpu6502/controller/rst_active_389 ;
  wire \cpu6502/pc/pc_enable_GND_5_o_AND_67_o ;
  wire \cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ;
  wire \cpu6502/alu/Mmux_alu_negative_3_455 ;
  wire \cpu6502/alu/Mmux_alu_negative_4_456 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg8 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg7 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand6 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg6 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand5 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg5 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand4 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg4 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand3 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg3 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand2 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg2 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand1 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg1_500 ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg_mand_501 ;
  wire \cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ;
  wire \cpu6502/alu/Mcount_stack_ptr_reg ;
  wire \cpu6502/alu/_n0199_inv_504 ;
  wire \cpu6502/alu/_n0221_inv ;
  wire \cpu6502/alu/_n0237_inv ;
  wire \cpu6502/alu/_n0227_inv ;
  wire \cpu6502/alu/c_in ;
  wire \cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ;
  wire \cpu6502/alu/n_flag_mem_in[7]_MUX_185_o ;
  wire \cpu6502/alu/status_op[1]_mem_in[6]_MUX_181_o ;
  wire \cpu6502/alu/status_op[1]_mem_in[3]_MUX_176_o ;
  wire \cpu6502/alu/status_op[1]_mem_in[2]_MUX_171_o ;
  wire \cpu6502/alu/z_flag_mem_in[1]_MUX_166_o ;
  wire \cpu6502/alu/status_op[1]_mem_in[0]_MUX_162_o ;
  wire \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ;
  wire \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ;
  wire \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>1_559 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>2_560 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>1_561 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>2_562 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>1_563 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>2_564 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>1_565 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>2_566 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>1_567 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>2_568 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>1_569 ;
  wire \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>2_570 ;
  wire N4;
  wire N6;
  wire N8;
  wire N10;
  wire N12;
  wire N18;
  wire N20;
  wire N22;
  wire \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3> ;
  wire \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>1_580 ;
  wire \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>2_581 ;
  wire \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>3_582 ;
  wire N24;
  wire \cpu6502/controller/current_state_address_sel<0>1_585 ;
  wire \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<4> ;
  wire N26;
  wire \cpu6502/controller/current_state_FSM_FFd6-In1_588 ;
  wire N28;
  wire N30;
  wire \cpu6502/controller/current_state_FSM_FFd23-In1_591 ;
  wire N34;
  wire \cpu6502/controller/current_state_FSM_FFd21-In1_593 ;
  wire \cpu6502/controller/current_state_FSM_FFd21-In2_594 ;
  wire N36;
  wire \cpu6502/controller/current_state_FSM_FFd20-In1_596 ;
  wire \cpu6502/controller/current_state_FSM_FFd20-In2_597 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In1_598 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In2_599 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In3_600 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In4_601 ;
  wire \cpu6502/controller/current_state_FSM_FFd25-In5_602 ;
  wire N38;
  wire N40;
  wire N42;
  wire \cpu6502/alu/Mmux_alu_result8 ;
  wire \cpu6502/alu/Mmux_alu_result81_607 ;
  wire \cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o1 ;
  wire \cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o11_609 ;
  wire N79;
  wire N81;
  wire N83;
  wire N85;
  wire N87;
  wire N89;
  wire N91;
  wire N93;
  wire \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o1 ;
  wire \cpu6502/controller/nmi_recognized_glue_set_619 ;
  wire \cpu6502/controller/nmi_active_glue_set_620 ;
  wire \cpu6502/controller/rst_active_glue_rst_621 ;
  wire \cpu6502/alu/Madd_n0137_Madd_lut<7>1_622 ;
  wire N100;
  wire N101;
  wire N103;
  wire N104;
  wire N105;
  wire N107;
  wire N108;
  wire N109;
  wire N111;
  wire N112;
  wire N113;
  wire N115;
  wire N116;
  wire N117;
  wire N119;
  wire N120;
  wire N121;
  wire N123;
  wire N124;
  wire N125;
  wire N127;
  wire N128;
  wire N129;
  wire N131;
  wire N132;
  wire \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_lut_648 ;
  wire \cpu6502/alu/Madd_n0137_Madd_cy<7>_l1 ;
  wire \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy1_cy_lut_650 ;
  wire N137;
  wire N139;
  wire N141;
  wire N142;
  wire N143;
  wire N144;
  wire N145;
  wire N146;
  wire N147;
  wire N148;
  wire N149;
  wire N150;
  wire N151;
  wire N152;
  wire N153;
  wire N154;
  wire \cpu6502/addr_gen/address_carry_rstpot_667 ;
  wire \cpu6502/controller/set_i_flag_rstpot_668 ;
  wire \cpu6502/controller/inst_reg_we_rstpot_669 ;
  wire \cpu6502/controller/inst_reg_clr_rstpot_670 ;
  wire \cpu6502/controller/no_pcl_carry_reg_rstpot_671 ;
  wire \cpu6502/alu/c_flag_rstpot_672 ;
  wire \cpu6502/alu/i_flag_rstpot_673 ;
  wire \cpu6502/controller/b_flag_value_rstpot_674 ;
  wire \cpu6502/controller/inst_reg_we_rstpot1_675 ;
  wire \cpu6502/controller/inst_reg_clr_rstpot1_676 ;
  wire \cpu6502/controller/no_pcl_carry_reg_rstpot1_677 ;
  wire \cpu6502_decoder/_n0040_0_inv ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ENB_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_RSTB_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_CLKB_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_REGCEB_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<4>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<13>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<12>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<11>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<10>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<9>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<8>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<7>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<6>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<5>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<4>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<31>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<30>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<29>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<28>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<27>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<26>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<25>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<24>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<23>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<22>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<21>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<20>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<19>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<18>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<17>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<16>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<15>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<14>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<13>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<12>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<11>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<10>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<9>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<8>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<7>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<6>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<5>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<4>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<31>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<30>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<29>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<28>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<27>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<26>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<25>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<24>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<23>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<22>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<21>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<20>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<19>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<18>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<17>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<16>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<15>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<14>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<13>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<12>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<11>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<10>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<9>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<8>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<7>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<6>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<5>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<4>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<0>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<3>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<2>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<1>_UNCONNECTED ;
  wire \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<0>_UNCONNECTED ;
  wire [15 : 0] \cpu6502/mst_mem_address ;
  wire [7 : 0] \cpu6502/mst_mem_dout ;
  wire [7 : 0] \cpu6502/alu/result_reg ;
  wire [7 : 0] \cpu6502/alu/stack_ptr_reg ;
  wire [7 : 0] \cpu6502/alu/y_reg ;
  wire [7 : 0] \cpu6502/alu/x_reg ;
  wire [7 : 0] \cpu6502/pc/pc ;
  wire [7 : 0] \cpu6502/controller/addr_ctrl_signals ;
  wire [2 : 0] \cpu6502/controller/stack_ctrl_signals ;
  wire [1 : 0] \cpu6502/data_out_sel ;
  wire [1 : 0] \cpu6502/address_sel ;
  wire [2 : 1] \cpu6502/controller/vector_to_load ;
  wire [3 : 0] \cpu6502/controller/pc_operation ;
  wire [7 : 0] \cpu6502/mem_din_reg ;
  wire [7 : 0] \cpu6502/addr_gen/addr2_l_reg ;
  wire [7 : 0] \cpu6502/addr_gen/addr2_h_reg ;
  wire [7 : 0] \cpu6502/addr_gen/addr1_reg ;
  wire [5 : 0] \cpu6502/sreg_mask ;
  wire [1 : 0] \cpu6502/sreg_operation_sel ;
  wire [2 : 0] \cpu6502/alu_dest_reg_sel ;
  wire [2 : 0] \cpu6502/alu_operation_sel ;
  wire [1 : 0] \cpu6502/alu_cin_sel ;
  wire [1 : 0] \cpu6502/alu_operand2_sel ;
  wire [2 : 0] \cpu6502/alu_operand1_sel ;
  wire [2 : 0] \cpu6502/operation_type ;
  wire [1 : 0] \cpu6502/mem_operation ;
  wire [2 : 0] \cpu6502/addr_mode ;
  wire [7 : 0] \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy ;
  wire [7 : 0] \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut ;
  wire [7 : 0] \cpu6502/addr_gen/addr2_l_reg_in ;
  wire [7 : 0] \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut ;
  wire [6 : 0] \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy ;
  wire [7 : 0] \cpu6502/pc/Madd_n0067_cy ;
  wire [7 : 0] \cpu6502/pc/Madd_n0067_lut ;
  wire [7 : 0] \cpu6502/pc/incremented_pc_value_h ;
  wire [7 : 0] \cpu6502/pc/n0067 ;
  wire [15 : 0] \cpu6502/pc/value_to_load ;
  wire [7 : 0] \cpu6502/alu/Madd_n0137_Madd_cy ;
  wire [6 : 0] \cpu6502/alu/Madd_n0137_Madd_lut ;
  wire [7 : 0] \cpu6502/alu/Mcount_stack_ptr_reg_lut ;
  wire [6 : 0] \cpu6502/alu/Mcount_stack_ptr_reg_cy ;
  wire [7 : 0] \cpu6502/alu/n0137 ;
  wire [7 : 0] \cpu6502/alu/alu_result ;
  wire [7 : 0] \cpu6502/alu/accumulator ;
  wire [7 : 0] \cpu6502/alu/op1 ;
  wire [7 : 0] \cpu6502/alu/op2 ;
  wire [0 : 0] \cpu6502/controller/current_state_address_sel ;
  assign
    mst_mem_address[15] = \cpu6502/mst_mem_address [15],
    mst_mem_address[14] = \cpu6502/mst_mem_address [14],
    mst_mem_address[13] = \cpu6502/mst_mem_address [13],
    mst_mem_address[12] = \cpu6502/mst_mem_address [12],
    mst_mem_address[11] = \cpu6502/mst_mem_address [11],
    mst_mem_address[10] = \cpu6502/mst_mem_address [10],
    mst_mem_address[9] = \cpu6502/mst_mem_address [9],
    mst_mem_address[8] = \cpu6502/mst_mem_address [8],
    mst_mem_address[7] = \cpu6502/mst_mem_address [7],
    mst_mem_address[6] = \cpu6502/mst_mem_address [6],
    mst_mem_address[5] = \cpu6502/mst_mem_address [5],
    mst_mem_address[4] = \cpu6502/mst_mem_address [4],
    mst_mem_address[3] = \cpu6502/mst_mem_address [3],
    mst_mem_address[2] = \cpu6502/mst_mem_address [2],
    mst_mem_address[1] = \cpu6502/mst_mem_address [1],
    mst_mem_address[0] = \cpu6502/mst_mem_address [0],
    mst_mem_dout[7] = \cpu6502/mst_mem_dout [7],
    mst_mem_dout[6] = \cpu6502/mst_mem_dout [6],
    mst_mem_dout[5] = \cpu6502/mst_mem_dout [5],
    mst_mem_dout[4] = \cpu6502/mst_mem_dout [4],
    mst_mem_dout[3] = \cpu6502/mst_mem_dout [3],
    mst_mem_dout[2] = \cpu6502/mst_mem_dout [2],
    mst_mem_dout[1] = \cpu6502/mst_mem_dout [1],
    mst_mem_dout[0] = \cpu6502/mst_mem_dout [0],
    mst_mem_rnw = \NlwRenamedSig_OI_cpu6502/controller/mem_rnw ;
  GND   XST_GND (
    .G(N0)
  );
  VCC   XST_VCC (
    .P(N1)
  );
  FDRE   \cpu6502/mst_mem_address_15  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<15> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [15])
  );
  FDRE   \cpu6502/mst_mem_address_14  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<14> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [14])
  );
  FDRE   \cpu6502/mst_mem_address_13  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<13> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [13])
  );
  FDRE   \cpu6502/mst_mem_address_12  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<12> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [12])
  );
  FDRE   \cpu6502/mst_mem_address_11  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<11> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [11])
  );
  FDRE   \cpu6502/mst_mem_address_10  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<10> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [10])
  );
  FDRE   \cpu6502/mst_mem_address_9  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<9> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [9])
  );
  FDRE   \cpu6502/mst_mem_address_8  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<8> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [8])
  );
  FDRE   \cpu6502/mst_mem_address_7  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<7> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [7])
  );
  FDRE   \cpu6502/mst_mem_address_6  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<6> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [6])
  );
  FDRE   \cpu6502/mst_mem_address_5  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<5> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [5])
  );
  FDRE   \cpu6502/mst_mem_address_4  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<4> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [4])
  );
  FDRE   \cpu6502/mst_mem_address_3  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [3])
  );
  FDRE   \cpu6502/mst_mem_address_2  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<2> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [2])
  );
  FDRE   \cpu6502/mst_mem_address_1  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<1> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [1])
  );
  FDRE   \cpu6502/mst_mem_address_0  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<0> ),
    .R(rst),
    .Q(\cpu6502/mst_mem_address [0])
  );
  FDRE   \cpu6502/mst_mem_dout_7  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [7])
  );
  FDRE   \cpu6502/mst_mem_dout_6  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [6])
  );
  FDRE   \cpu6502/mst_mem_dout_5  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>_54 ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [5])
  );
  FDRE   \cpu6502/mst_mem_dout_4  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [4])
  );
  FDRE   \cpu6502/mst_mem_dout_3  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [3])
  );
  FDRE   \cpu6502/mst_mem_dout_2  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [2])
  );
  FDRE   \cpu6502/mst_mem_dout_1  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [1])
  );
  FDRE   \cpu6502/mst_mem_dout_0  (
    .C(clk),
    .CE(ph2_rising),
    .D(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0> ),
    .R(\cpu6502/Reset_OR_DriverANDClockEnable ),
    .Q(\cpu6502/mst_mem_dout [0])
  );
  FDRE   \cpu6502/mem_din_reg_7  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[7]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [7])
  );
  FDRE   \cpu6502/mem_din_reg_6  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[6]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [6])
  );
  FDRE   \cpu6502/mem_din_reg_5  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[5]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [5])
  );
  FDRE   \cpu6502/mem_din_reg_4  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[4]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [4])
  );
  FDRE   \cpu6502/mem_din_reg_3  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[3]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [3])
  );
  FDRE   \cpu6502/mem_din_reg_2  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[2]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [2])
  );
  FDRE   \cpu6502/mem_din_reg_1  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[1]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [1])
  );
  FDRE   \cpu6502/mem_din_reg_0  (
    .C(clk),
    .CE(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o ),
    .D(mst_mem_din[0]),
    .R(rst),
    .Q(\cpu6502/mem_din_reg [0])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<7>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [6]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [7]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [7])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<7>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [6]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [7]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [7]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [7])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<6>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [5]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [6]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [6])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<6>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [5]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [6]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [6]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [6])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<5>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [4]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [5]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [5])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<5>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [4]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [5]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [5]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [5])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<4>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [3]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [4]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [4])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<4>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [3]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [4]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [4]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [4])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<3>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [2]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [3]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [3])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<3>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [2]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [3]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [3]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [3])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<2>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [1]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [2]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [2])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<2>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [1]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [2]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [2]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [2])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<1>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [0]),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [1]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [1])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<1>  (
    .CI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [0]),
    .DI(\cpu6502/addr_gen/addr2_l_reg [1]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [1]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [1])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_xor<0>  (
    .CI(N0),
    .LI(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [0]),
    .O(\cpu6502/addr_gen/addr2_l_reg_in [0])
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr2_l_reg_in_cy<0>  (
    .CI(N0),
    .DI(\cpu6502/addr_gen/addr2_l_reg [0]),
    .S(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [0]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [0])
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<7>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<6>_240 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<7>_239 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<7> )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<6>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<5>_242 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<6>_241 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<6> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<6>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<5>_242 ),
    .DI(\cpu6502/addr_gen/addr1_reg [6]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<6>_241 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<6>_240 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<5>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<4>_244 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<5>_243 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<5> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<5>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<4>_244 ),
    .DI(\cpu6502/addr_gen/addr1_reg [5]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<5>_243 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<5>_242 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<4>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<3>_246 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<4>_245 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<4> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<4>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<3>_246 ),
    .DI(\cpu6502/addr_gen/addr1_reg [4]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<4>_245 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<4>_244 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<3>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<2>_248 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<3>_247 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<3> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<3>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<2>_248 ),
    .DI(\cpu6502/addr_gen/addr1_reg [3]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<3>_247 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<3>_246 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<2>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<1>_250 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<2>_249 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<2> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<2>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<1>_250 ),
    .DI(\cpu6502/addr_gen/addr1_reg [2]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<2>_249 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<2>_248 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<1>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<0>_252 ),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<1>_251 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<1> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<1>  (
    .CI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<0>_252 ),
    .DI(\cpu6502/addr_gen/addr1_reg [1]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<1>_251 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<1>_250 )
  );
  XORCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_xor<0>  (
    .CI(N0),
    .LI(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<0>_253 ),
    .O(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<0> )
  );
  MUXCY   \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<0>  (
    .CI(N0),
    .DI(\cpu6502/addr_gen/addr1_reg [0]),
    .S(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<0>_253 ),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_cy<0>_252 )
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_7  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<7> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [7])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_6  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<6> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [6])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_5  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<5> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [5])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_4  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<4> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [4])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_3  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [3])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_2  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<2> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [2])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_1  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<1> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [1])
  );
  FDRE   \cpu6502/addr_gen/addr1_reg_0  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0102_inv ),
    .D(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<0> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr1_reg [0])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_7  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<7>_282 ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [7])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_6  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<6>_281 ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [6])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_5  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<5>_280 ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [5])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_4  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<4> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [4])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_3  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [3])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_2  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<2> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [2])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_1  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<1> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [1])
  );
  FDRE   \cpu6502/addr_gen/addr2_h_reg_0  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0094_inv ),
    .D(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<0> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_h_reg [0])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_7  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<7> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [7])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_6  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<6> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [6])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_5  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<5> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [5])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_4  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<4> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [4])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_3  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [3])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_2  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<2> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [2])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_1  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<1> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [1])
  );
  FDRE   \cpu6502/addr_gen/addr2_l_reg_0  (
    .C(clk),
    .CE(\cpu6502/addr_gen/_n0080_inv ),
    .D(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<0> ),
    .R(rst),
    .Q(\cpu6502/addr_gen/addr2_l_reg [0])
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd2  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd2-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd2_377 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd3  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd3-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd3_384 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd1  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd1-In_305 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd1_376 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd5  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd5-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd5_378 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd6  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd6-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd6_379 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd4  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd4-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd4_385 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd8  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd8-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd8_302 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd9  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd9-In_313 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd9_374 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd7  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd7-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd7_301 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd10  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd10-In_314 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd10_373 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd11  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd11-In_315 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd11_148 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd12  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd12-In_316 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd12_356 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd13  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd13-In_317 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd13_381 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd15  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd15-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd15_375 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd16  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd16-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd16_387 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd14  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd14-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd14_380 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd18  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd18-In_322 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd18_343 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd19  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd19-In_323 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd19_303 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd17  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd17-In_321 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd17_386 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd21  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd21-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd21_304 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd22  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd22-In_326 ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd22_357 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd20  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd20-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd20_388 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd23  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd23-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd23_358 )
  );
  FDR   \cpu6502/controller/current_state_FSM_FFd24  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd24-In ),
    .R(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd24_382 )
  );
  FDS   \cpu6502/controller/current_state_FSM_FFd25  (
    .C(clk),
    .D(\cpu6502/controller/current_state_FSM_FFd25-In ),
    .S(rst),
    .Q(\cpu6502/controller/current_state_FSM_FFd25_383 )
  );
  FDRE   \cpu6502/controller/pc_operation_3  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_PWR_4_o_select_83_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/controller/pc_operation [3])
  );
  FDRE   \cpu6502/controller/pc_operation_2  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .R(rst),
    .Q(\cpu6502/controller/pc_operation [2])
  );
  FDRE   \cpu6502/controller/pc_operation_1  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/_n0425 ),
    .R(rst),
    .Q(\cpu6502/controller/pc_operation [1])
  );
  FDRE   \cpu6502/controller/pc_operation_0  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .R(rst),
    .Q(\cpu6502/controller/pc_operation [0])
  );
  FDE   \cpu6502/controller/vector_to_load_2  (
    .C(clk),
    .CE(\cpu6502/controller/ph1_falling_current_state[4]_AND_34_o ),
    .D(\cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT2 ),
    .Q(\cpu6502/controller/vector_to_load [2])
  );
  FDE   \cpu6502/controller/vector_to_load_1  (
    .C(clk),
    .CE(\cpu6502/controller/ph1_falling_current_state[4]_AND_34_o ),
    .D(\cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT1 ),
    .Q(\cpu6502/controller/vector_to_load [1])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_7  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<7> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [7])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_6  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<6> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [6])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_5  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<5> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [5])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_4  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<4> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [4])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_3  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<3> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [3])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_2  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [2])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_1  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<1> ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [1])
  );
  FDRE   \cpu6502/controller/addr_ctrl_signals_0  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .R(rst),
    .Q(\cpu6502/controller/addr_ctrl_signals [0])
  );
  FDSE   \cpu6502/controller/set_next_state  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/ready_mem_rnw_OR_4_o ),
    .S(rst),
    .Q(\cpu6502/controller/set_next_state_127 )
  );
  FDSE   \cpu6502/controller/mem_rnw  (
    .C(clk),
    .CE(ph1_rising),
    .D(\cpu6502/controller/current_state[4]_GND_4_o_Select_62_o_349 ),
    .S(rst),
    .Q(\NlwRenamedSig_OI_cpu6502/controller/mem_rnw )
  );
  FDRE   \cpu6502/controller/alu_enable  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_mem_operation[1]_Select_167_o ),
    .R(rst),
    .Q(\cpu6502/controller/alu_enable_131 )
  );
  FDRE   \cpu6502/controller/mem_din_reg_we  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_reduce_nor_174_o ),
    .R(rst),
    .Q(\cpu6502/controller/mem_din_reg_we_130 )
  );
  FDRE   \cpu6502/controller/stack_ctrl_signals_2  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/current_state[4]_PWR_4_o_select_108_OUT<2> ),
    .R(rst),
    .Q(\cpu6502/controller/stack_ctrl_signals [2])
  );
  FDRE   \cpu6502/controller/stack_ctrl_signals_1  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/_n0437 ),
    .R(rst),
    .Q(\cpu6502/controller/stack_ctrl_signals [1])
  );
  FDRE   \cpu6502/controller/stack_ctrl_signals_0  (
    .C(clk),
    .CE(ph1_falling),
    .D(\cpu6502/controller/_n0433 ),
    .R(rst),
    .Q(\cpu6502/controller/stack_ctrl_signals [0])
  );
  FDRE   \cpu6502/controller/int_active  (
    .C(clk),
    .CE(ph2_falling),
    .D(\cpu6502/controller/int_n_INV_5_o ),
    .R(rst),
    .Q(\cpu6502/controller/int_active_371 )
  );
  FDRE   \cpu6502/controller/nmi_sample  (
    .C(clk),
    .CE(ph2_falling),
    .D(nmi_n),
    .R(rst),
    .Q(\cpu6502/controller/nmi_sample_372 )
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<7>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [6]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [7]),
    .O(\cpu6502/pc/incremented_pc_value_h [7])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<6>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [5]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [6]),
    .O(\cpu6502/pc/incremented_pc_value_h [6])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<6>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [5]),
    .DI(\cpu6502/pc/pc_14_125 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [6]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [6])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<5>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [4]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [5]),
    .O(\cpu6502/pc/incremented_pc_value_h [5])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<5>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [4]),
    .DI(\cpu6502/pc/pc_13_124 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [5]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [5])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<4>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [3]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [4]),
    .O(\cpu6502/pc/incremented_pc_value_h [4])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<4>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [3]),
    .DI(\cpu6502/pc/pc_12_123 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [4]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [4])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<3>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [2]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [3]),
    .O(\cpu6502/pc/incremented_pc_value_h [3])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<3>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [2]),
    .DI(\cpu6502/pc/pc_11_122 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [3]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [3])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<2>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [1]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [2]),
    .O(\cpu6502/pc/incremented_pc_value_h [2])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<2>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [1]),
    .DI(\cpu6502/pc/pc_10_121 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [2]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [2])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<1>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [0]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [1]),
    .O(\cpu6502/pc/incremented_pc_value_h [1])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<1>  (
    .CI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [0]),
    .DI(\cpu6502/pc/pc_9_120 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [1]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [1])
  );
  XORCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_xor<0>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [7]),
    .LI(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [0]),
    .O(\cpu6502/pc/incremented_pc_value_h [0])
  );
  MUXCY   \cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy<0>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [7]),
    .DI(\cpu6502/pc/pc_8_119 ),
    .S(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [0]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_cy [0])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<7>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [6]),
    .LI(\cpu6502/pc/Madd_n0067_lut [7]),
    .O(\cpu6502/pc/n0067 [7])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<7>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [6]),
    .DI(\cpu6502/pc/pc [7]),
    .S(\cpu6502/pc/Madd_n0067_lut [7]),
    .O(\cpu6502/pc/Madd_n0067_cy [7])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<6>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [5]),
    .LI(\cpu6502/pc/Madd_n0067_lut [6]),
    .O(\cpu6502/pc/n0067 [6])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<6>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [5]),
    .DI(\cpu6502/pc/pc [6]),
    .S(\cpu6502/pc/Madd_n0067_lut [6]),
    .O(\cpu6502/pc/Madd_n0067_cy [6])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<5>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [4]),
    .LI(\cpu6502/pc/Madd_n0067_lut [5]),
    .O(\cpu6502/pc/n0067 [5])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<5>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [4]),
    .DI(\cpu6502/pc/pc [5]),
    .S(\cpu6502/pc/Madd_n0067_lut [5]),
    .O(\cpu6502/pc/Madd_n0067_cy [5])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<4>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [3]),
    .LI(\cpu6502/pc/Madd_n0067_lut [4]),
    .O(\cpu6502/pc/n0067 [4])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<4>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [3]),
    .DI(\cpu6502/pc/pc [4]),
    .S(\cpu6502/pc/Madd_n0067_lut [4]),
    .O(\cpu6502/pc/Madd_n0067_cy [4])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<3>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [2]),
    .LI(\cpu6502/pc/Madd_n0067_lut [3]),
    .O(\cpu6502/pc/n0067 [3])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<3>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [2]),
    .DI(\cpu6502/pc/pc [3]),
    .S(\cpu6502/pc/Madd_n0067_lut [3]),
    .O(\cpu6502/pc/Madd_n0067_cy [3])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<2>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [1]),
    .LI(\cpu6502/pc/Madd_n0067_lut [2]),
    .O(\cpu6502/pc/n0067 [2])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<2>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [1]),
    .DI(\cpu6502/pc/pc [2]),
    .S(\cpu6502/pc/Madd_n0067_lut [2]),
    .O(\cpu6502/pc/Madd_n0067_cy [2])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<1>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [0]),
    .LI(\cpu6502/pc/Madd_n0067_lut [1]),
    .O(\cpu6502/pc/n0067 [1])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<1>  (
    .CI(\cpu6502/pc/Madd_n0067_cy [0]),
    .DI(\cpu6502/pc/pc [1]),
    .S(\cpu6502/pc/Madd_n0067_lut [1]),
    .O(\cpu6502/pc/Madd_n0067_cy [1])
  );
  XORCY   \cpu6502/pc/Madd_n0067_xor<0>  (
    .CI(N0),
    .LI(\cpu6502/pc/Madd_n0067_lut [0]),
    .O(\cpu6502/pc/n0067 [0])
  );
  MUXCY   \cpu6502/pc/Madd_n0067_cy<0>  (
    .CI(N0),
    .DI(\cpu6502/pc/pc [0]),
    .S(\cpu6502/pc/Madd_n0067_lut [0]),
    .O(\cpu6502/pc/Madd_n0067_cy [0])
  );
  FDRE   \cpu6502/pc/pc_15  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [15]),
    .R(rst),
    .Q(\cpu6502/pc/pc_15_126 )
  );
  FDRE   \cpu6502/pc/pc_14  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [14]),
    .R(rst),
    .Q(\cpu6502/pc/pc_14_125 )
  );
  FDRE   \cpu6502/pc/pc_13  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [13]),
    .R(rst),
    .Q(\cpu6502/pc/pc_13_124 )
  );
  FDRE   \cpu6502/pc/pc_12  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [12]),
    .R(rst),
    .Q(\cpu6502/pc/pc_12_123 )
  );
  FDRE   \cpu6502/pc/pc_11  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [11]),
    .R(rst),
    .Q(\cpu6502/pc/pc_11_122 )
  );
  FDRE   \cpu6502/pc/pc_10  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [10]),
    .R(rst),
    .Q(\cpu6502/pc/pc_10_121 )
  );
  FDRE   \cpu6502/pc/pc_9  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [9]),
    .R(rst),
    .Q(\cpu6502/pc/pc_9_120 )
  );
  FDRE   \cpu6502/pc/pc_8  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o ),
    .D(\cpu6502/pc/value_to_load [8]),
    .R(rst),
    .Q(\cpu6502/pc/pc_8_119 )
  );
  FDRE   \cpu6502/pc/pc_0  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [0]),
    .R(rst),
    .Q(\cpu6502/pc/pc [0])
  );
  FDRE   \cpu6502/pc/pc_2  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [2]),
    .R(rst),
    .Q(\cpu6502/pc/pc [2])
  );
  FDRE   \cpu6502/pc/pc_3  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [3]),
    .R(rst),
    .Q(\cpu6502/pc/pc [3])
  );
  FDRE   \cpu6502/pc/pc_1  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [1]),
    .R(rst),
    .Q(\cpu6502/pc/pc [1])
  );
  FDRE   \cpu6502/pc/pc_4  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [4]),
    .R(rst),
    .Q(\cpu6502/pc/pc [4])
  );
  FDRE   \cpu6502/pc/pc_5  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [5]),
    .R(rst),
    .Q(\cpu6502/pc/pc [5])
  );
  FDRE   \cpu6502/pc/pc_6  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [6]),
    .R(rst),
    .Q(\cpu6502/pc/pc [6])
  );
  FDRE   \cpu6502/pc/pc_7  (
    .C(clk),
    .CE(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o ),
    .D(\cpu6502/pc/value_to_load [7]),
    .R(rst),
    .Q(\cpu6502/pc/pc [7])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<7>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [6]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut<7>1_622 ),
    .O(\cpu6502/alu/n0137 [7])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<7>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [6]),
    .DI(\cpu6502/alu/op1 [7]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut<7>1_622 ),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [7])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<6>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [5]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [6]),
    .O(\cpu6502/alu/n0137 [6])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<6>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [5]),
    .DI(\cpu6502/alu/op1 [6]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [6]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [6])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<5>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [4]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [5]),
    .O(\cpu6502/alu/n0137 [5])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<5>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [4]),
    .DI(\cpu6502/alu/op1 [5]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [5]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [5])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<4>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [3]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [4]),
    .O(\cpu6502/alu/n0137 [4])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<4>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [3]),
    .DI(\cpu6502/alu/op1 [4]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [4]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [4])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<3>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [2]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [3]),
    .O(\cpu6502/alu/n0137 [3])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<3>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [2]),
    .DI(\cpu6502/alu/op1 [3]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [3]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [3])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<2>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [1]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [2]),
    .O(\cpu6502/alu/n0137 [2])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<2>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [1]),
    .DI(\cpu6502/alu/op1 [2]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [2]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [2])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<1>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [0]),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [1]),
    .O(\cpu6502/alu/n0137 [1])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<1>  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [0]),
    .DI(\cpu6502/alu/op1 [1]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [1]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [1])
  );
  XORCY   \cpu6502/alu/Madd_n0137_Madd_xor<0>  (
    .CI(\cpu6502/alu/c_in ),
    .LI(\cpu6502/alu/Madd_n0137_Madd_lut [0]),
    .O(\cpu6502/alu/n0137 [0])
  );
  MUXCY   \cpu6502/alu/Madd_n0137_Madd_cy<0>  (
    .CI(\cpu6502/alu/c_in ),
    .DI(\cpu6502/alu/op1 [0]),
    .S(\cpu6502/alu/Madd_n0137_Madd_lut [0]),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy [0])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_7  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg8 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [7])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_6  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg7 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [6])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_5  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg6 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [5])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_4  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg5 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [4])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_3  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg4 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [3])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_2  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg3 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [2])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_1  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg2 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [1])
  );
  FDRE   \cpu6502/alu/stack_ptr_reg_0  (
    .C(clk),
    .CE(\cpu6502/alu/_n0199_inv_504 ),
    .D(\cpu6502/alu/Mcount_stack_ptr_reg1_500 ),
    .R(rst),
    .Q(\cpu6502/alu/stack_ptr_reg [0])
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<7>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [6]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [7]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg8 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<6>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [5]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [6]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg7 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<6>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [5]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand6 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [6]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [6])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<6>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [6]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [6]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [6])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_5  (
    .I0(\cpu6502/alu/stack_ptr_reg [6]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand6 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<5>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [4]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [5]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg6 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<5>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [4]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand5 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [5]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [5])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<5>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [5]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [5]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [5])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_4  (
    .I0(\cpu6502/alu/stack_ptr_reg [5]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand5 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<4>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [3]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [4]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg5 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<4>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [3]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand4 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [4]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [4])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<4>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [4]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [4]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [4])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_3  (
    .I0(\cpu6502/alu/stack_ptr_reg [4]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand4 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<3>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [2]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [3]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg4 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<3>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [2]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand3 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [3]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [3])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<3>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [3]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [3]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [3])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_2  (
    .I0(\cpu6502/alu/stack_ptr_reg [3]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand3 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<2>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [1]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [2]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg3 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<2>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [1]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand2 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [2]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [2])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<2>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [2]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [2]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [2])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_1  (
    .I0(\cpu6502/alu/stack_ptr_reg [2]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand2 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<1>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [0]),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [1]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg2 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<1>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg_cy [0]),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand1 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [1]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [1])
  );
  LUT4 #(
    .INIT ( 16'hD782 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<1>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [1]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [1]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [1])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand_0  (
    .I0(\cpu6502/alu/stack_ptr_reg [1]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand1 )
  );
  XORCY   \cpu6502/alu/Mcount_stack_ptr_reg_xor<0>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg ),
    .LI(\cpu6502/alu/Mcount_stack_ptr_reg_lut [0]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg1_500 )
  );
  MUXCY   \cpu6502/alu/Mcount_stack_ptr_reg_cy<0>  (
    .CI(\cpu6502/alu/Mcount_stack_ptr_reg ),
    .DI(\cpu6502/alu/Mcount_stack_ptr_reg_mand_501 ),
    .S(\cpu6502/alu/Mcount_stack_ptr_reg_lut [0]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_cy [0])
  );
  LUT4 #(
    .INIT ( 16'h7D28 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<0>  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I1(\cpu6502/alu/stack_ptr_reg [0]),
    .I2(\cpu6502/controller/stack_ctrl_signals [0]),
    .I3(\cpu6502/alu/alu_result [0]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [0])
  );
  MULT_AND   \cpu6502/alu/Mcount_stack_ptr_reg_mand  (
    .I0(\cpu6502/alu/stack_ptr_reg [0]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .LO(\cpu6502/alu/Mcount_stack_ptr_reg_mand_501 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \cpu6502/alu/n_flag  (
    .C(clk),
    .CE(\cpu6502/alu/_n0237_inv ),
    .D(\cpu6502/alu/n_flag_mem_in[7]_MUX_185_o ),
    .R(rst),
    .Q(\cpu6502/alu/n_flag_86 )
  );
  FDRE   \cpu6502/alu/result_reg_7  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [7]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [7])
  );
  FDRE   \cpu6502/alu/result_reg_6  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [6]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [6])
  );
  FDRE   \cpu6502/alu/result_reg_5  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [5]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [5])
  );
  FDRE   \cpu6502/alu/result_reg_4  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [4]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [4])
  );
  FDRE   \cpu6502/alu/result_reg_3  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [3]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [3])
  );
  FDRE   \cpu6502/alu/result_reg_2  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [2]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [2])
  );
  FDRE   \cpu6502/alu/result_reg_1  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [1]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [1])
  );
  FDRE   \cpu6502/alu/result_reg_0  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/alu_result [0]),
    .R(rst),
    .Q(\cpu6502/alu/result_reg [0])
  );
  FDRE   \cpu6502/alu/y_reg_7  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [7]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [7])
  );
  FDRE   \cpu6502/alu/y_reg_6  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [6]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [6])
  );
  FDRE   \cpu6502/alu/y_reg_5  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [5]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [5])
  );
  FDRE   \cpu6502/alu/y_reg_4  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [4]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [4])
  );
  FDRE   \cpu6502/alu/y_reg_3  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [3]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [3])
  );
  FDRE   \cpu6502/alu/y_reg_2  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [2]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [2])
  );
  FDRE   \cpu6502/alu/y_reg_1  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [1]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [1])
  );
  FDRE   \cpu6502/alu/y_reg_0  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o ),
    .D(\cpu6502/alu/alu_result [0]),
    .R(rst),
    .Q(\cpu6502/alu/y_reg [0])
  );
  FDRE   \cpu6502/alu/x_reg_7  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [7]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [7])
  );
  FDRE   \cpu6502/alu/x_reg_6  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [6]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [6])
  );
  FDRE   \cpu6502/alu/x_reg_5  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [5]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [5])
  );
  FDRE   \cpu6502/alu/x_reg_4  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [4]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [4])
  );
  FDRE   \cpu6502/alu/x_reg_3  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [3]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [3])
  );
  FDRE   \cpu6502/alu/x_reg_2  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [2]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [2])
  );
  FDRE   \cpu6502/alu/x_reg_1  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [1]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [1])
  );
  FDRE   \cpu6502/alu/x_reg_0  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o ),
    .D(\cpu6502/alu/alu_result [0]),
    .R(rst),
    .Q(\cpu6502/alu/x_reg [0])
  );
  FDRE   \cpu6502/alu/accumulator_7  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [7]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [7])
  );
  FDRE   \cpu6502/alu/accumulator_6  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [6]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [6])
  );
  FDRE   \cpu6502/alu/accumulator_5  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [5]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [5])
  );
  FDRE   \cpu6502/alu/accumulator_4  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [4]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [4])
  );
  FDRE   \cpu6502/alu/accumulator_3  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [3]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [3])
  );
  FDRE   \cpu6502/alu/accumulator_2  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [2]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [2])
  );
  FDRE   \cpu6502/alu/accumulator_1  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [1]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [1])
  );
  FDRE   \cpu6502/alu/accumulator_0  (
    .C(clk),
    .CE(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o ),
    .D(\cpu6502/alu/alu_result [0]),
    .R(rst),
    .Q(\cpu6502/alu/accumulator [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \cpu6502/alu/d_flag  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/status_op[1]_mem_in[3]_MUX_176_o ),
    .R(rst),
    .Q(\cpu6502/alu/d_flag_84 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \cpu6502/alu/z_flag  (
    .C(clk),
    .CE(\cpu6502/alu/_n0227_inv ),
    .D(\cpu6502/alu/z_flag_mem_in[1]_MUX_166_o ),
    .R(rst),
    .Q(\cpu6502/alu/z_flag_82 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \cpu6502/alu/v_flag  (
    .C(clk),
    .CE(\cpu6502/alu_en ),
    .D(\cpu6502/alu/status_op[1]_mem_in[6]_MUX_181_o ),
    .R(rst),
    .Q(\cpu6502/alu/v_flag_85 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \cpu6502/alu_en11  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/alu_enable_131 ),
    .O(\cpu6502/alu_en )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \cpu6502/decoder/_n003511  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/inst_reg_clr_144 ),
    .O(\cpu6502/decoder/_n0035 )
  );
  LUT4 #(
    .INIT ( 16'h57FF ))
  \cpu6502/decoder/_n0040_01  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(\cpu6502/controller/inst_reg_we_143 ),
    .I2(\cpu6502/controller/inst_reg_clr_144 ),
    .I3(ph2_falling),
    .O(\cpu6502/decoder/_n0040_0 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \cpu6502/ph2_falling_mem_din_reg_we_AND_63_o11  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/mem_din_reg_we_130 ),
    .O(\cpu6502/ph2_falling_mem_din_reg_we_AND_63_o )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT91  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [2]),
    .I1(\cpu6502/addr_gen/addr1_reg [2]),
    .I2(\cpu6502/pc/pc [2]),
    .I3(\cpu6502/alu/stack_ptr_reg [2]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<2> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT81  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [1]),
    .I1(\cpu6502/addr_gen/addr1_reg [1]),
    .I2(\cpu6502/pc/pc [1]),
    .I3(\cpu6502/alu/stack_ptr_reg [1]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<1> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT141  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [7]),
    .I1(\cpu6502/addr_gen/addr1_reg [7]),
    .I2(\cpu6502/pc/pc [7]),
    .I3(\cpu6502/alu/stack_ptr_reg [7]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<7> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT131  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [6]),
    .I1(\cpu6502/addr_gen/addr1_reg [6]),
    .I2(\cpu6502/pc/pc [6]),
    .I3(\cpu6502/alu/stack_ptr_reg [6]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<6> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT121  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [5]),
    .I1(\cpu6502/addr_gen/addr1_reg [5]),
    .I2(\cpu6502/pc/pc [5]),
    .I3(\cpu6502/alu/stack_ptr_reg [5]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<5> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT111  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [4]),
    .I1(\cpu6502/addr_gen/addr1_reg [4]),
    .I2(\cpu6502/pc/pc [4]),
    .I3(\cpu6502/alu/stack_ptr_reg [4]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<4> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT101  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [3]),
    .I1(\cpu6502/addr_gen/addr1_reg [3]),
    .I2(\cpu6502/pc/pc [3]),
    .I3(\cpu6502/alu/stack_ptr_reg [3]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<3> )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFF00AAAAF0F0 ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT11  (
    .I0(\cpu6502/addr_gen/addr2_l_reg [0]),
    .I1(\cpu6502/addr_gen/addr1_reg [0]),
    .I2(\cpu6502/pc/pc [0]),
    .I3(\cpu6502/alu/stack_ptr_reg [0]),
    .I4(\cpu6502/address_sel [1]),
    .I5(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<0> )
  );
  LUT4 #(
    .INIT ( 16'h0FCA ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT151  (
    .I0(\cpu6502/pc/pc_8_119 ),
    .I1(\cpu6502/addr_gen/addr2_h_reg [0]),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<8> )
  );
  LUT4 #(
    .INIT ( 16'h00AC ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT21  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [2]),
    .I1(\cpu6502/pc/pc_10_121 ),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<10> )
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT31  (
    .I0(\cpu6502/pc/pc_11_122 ),
    .I1(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<11> )
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT41  (
    .I0(\cpu6502/pc/pc_12_123 ),
    .I1(\cpu6502/addr_gen/addr2_h_reg [4]),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<12> )
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT51  (
    .I0(\cpu6502/pc/pc_13_124 ),
    .I1(\cpu6502/addr_gen/addr2_h_reg [5]),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<13> )
  );
  LUT4 #(
    .INIT ( 16'h00AC ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT61  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [6]),
    .I1(\cpu6502/pc/pc_14_125 ),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<14> )
  );
  LUT4 #(
    .INIT ( 16'h00AC ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT71  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [7]),
    .I1(\cpu6502/pc/pc_15_126 ),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<15> )
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  \cpu6502/Mmux_address_sel[1]_addr_zp[15]_wide_mux_6_OUT161  (
    .I0(\cpu6502/pc/pc_9_120 ),
    .I1(\cpu6502/addr_gen/addr2_h_reg [1]),
    .I2(\cpu6502/address_sel [1]),
    .I3(\cpu6502/address_sel [0]),
    .O(\cpu6502/address_sel[1]_addr_zp[15]_wide_mux_6_OUT<9> )
  );
  LUT4 #(
    .INIT ( 16'hFFAE ))
  \cpu6502/Reset_OR_DriverANDClockEnable1  (
    .I0(rst),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(ph2_falling),
    .O(\cpu6502/Reset_OR_DriverANDClockEnable )
  );
  LUT5 #(
    .INIT ( 32'h51404051 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>2  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(mst_mem_din[3]),
    .I3(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I4(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3> )
  );
  LUT3 #(
    .INIT ( 8'h7F ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>11  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [0]),
    .I1(\cpu6502/addr_gen/addr2_h_reg [1]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [2]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 )
  );
  LUT6 #(
    .INIT ( 64'h5140514040515140 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<4>1  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(mst_mem_din[4]),
    .I3(\cpu6502/addr_gen/addr2_h_reg [4]),
    .I4(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I5(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<4> )
  );
  LUT6 #(
    .INIT ( 64'h4554545401101010 ))
  \cpu6502/addr_gen/Mmux_addr2_h_reg[7]_GND_7_o_mux_23_OUT31  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [2]),
    .I3(\cpu6502/addr_gen/addr2_h_reg [0]),
    .I4(\cpu6502/addr_gen/addr2_h_reg [1]),
    .I5(mst_mem_din[2]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<2> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT11  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [0]),
    .I3(mst_mem_din[0]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<0> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT21  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [1]),
    .I3(mst_mem_din[1]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<1> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT31  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [2]),
    .I3(mst_mem_din[2]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<2> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT41  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [3]),
    .I3(mst_mem_din[3]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<3> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT51  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [4]),
    .I3(mst_mem_din[4]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<4> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT61  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [5]),
    .I3(mst_mem_din[5]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<5> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT71  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [6]),
    .I3(mst_mem_din[6]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<6> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr2_l_reg[7]_GND_7_o_mux_14_OUT81  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [4]),
    .I2(\cpu6502/addr_gen/addr2_l_reg_in [7]),
    .I3(mst_mem_din[7]),
    .O(\cpu6502/addr_gen/addr2_l_reg[7]_GND_7_o_mux_14_OUT<7> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT11  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<0> ),
    .I3(mst_mem_din[0]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<0> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT21  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<1> ),
    .I3(mst_mem_din[1]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<1> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT31  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<2> ),
    .I3(mst_mem_din[2]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<2> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT41  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<3> ),
    .I3(mst_mem_din[3]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<3> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT51  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<4> ),
    .I3(mst_mem_din[4]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<4> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT61  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<5> ),
    .I3(mst_mem_din[5]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<5> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT71  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<6> ),
    .I3(mst_mem_din[6]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<6> )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/addr_gen/Mmux_addr1_reg[7]_GND_7_o_mux_5_OUT81  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [1]),
    .I2(\cpu6502/addr_gen/addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT<7> ),
    .I3(mst_mem_din[7]),
    .O(\cpu6502/addr_gen/addr1_reg[7]_GND_7_o_mux_5_OUT<7> )
  );
  LUT4 #(
    .INIT ( 16'h4501 ))
  \cpu6502/addr_gen/Mmux_addr2_h_reg[7]_GND_7_o_mux_23_OUT11  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [0]),
    .I3(mst_mem_din[0]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<0> )
  );
  LUT5 #(
    .INIT ( 32'h45540110 ))
  \cpu6502/addr_gen/Mmux_addr2_h_reg[7]_GND_7_o_mux_23_OUT21  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [0]),
    .I3(\cpu6502/addr_gen/addr2_h_reg [1]),
    .I4(mst_mem_din[1]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<1> )
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  \cpu6502/addr_gen/Mmux_address_carry_GND_7_o_MUX_198_o11  (
    .I0(\cpu6502/addr_gen/Madd_addr2_l_reg_in_cy [7]),
    .I1(\cpu6502/controller/addr_ctrl_signals [0]),
    .I2(\cpu6502/controller/addr_ctrl_signals [7]),
    .O(\cpu6502/addr_gen/address_carry_GND_7_o_MUX_198_o )
  );
  LUT6 #(
    .INIT ( 64'h3FBFBFBF00808080 ))
  \cpu6502/controller/current_state_FSM_FFd8-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/operation_type [1]),
    .I4(\cpu6502/operation_type [2]),
    .I5(\cpu6502/controller/current_state_FSM_FFd8_302 ),
    .O(\cpu6502/controller/current_state_FSM_FFd8-In )
  );
  LUT6 #(
    .INIT ( 64'h2AEA2A2A2A2A2A2A ))
  \cpu6502/controller/current_state_FSM_FFd14-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd14_380 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/addr_mode[2]_GND_4_o_equal_25_o ),
    .I4(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .I5(\cpu6502/operation_type [2]),
    .O(\cpu6502/controller/current_state_FSM_FFd14-In )
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \cpu6502/controller/current_state__n04371  (
    .I0(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .O(\cpu6502/controller/_n0437 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF0200 ))
  \cpu6502/controller/current_state_current_state[4]_operation_type[2]_Select_182_o1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I1(\cpu6502/operation_type [2]),
    .I2(\cpu6502/operation_type [1]),
    .I3(\cpu6502/operation_type [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .O(\cpu6502/controller/current_state[4]_operation_type[2]_Select_182_o )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  \cpu6502/controller/current_state_address_sel<1>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd12_356 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd20_388 ),
    .I4(\cpu6502/controller/current_state_address_sel<0>2_299 ),
    .O(\cpu6502/address_sel [1])
  );
  LUT5 #(
    .INIT ( 32'h2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd24-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I4(\cpu6502/controller/is_interrupt ),
    .O(\cpu6502/controller/current_state_FSM_FFd24-In )
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \cpu6502/controller/current_state[4]_reduce_nor_174_o1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd23_358 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .O(\cpu6502/controller/current_state[4]_reduce_nor_174_o )
  );
  LUT6 #(
    .INIT ( 64'hFEFEFEEEEEEEEEEE ))
  \cpu6502/controller/current_state_address_sel<0>21  (
    .I0(\cpu6502/controller/current_state_FSM_FFd19_303 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I3(\cpu6502/addr_mode [1]),
    .I4(\cpu6502/addr_mode [0]),
    .I5(\cpu6502/addr_mode [2]),
    .O(\cpu6502/controller/current_state_address_sel<0>2_299 )
  );
  LUT6 #(
    .INIT ( 64'hABAAAAAAAAAAAAAA ))
  \cpu6502/controller/current_state_FSM_FFd20-In1111  (
    .I0(\cpu6502/controller/current_state_FSM_FFd12_356 ),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/operation_type [2]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/addr_mode [1]),
    .I5(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .O(\cpu6502/controller/current_state_FSM_FFd20-In111 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFF77788888000 ))
  \cpu6502/controller/current_state_FSM_FFd5-In1  (
    .I0(ph2_rising),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I3(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o ),
    .I4(\cpu6502/controller/current_state_FSM_FFd6_379 ),
    .I5(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .O(\cpu6502/controller/current_state_FSM_FFd5-In )
  );
  LUT6 #(
    .INIT ( 64'hFF2AFF2AFF2A2A2A ))
  \cpu6502/controller/current_state_FSM_FFd15-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd16-In1 ),
    .I4(\cpu6502/operation_type [0]),
    .I5(\cpu6502/operation_type [2]),
    .O(\cpu6502/controller/current_state_FSM_FFd15-In )
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  \cpu6502/controller/current_state_FSM_FFd2-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd10_373 ),
    .O(\cpu6502/controller/current_state_FSM_FFd2-In )
  );
  LUT5 #(
    .INIT ( 32'h2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd3-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I4(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o ),
    .O(\cpu6502/controller/current_state_FSM_FFd3-In )
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  \cpu6502/controller/current_state_FSM_FFd4-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .O(\cpu6502/controller/current_state_FSM_FFd4-In )
  );
  LUT6 #(
    .INIT ( 64'h2A2A2A2A2A2AFF2A ))
  \cpu6502/controller/current_state_FSM_FFd16-In2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd16-In1 ),
    .I4(\cpu6502/operation_type [0]),
    .I5(\cpu6502/operation_type [2]),
    .O(\cpu6502/controller/current_state_FSM_FFd16-In )
  );
  LUT5 #(
    .INIT ( 32'h80880080 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<6>1  (
    .I0(\cpu6502/controller/_n0556 ),
    .I1(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 ),
    .I2(\cpu6502/addr_mode [2]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/addr_mode [1]),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<6> )
  );
  LUT3 #(
    .INIT ( 8'hA8 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<7>1  (
    .I0(\cpu6502/addr_gen/address_carry_165 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd12_356 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<7> )
  );
  LUT5 #(
    .INIT ( 32'h80000080 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<5>1  (
    .I0(\cpu6502/controller/_n0556 ),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 ),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/addr_mode [1]),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<5> )
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  \cpu6502/controller/current_state_FSM_FFd25-In221  (
    .I0(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/operation_type [0]),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In22 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \cpu6502/controller/current_state_FSM_FFd16-In11  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I3(\cpu6502/operation_type [1]),
    .O(\cpu6502/controller/current_state_FSM_FFd16-In1 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \cpu6502/controller/current_state__n04251  (
    .I0(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd14_380 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .O(\cpu6502/controller/_n0425 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \cpu6502/controller/current_state__n04331  (
    .I0(\cpu6502/controller/current_state_FSM_FFd10_373 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd9_374 ),
    .O(\cpu6502/controller/_n0433 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \cpu6502/controller/current_state__n05561  (
    .I0(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .O(\cpu6502/controller/_n0556 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \cpu6502/controller/current_state_data_out_sel<1>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .O(\cpu6502/data_out_sel [1])
  );
  LUT4 #(
    .INIT ( 16'hFEEE ))
  \cpu6502/controller/current_state_data_out_sel<0>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I3(\cpu6502/sreg_to_dout ),
    .O(\cpu6502/data_out_sel [0])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \cpu6502/controller/current_state_ph1_falling_current_state[4]_AND_34_o1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I1(ph1_falling),
    .O(\cpu6502/controller/ph1_falling_current_state[4]_AND_34_o )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \cpu6502/controller/current_state_ph2_rising_nmi_recognized_AND_11_o1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I1(\cpu6502/controller/nmi_recognized_369 ),
    .I2(ph2_rising),
    .O(\cpu6502/controller/ph2_rising_nmi_recognized_AND_11_o )
  );
  LUT5 #(
    .INIT ( 32'hFFFF0800 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<3>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [1]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd19_303 ),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<3> )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT21  (
    .I0(\cpu6502/controller/nmi_active_370 ),
    .I1(\cpu6502/controller/rst_active_389 ),
    .O(\cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT2 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \cpu6502/controller/Reset_OR_DriverANDClockEnable11  (
    .I0(rst),
    .I1(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I2(ph1_falling),
    .O(\cpu6502/controller/Reset_OR_DriverANDClockEnable1_336 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \cpu6502/controller/Reset_OR_DriverANDClockEnable1  (
    .I0(rst),
    .I1(\cpu6502/controller/current_state_FSM_FFd6_379 ),
    .I2(ph1_falling),
    .O(\cpu6502/controller/Reset_OR_DriverANDClockEnable )
  );
  LUT4 #(
    .INIT ( 16'hFFAE ))
  \cpu6502/controller/is_interrupt1  (
    .I0(\cpu6502/controller/nmi_active_370 ),
    .I1(\cpu6502/controller/int_active_371 ),
    .I2(\cpu6502/alu/i_flag_83 ),
    .I3(\cpu6502/controller/rst_active_389 ),
    .O(\cpu6502/controller/is_interrupt )
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o<2>1  (
    .I0(\cpu6502/operation_type [0]),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/operation_type [2]),
    .O(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o )
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  \cpu6502/controller/operation_type[2]_PWR_4_o_equal_90_o<2>1  (
    .I0(\cpu6502/operation_type [2]),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/operation_type [0]),
    .O(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_90_o )
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  \cpu6502/controller/addr_mode[2]_GND_4_o_equal_25_o<2>1  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [1]),
    .O(\cpu6502/controller/addr_mode[2]_GND_4_o_equal_25_o )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \cpu6502/controller/ready_mem_rnw_OR_4_o1  (
    .I0(\NlwRenamedSig_OI_cpu6502/controller/mem_rnw ),
    .I1(ready),
    .O(\cpu6502/controller/ready_mem_rnw_OR_4_o )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \cpu6502/controller/ph1_falling_set_next_state_AND_61_o1  (
    .I0(ph1_falling),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .O(\cpu6502/controller/ph1_falling_set_next_state_AND_61_o )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \cpu6502/controller/rst_set_i_flag_OR_110_o1  (
    .I0(rst),
    .I1(\cpu6502/controller/set_i_flag_129 ),
    .O(\cpu6502/controller/rst_set_i_flag_OR_110_o )
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  \cpu6502/pc/value_to_load<0>1  (
    .I0(\cpu6502/controller/pc_operation [2]),
    .I1(\cpu6502/controller/pc_operation [1]),
    .I2(\cpu6502/pc/n0067 [0]),
    .I3(\cpu6502/mem_din_reg [0]),
    .O(\cpu6502/pc/value_to_load [0])
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  \cpu6502/pc/value_to_load<1>1  (
    .I0(\cpu6502/controller/pc_operation [2]),
    .I1(\cpu6502/mem_din_reg [1]),
    .I2(\cpu6502/controller/pc_operation [1]),
    .I3(\cpu6502/pc/n0067 [1]),
    .I4(\cpu6502/controller/vector_to_load [1]),
    .O(\cpu6502/pc/value_to_load [1])
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  \cpu6502/pc/value_to_load<2>1  (
    .I0(\cpu6502/controller/pc_operation [2]),
    .I1(\cpu6502/mem_din_reg [2]),
    .I2(\cpu6502/controller/pc_operation [1]),
    .I3(\cpu6502/pc/n0067 [2]),
    .I4(\cpu6502/controller/vector_to_load [2]),
    .O(\cpu6502/pc/value_to_load [2])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<3>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/n0067 [3]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(\cpu6502/mem_din_reg [3]),
    .O(\cpu6502/pc/value_to_load [3])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<4>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/n0067 [4]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(\cpu6502/mem_din_reg [4]),
    .O(\cpu6502/pc/value_to_load [4])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<5>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/n0067 [5]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(\cpu6502/mem_din_reg [5]),
    .O(\cpu6502/pc/value_to_load [5])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<6>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/n0067 [6]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(\cpu6502/mem_din_reg [6]),
    .O(\cpu6502/pc/value_to_load [6])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<7>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/n0067 [7]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/value_to_load [7])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<8>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [0]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[0]),
    .O(\cpu6502/pc/value_to_load [8])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<9>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [1]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[1]),
    .O(\cpu6502/pc/value_to_load [9])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<10>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [2]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[2]),
    .O(\cpu6502/pc/value_to_load [10])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<11>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [3]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[3]),
    .O(\cpu6502/pc/value_to_load [11])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<12>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [4]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[4]),
    .O(\cpu6502/pc/value_to_load [12])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<13>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [5]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[5]),
    .O(\cpu6502/pc/value_to_load [13])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<14>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [6]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[6]),
    .O(\cpu6502/pc/value_to_load [14])
  );
  LUT4 #(
    .INIT ( 16'hFEF4 ))
  \cpu6502/pc/value_to_load<15>1  (
    .I0(\cpu6502/controller/pc_operation [1]),
    .I1(\cpu6502/pc/incremented_pc_value_h [7]),
    .I2(\cpu6502/controller/pc_operation [2]),
    .I3(mst_mem_din[7]),
    .O(\cpu6502/pc/value_to_load [15])
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv1  (
    .I0(\cpu6502/alu_dest_reg_sel [0]),
    .I1(\cpu6502/alu_dest_reg_sel [2]),
    .I2(\cpu6502/alu_dest_reg_sel [1]),
    .O(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv )
  );
  LUT4 #(
    .INIT ( 16'h5545 ))
  \cpu6502/alu/Mcount_stack_ptr_reg1  (
    .I0(\cpu6502/controller/stack_ctrl_signals [0]),
    .I1(\cpu6502/alu_dest_reg_sel [1]),
    .I2(\cpu6502/alu_dest_reg_sel [2]),
    .I3(\cpu6502/alu_dest_reg_sel [0]),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg )
  );
  LUT6 #(
    .INIT ( 64'hEAEEFEEE40445444 ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[3]_MUX_176_o11  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I1(\cpu6502/alu/d_flag_84 ),
    .I2(\cpu6502/sreg_operation_sel [0]),
    .I3(\cpu6502/sreg_mask [3]),
    .I4(\cpu6502/sreg_operation_sel [1]),
    .I5(\cpu6502/mem_din_reg [3]),
    .O(\cpu6502/alu/status_op[1]_mem_in[3]_MUX_176_o )
  );
  LUT6 #(
    .INIT ( 64'hEAEEFEEE40445444 ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[2]_MUX_171_o11  (
    .I0(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I1(\cpu6502/alu/i_flag_83 ),
    .I2(\cpu6502/sreg_operation_sel [0]),
    .I3(\cpu6502/sreg_mask [2]),
    .I4(\cpu6502/sreg_operation_sel [1]),
    .I5(\cpu6502/mem_din_reg [2]),
    .O(\cpu6502/alu/status_op[1]_mem_in[2]_MUX_171_o )
  );
  LUT3 #(
    .INIT ( 8'h1E ))
  \cpu6502/alu/Mmux_op211  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [0])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op221  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [1])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op231  (
    .I0(\cpu6502/mem_din_reg [2]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [2])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op241  (
    .I0(\cpu6502/mem_din_reg [3]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [3])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op251  (
    .I0(\cpu6502/mem_din_reg [4]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [4])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op261  (
    .I0(\cpu6502/mem_din_reg [5]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [5])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op271  (
    .I0(\cpu6502/mem_din_reg [6]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [6])
  );
  LUT3 #(
    .INIT ( 8'hD2 ))
  \cpu6502/alu/Mmux_op281  (
    .I0(\cpu6502/mem_din_reg [7]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .O(\cpu6502/alu/op2 [7])
  );
  LUT5 #(
    .INIT ( 32'hAAAA0008 ))
  \cpu6502/alu/_n0237_inv1  (
    .I0(\cpu6502/alu_en ),
    .I1(\cpu6502/sreg_mask [5]),
    .I2(\cpu6502/sreg_operation_sel [0]),
    .I3(\cpu6502/sreg_operation_sel [1]),
    .I4(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .O(\cpu6502/alu/_n0237_inv )
  );
  LUT5 #(
    .INIT ( 32'hAAAA0008 ))
  \cpu6502/alu/_n0227_inv1  (
    .I0(\cpu6502/alu_en ),
    .I1(\cpu6502/sreg_mask [1]),
    .I2(\cpu6502/sreg_operation_sel [0]),
    .I3(\cpu6502/sreg_operation_sel [1]),
    .I4(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .O(\cpu6502/alu/_n0227_inv )
  );
  LUT5 #(
    .INIT ( 32'hAAAA0888 ))
  \cpu6502/alu/_n0221_inv1  (
    .I0(\cpu6502/alu_en ),
    .I1(\cpu6502/sreg_mask [0]),
    .I2(\cpu6502/sreg_operation_sel [0]),
    .I3(\cpu6502/sreg_operation_sel [1]),
    .I4(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .O(\cpu6502/alu/_n0221_inv )
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  \cpu6502/alu/c_in1  (
    .I0(\cpu6502/alu/c_flag_81 ),
    .I1(\cpu6502/alu_cin_sel [0]),
    .I2(\cpu6502/alu_cin_sel [1]),
    .O(\cpu6502/alu/c_in )
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o<2>1  (
    .I0(\cpu6502/alu_dest_reg_sel [2]),
    .I1(\cpu6502/alu_dest_reg_sel [1]),
    .I2(\cpu6502/alu_dest_reg_sel [0]),
    .O(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [1]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>2_560 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>1_559 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1> )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [2]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>2_562 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>1_561 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2> )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [3]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>2_564 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>1_563 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3> )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [4]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>2_566 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>1_565 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4> )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [6]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>2_568 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>1_567 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6> )
  );
  LUT6 #(
    .INIT ( 64'h3373226211510040 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>3  (
    .I0(\cpu6502/data_out_sel [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I2(\cpu6502/mem_din_reg [7]),
    .I3(\cpu6502/data_out_sel [1]),
    .I4(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>2_570 ),
    .I5(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>1_569 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7> )
  );
  LUT4 #(
    .INIT ( 16'h7FFF ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<7>_SW0  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I1(\cpu6502/addr_gen/addr2_h_reg [5]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [6]),
    .I3(\cpu6502/addr_gen/addr2_h_reg [4]),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h5454544510101001 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<7>  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [7]),
    .I3(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ),
    .I4(N4),
    .I5(mst_mem_din[7]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<7>_282 )
  );
  LUT3 #(
    .INIT ( 8'h7F ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<6>_SW0  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I1(\cpu6502/addr_gen/addr2_h_reg [5]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [4]),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'h5454544510101001 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<6>  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [6]),
    .I3(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ),
    .I4(N6),
    .I5(mst_mem_din[6]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<6>_281 )
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<5>_SW0  (
    .I0(\cpu6502/addr_gen/addr2_h_reg [3]),
    .I1(\cpu6502/addr_gen/addr2_h_reg [4]),
    .O(N8)
  );
  LUT6 #(
    .INIT ( 64'h5454544510101001 ))
  \cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<5>  (
    .I0(\cpu6502/controller/addr_ctrl_signals [0]),
    .I1(\cpu6502/controller/addr_ctrl_signals [6]),
    .I2(\cpu6502/addr_gen/addr2_h_reg [5]),
    .I3(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<3>_bdd0 ),
    .I4(N8),
    .I5(mst_mem_din[5]),
    .O(\cpu6502/addr_gen/addr2_h_reg[7]_GND_7_o_mux_23_OUT<5>_280 )
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \cpu6502/controller/current_state_FSM_FFd10-In_SW0  (
    .I0(\cpu6502/operation_type [0]),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .O(N10)
  );
  LUT6 #(
    .INIT ( 64'hEAEAEAEA2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd10-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd10_373 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/operation_type [2]),
    .I4(N10),
    .I5(\cpu6502/controller/current_state_FSM_FFd9_374 ),
    .O(\cpu6502/controller/current_state_FSM_FFd10-In_314 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \cpu6502/controller/current_state_FSM_FFd1-In_SW0  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_rising),
    .O(N12)
  );
  LUT6 #(
    .INIT ( 64'h08FF00FF08000000 ))
  \cpu6502/controller/current_state_FSM_FFd1-In  (
    .I0(\cpu6502/operation_type [2]),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/operation_type [0]),
    .I3(N12),
    .I4(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .I5(\cpu6502/controller/current_state_FSM_FFd1_376 ),
    .O(\cpu6502/controller/current_state_FSM_FFd1-In_305 )
  );
  LUT6 #(
    .INIT ( 64'h8000FFFF80000000 ))
  \cpu6502/controller/current_state_FSM_FFd9-In  (
    .I0(\cpu6502/operation_type [2]),
    .I1(\cpu6502/operation_type [1]),
    .I2(\cpu6502/operation_type [0]),
    .I3(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .I4(N12),
    .I5(\cpu6502/controller/current_state_FSM_FFd9_374 ),
    .O(\cpu6502/controller/current_state_FSM_FFd9-In_313 )
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \cpu6502/controller/current_state_FSM_FFd19-In_SW0  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [1]),
    .O(N18)
  );
  LUT6 #(
    .INIT ( 64'h2A2A2A2A2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd19-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd19_303 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .I4(\cpu6502/operation_type [2]),
    .I5(N18),
    .O(\cpu6502/controller/current_state_FSM_FFd19-In_323 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_108_OUT<2>_SW0  (
    .I0(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd9_374 ),
    .O(N20)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_108_OUT<2>  (
    .I0(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd15_375 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd10_373 ),
    .I5(N20),
    .O(\cpu6502/controller/current_state[4]_PWR_4_o_select_108_OUT<2> )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \cpu6502/controller/current_state[4]_GND_4_o_Select_62_o_SW0  (
    .I0(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .O(N22)
  );
  LUT6 #(
    .INIT ( 64'hA2A2A2A2A2A2A2AE ))
  \cpu6502/controller/current_state[4]_GND_4_o_Select_62_o  (
    .I0(\cpu6502/controller/rst_active_389 ),
    .I1(N22),
    .I2(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd20_388 ),
    .I5(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_Select_62_o_349 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd6_379 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd14_380 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .O(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3> )
  );
  LUT5 #(
    .INIT ( 32'hFEFEFFFE ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd1_376 ),
    .I2(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3> ),
    .I3(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I4(\cpu6502/controller/is_interrupt ),
    .O(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>1_580 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF0440 ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>3  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I2(\cpu6502/addr_mode [2]),
    .I3(\cpu6502/addr_mode [1]),
    .I4(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>1_580 ),
    .O(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>2_581 )
  );
  LUT6 #(
    .INIT ( 64'hFEFEFEFEFEFFFEFE ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>4  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/addr_mode [2]),
    .I3(\cpu6502/operation_type [2]),
    .I4(\cpu6502/operation_type [0]),
    .I5(\cpu6502/operation_type [1]),
    .O(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>3_582 )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>5  (
    .I0(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>2_581 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I2(\cpu6502/controller/current_state_current_state[4]_PWR_4_o_select_83_OUT<3>3_582 ),
    .O(\cpu6502/controller/current_state[4]_PWR_4_o_select_83_OUT<3> )
  );
  LUT4 #(
    .INIT ( 16'h7520 ))
  \cpu6502/controller/current_state_current_state[4]_mem_operation[1]_Select_167_o_SW0  (
    .I0(\cpu6502/mem_operation [1]),
    .I1(\cpu6502/mem_operation [0]),
    .I2(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .O(N24)
  );
  LUT6 #(
    .INIT ( 64'hFEEEEEEEEEEEEEEE ))
  \cpu6502/controller/current_state_current_state[4]_mem_operation[1]_Select_167_o  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(N24),
    .I2(\cpu6502/operation_type [2]),
    .I3(\cpu6502/operation_type [1]),
    .I4(\cpu6502/operation_type [0]),
    .I5(\cpu6502/controller/current_state_FSM_FFd10_373 ),
    .O(\cpu6502/controller/current_state[4]_mem_operation[1]_Select_167_o )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \cpu6502/controller/current_state_address_sel<0>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd20_388 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .O(\cpu6502/controller/current_state_address_sel [0])
  );
  LUT6 #(
    .INIT ( 64'hFFFF088008800880 ))
  \cpu6502/controller/current_state_address_sel<0>2  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/controller/current_state_address_sel [0]),
    .I2(\cpu6502/addr_mode [1]),
    .I3(\cpu6502/addr_mode [2]),
    .I4(\cpu6502/controller/current_state_FSM_FFd23_358 ),
    .I5(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_130_o ),
    .O(\cpu6502/controller/current_state_address_sel<0>1_585 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  \cpu6502/controller/current_state_address_sel<0>3  (
    .I0(\cpu6502/controller/current_state_address_sel<0>2_299 ),
    .I1(\cpu6502/controller/current_state[4]_PWR_4_o_select_108_OUT<2> ),
    .I2(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd8_302 ),
    .I4(\cpu6502/controller/current_state_address_sel<0>1_585 ),
    .O(\cpu6502/address_sel [0])
  );
  LUT6 #(
    .INIT ( 64'h0000000000FEFE00 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<4>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .I3(\cpu6502/addr_mode [1]),
    .I4(\cpu6502/addr_mode [2]),
    .I5(\cpu6502/addr_mode [0]),
    .O(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<4> )
  );
  LUT5 #(
    .INIT ( 32'hAAAAAAA8 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<4>2  (
    .I0(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd8_302 ),
    .I4(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<4> ),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<4> )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>_SW0  (
    .I0(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .O(N26)
  );
  LUT6 #(
    .INIT ( 64'hA8A8A80080808000 ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>  (
    .I0(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 ),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [1]),
    .I3(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .I4(N26),
    .I5(\cpu6502/addr_mode [0]),
    .O(\cpu6502/controller/current_state[4]_GND_4_o_select_152_OUT<1> )
  );
  LUT5 #(
    .INIT ( 32'hFFFFAAA2 ))
  \cpu6502/controller/current_state_FSM_FFd6-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd14_380 ),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/addr_mode [2]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .O(\cpu6502/controller/current_state_FSM_FFd6-In1_588 )
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  \cpu6502/controller/current_state_FSM_FFd6-In2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd6_379 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd6-In1_588 ),
    .O(\cpu6502/controller/current_state_FSM_FFd6-In )
  );
  LUT4 #(
    .INIT ( 16'hFFD9 ))
  \cpu6502/controller/current_state_FSM_FFd22-In_SW0  (
    .I0(\cpu6502/addr_mode [2]),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/addr_mode [0]),
    .I3(\cpu6502/operation_type [2]),
    .O(N28)
  );
  LUT6 #(
    .INIT ( 64'hEAEAEAEA2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd22-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .I4(N28),
    .I5(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .O(\cpu6502/controller/current_state_FSM_FFd22-In_326 )
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \cpu6502/controller/current_state_FSM_FFd17-In_SW0  (
    .I0(\cpu6502/operation_type [1]),
    .I1(\cpu6502/operation_type [0]),
    .I2(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .O(N30)
  );
  LUT6 #(
    .INIT ( 64'hEAEAEAEA2A2A2AEA ))
  \cpu6502/controller/current_state_FSM_FFd17-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/operation_type [2]),
    .I4(N30),
    .I5(\cpu6502/controller/current_state_FSM_FFd23_358 ),
    .O(\cpu6502/controller/current_state_FSM_FFd17-In_321 )
  );
  LUT6 #(
    .INIT ( 64'hFFFF400040004000 ))
  \cpu6502/controller/current_state_FSM_FFd23-In1  (
    .I0(\cpu6502/operation_type [1]),
    .I1(\cpu6502/operation_type [2]),
    .I2(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I3(\cpu6502/operation_type [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I5(\cpu6502/controller/is_interrupt ),
    .O(\cpu6502/controller/current_state_FSM_FFd23-In1_591 )
  );
  LUT4 #(
    .INIT ( 16'hEA2A ))
  \cpu6502/controller/current_state_FSM_FFd23-In2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd23_358 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd23-In1_591 ),
    .O(\cpu6502/controller/current_state_FSM_FFd23-In )
  );
  LUT4 #(
    .INIT ( 16'hE6FF ))
  \cpu6502/controller/current_state_FSM_FFd12-In_SW0  (
    .I0(\cpu6502/addr_mode [0]),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/mem_operation [0]),
    .I3(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .O(N34)
  );
  LUT6 #(
    .INIT ( 64'h2AEA2A2A2A2A2A2A ))
  \cpu6502/controller/current_state_FSM_FFd12-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd12_356 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(N34),
    .I4(\cpu6502/addr_mode [2]),
    .I5(\cpu6502/mem_operation [1]),
    .O(\cpu6502/controller/current_state_FSM_FFd12-In_316 )
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \cpu6502/controller/current_state_FSM_FFd21-In1  (
    .I0(\cpu6502/addr_mode [1]),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [0]),
    .O(\cpu6502/controller/current_state_FSM_FFd21-In1_593 )
  );
  LUT5 #(
    .INIT ( 32'hCFCF8A0A ))
  \cpu6502/controller/current_state_FSM_FFd21-In2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I1(\cpu6502/mem_operation [0]),
    .I2(\cpu6502/mem_operation [1]),
    .I3(\cpu6502/controller/current_state_FSM_FFd21-In1_593 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd20-In111 ),
    .O(\cpu6502/controller/current_state_FSM_FFd21-In2_594 )
  );
  LUT5 #(
    .INIT ( 32'hFAAA8AAA ))
  \cpu6502/controller/current_state_FSM_FFd21-In3  (
    .I0(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .I1(\cpu6502/addr_gen/address_carry_165 ),
    .I2(ph2_rising),
    .I3(\cpu6502/controller/set_next_state_127 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd21-In2_594 ),
    .O(\cpu6502/controller/current_state_FSM_FFd21-In )
  );
  LUT4 #(
    .INIT ( 16'hFF7F ))
  \cpu6502/controller/current_state_FSM_FFd18-In_SW0  (
    .I0(\cpu6502/addr_mode [2]),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/addr_mode [0]),
    .I3(\cpu6502/operation_type [2]),
    .O(N36)
  );
  LUT6 #(
    .INIT ( 64'hEAEAEAEA2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd18-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .I4(N36),
    .I5(\cpu6502/controller/current_state_FSM_FFd19_303 ),
    .O(\cpu6502/controller/current_state_FSM_FFd18-In_322 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF2AA2 ))
  \cpu6502/controller/current_state_FSM_FFd20-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I1(\cpu6502/addr_mode [2]),
    .I2(\cpu6502/addr_mode [1]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd20-In111 ),
    .O(\cpu6502/controller/current_state_FSM_FFd20-In1_596 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \cpu6502/controller/current_state_FSM_FFd20-In2  (
    .I0(\cpu6502/mem_operation [1]),
    .I1(\cpu6502/mem_operation [0]),
    .O(\cpu6502/controller/current_state_FSM_FFd20-In2_597 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFF77788888000 ))
  \cpu6502/controller/current_state_FSM_FFd20-In3  (
    .I0(ph2_rising),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd20-In1_596 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd20-In2_597 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I5(\cpu6502/controller/current_state_FSM_FFd20_388 ),
    .O(\cpu6502/controller/current_state_FSM_FFd20-In )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \cpu6502/controller/current_state_FSM_FFd25-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd7_301 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd8_302 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd5_378 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd1_376 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd20_388 ),
    .I5(\cpu6502/controller/current_state_FSM_FFd16_387 ),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In1_598 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF0222 ))
  \cpu6502/controller/current_state_FSM_FFd25-In2  (
    .I0(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .I1(\cpu6502/addr_gen/address_carry_165 ),
    .I2(\cpu6502/mem_operation [1]),
    .I3(\cpu6502/mem_operation [0]),
    .I4(\cpu6502/controller/current_state_FSM_FFd25-In1_598 ),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In2_599 )
  );
  LUT4 #(
    .INIT ( 16'h8AAA ))
  \cpu6502/controller/current_state_FSM_FFd25-In3  (
    .I0(\cpu6502/controller/current_state_FSM_FFd2_377 ),
    .I1(\cpu6502/operation_type [0]),
    .I2(\cpu6502/operation_type [2]),
    .I3(\cpu6502/operation_type [1]),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In3_600 )
  );
  LUT6 #(
    .INIT ( 64'h02CE22CE02022202 ))
  \cpu6502/controller/current_state_FSM_FFd25-In5  (
    .I0(\cpu6502/controller/current_state_FSM_FFd25-In22 ),
    .I1(\cpu6502/addr_mode [1]),
    .I2(\cpu6502/operation_type [2]),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/controller/branch_taken ),
    .I5(\cpu6502/controller/current_state_FSM_FFd14_380 ),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In5_602 )
  );
  LUT6 #(
    .INIT ( 64'hEAEAEAEA2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd25-In6  (
    .I0(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd25-In5_602 ),
    .I4(\cpu6502/addr_mode [2]),
    .I5(\cpu6502/controller/current_state_FSM_FFd25-In4_601 ),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_SW0  (
    .I0(\cpu6502/controller/current_state_FSM_FFd18_343 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd19_303 ),
    .O(N38)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd12_356 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd22_357 ),
    .I5(N38),
    .O(\cpu6502/controller/current_state_current_state[4]_GND_4_o_select_152_OUT<1>1_300 )
  );
  LUT4 #(
    .INIT ( 16'hF888 ))
  \cpu6502/controller/out8_SW0  (
    .I0(\cpu6502/alu/c_flag_81 ),
    .I1(\cpu6502/sreg_mask [0]),
    .I2(\cpu6502/alu/z_flag_82 ),
    .I3(\cpu6502/sreg_mask [1]),
    .O(N40)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA888888A8 ))
  \cpu6502/alu/_n0199_inv  (
    .I0(N42),
    .I1(\cpu6502/controller/stack_ctrl_signals [1]),
    .I2(\cpu6502/alu_dest_reg_sel [2]),
    .I3(\cpu6502/alu_dest_reg_sel [1]),
    .I4(\cpu6502/alu_dest_reg_sel [0]),
    .I5(\cpu6502/controller/stack_ctrl_signals [0]),
    .O(\cpu6502/alu/_n0199_inv_504 )
  );
  LUT6 #(
    .INIT ( 64'hF7A2D580A2A28080 ))
  \cpu6502/alu/Mmux_alu_result81  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/c_in ),
    .I3(\cpu6502/alu/op2 [7]),
    .I4(\cpu6502/alu/op1 [6]),
    .I5(\cpu6502/alu/op1 [7]),
    .O(\cpu6502/alu/Mmux_alu_result8 )
  );
  LUT6 #(
    .INIT ( 64'hFFDC3310FFCC3300 ))
  \cpu6502/alu/Mmux_alu_result83  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu/Mmux_alu_result81_607 ),
    .I4(\cpu6502/alu/Mmux_alu_result8 ),
    .I5(\cpu6502/alu/n0137 [7]),
    .O(\cpu6502/alu/alu_result [7])
  );
  LUT5 #(
    .INIT ( 32'h01000000 ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o11  (
    .I0(\cpu6502/sreg_operation_sel [1]),
    .I1(\cpu6502/sreg_operation_sel [0]),
    .I2(\cpu6502/alu_operation_sel [2]),
    .I3(\cpu6502/sreg_mask [4]),
    .I4(\cpu6502/alu_operation_sel [0]),
    .O(\cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o1 )
  );
  LUT6 #(
    .INIT ( 64'h808080C4C4808080 ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o12  (
    .I0(\cpu6502/alu_operation_sel [1]),
    .I1(\cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o1 ),
    .I2(\cpu6502/alu/op2 [6]),
    .I3(\cpu6502/alu/op2 [7]),
    .I4(\cpu6502/alu/op1 [7]),
    .I5(\cpu6502/alu/n0137 [7]),
    .O(\cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o11_609 )
  );
  LUT6 #(
    .INIT ( 64'hCCCCFFFFCCCCAA0A ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o13  (
    .I0(\cpu6502/alu/v_flag_85 ),
    .I1(\cpu6502/mem_din_reg [6]),
    .I2(\cpu6502/sreg_mask [4]),
    .I3(\cpu6502/sreg_operation_sel [0]),
    .I4(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I5(\cpu6502/alu/Mmux_status_op[1]_mem_in[6]_MUX_181_o11_609 ),
    .O(\cpu6502/alu/status_op[1]_mem_in[6]_MUX_181_o )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op18_SW0  (
    .I0(\cpu6502/alu/accumulator [7]),
    .I1(\cpu6502/alu/stack_ptr_reg [7]),
    .I2(\cpu6502/alu/y_reg [7]),
    .I3(\cpu6502/alu/x_reg [7]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N79)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op18  (
    .I0(\cpu6502/mem_din_reg [7]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N79),
    .O(\cpu6502/alu/op1 [7])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op17_SW0  (
    .I0(\cpu6502/alu/accumulator [6]),
    .I1(\cpu6502/alu/stack_ptr_reg [6]),
    .I2(\cpu6502/alu/y_reg [6]),
    .I3(\cpu6502/alu/x_reg [6]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N81)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op17  (
    .I0(\cpu6502/mem_din_reg [6]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N81),
    .O(\cpu6502/alu/op1 [6])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op16_SW0  (
    .I0(\cpu6502/alu/accumulator [5]),
    .I1(\cpu6502/alu/stack_ptr_reg [5]),
    .I2(\cpu6502/alu/y_reg [5]),
    .I3(\cpu6502/alu/x_reg [5]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N83)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op16  (
    .I0(\cpu6502/mem_din_reg [5]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N83),
    .O(\cpu6502/alu/op1 [5])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op15_SW0  (
    .I0(\cpu6502/alu/accumulator [4]),
    .I1(\cpu6502/alu/stack_ptr_reg [4]),
    .I2(\cpu6502/alu/y_reg [4]),
    .I3(\cpu6502/alu/x_reg [4]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N85)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op15  (
    .I0(\cpu6502/mem_din_reg [4]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N85),
    .O(\cpu6502/alu/op1 [4])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op14_SW0  (
    .I0(\cpu6502/alu/accumulator [3]),
    .I1(\cpu6502/alu/stack_ptr_reg [3]),
    .I2(\cpu6502/alu/y_reg [3]),
    .I3(\cpu6502/alu/x_reg [3]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N87)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op14  (
    .I0(\cpu6502/mem_din_reg [3]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N87),
    .O(\cpu6502/alu/op1 [3])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op13_SW0  (
    .I0(\cpu6502/alu/accumulator [2]),
    .I1(\cpu6502/alu/stack_ptr_reg [2]),
    .I2(\cpu6502/alu/y_reg [2]),
    .I3(\cpu6502/alu/x_reg [2]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N89)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op13  (
    .I0(\cpu6502/mem_din_reg [2]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N89),
    .O(\cpu6502/alu/op1 [2])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op12_SW0  (
    .I0(\cpu6502/alu/accumulator [1]),
    .I1(\cpu6502/alu/stack_ptr_reg [1]),
    .I2(\cpu6502/alu/y_reg [1]),
    .I3(\cpu6502/alu/x_reg [1]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N91)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op12  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N91),
    .O(\cpu6502/alu/op1 [1])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \cpu6502/alu/Mmux_op11_SW0  (
    .I0(\cpu6502/alu/accumulator [0]),
    .I1(\cpu6502/alu/stack_ptr_reg [0]),
    .I2(\cpu6502/alu/y_reg [0]),
    .I3(\cpu6502/alu/x_reg [0]),
    .I4(\cpu6502/alu_operand1_sel [0]),
    .I5(\cpu6502/alu_operand1_sel [1]),
    .O(N93)
  );
  LUT3 #(
    .INIT ( 8'hB8 ))
  \cpu6502/alu/Mmux_op11  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N93),
    .O(\cpu6502/alu/op1 [0])
  );
  LUT6 #(
    .INIT ( 64'hEAEAAAEAEAAAAAAA ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o11  (
    .I0(\cpu6502/sreg_operation_sel [0]),
    .I1(\cpu6502/alu_operation_sel [2]),
    .I2(\cpu6502/alu_operation_sel [1]),
    .I3(\cpu6502/alu_operation_sel [0]),
    .I4(\cpu6502/alu/op1 [0]),
    .I5(\cpu6502/alu/op1 [7]),
    .O(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o1 )
  );
  FDR   \cpu6502/controller/nmi_recognized  (
    .C(clk),
    .D(\cpu6502/controller/nmi_recognized_glue_set_619 ),
    .R(rst),
    .Q(\cpu6502/controller/nmi_recognized_369 )
  );
  FDR   \cpu6502/controller/nmi_active  (
    .C(clk),
    .D(\cpu6502/controller/nmi_active_glue_set_620 ),
    .R(rst),
    .Q(\cpu6502/controller/nmi_active_370 )
  );
  FDS   \cpu6502/controller/rst_active  (
    .C(clk),
    .D(\cpu6502/controller/rst_active_glue_rst_621 ),
    .S(rst),
    .Q(\cpu6502/controller/rst_active_389 )
  );
  LUT5 #(
    .INIT ( 32'hAFA3ACA0 ))
  \cpu6502/alu/Mmux_n_flag_mem_in[7]_MUX_185_o11  (
    .I0(\cpu6502/mem_din_reg [7]),
    .I1(\cpu6502/alu_operation_sel [2]),
    .I2(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I3(\cpu6502/alu/Mmux_alu_negative_3_455 ),
    .I4(\cpu6502/alu/Mmux_alu_negative_4_456 ),
    .O(\cpu6502/alu/n_flag_mem_in[7]_MUX_185_o )
  );
  LUT5 #(
    .INIT ( 32'hF5C4B180 ))
  \cpu6502/alu/Mmux_alu_negative_4  (
    .I0(\cpu6502/alu_operation_sel [1]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/op2 [7]),
    .I3(\cpu6502/alu/op1 [7]),
    .I4(\cpu6502/alu/n0137 [7]),
    .O(\cpu6502/alu/Mmux_alu_negative_4_456 )
  );
  LUT6 #(
    .INIT ( 64'h888888888888888B ))
  \cpu6502/alu/Mmux_z_flag_mem_in[1]_MUX_166_o1_SW0_SW0  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I2(\cpu6502/alu/alu_result [0]),
    .I3(\cpu6502/alu/alu_result [1]),
    .I4(\cpu6502/alu/alu_result [2]),
    .I5(\cpu6502/alu/alu_result [3]),
    .O(N100)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAABAAAAAAA8 ))
  \cpu6502/alu/Mmux_z_flag_mem_in[1]_MUX_166_o1  (
    .I0(N101),
    .I1(\cpu6502/alu/alu_result [7]),
    .I2(\cpu6502/alu/alu_result [6]),
    .I3(\cpu6502/alu/alu_result [5]),
    .I4(\cpu6502/alu/alu_result [4]),
    .I5(N100),
    .O(\cpu6502/alu/z_flag_mem_in[1]_MUX_166_o )
  );
  LUT5 #(
    .INIT ( 32'hDD88D8D8 ))
  \cpu6502/alu/Mmux_alu_result4  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N104),
    .I2(N103),
    .I3(N105),
    .I4(\cpu6502/alu/n0137 [3]),
    .O(\cpu6502/alu/alu_result [3])
  );
  LUT5 #(
    .INIT ( 32'hFA50EE44 ))
  \cpu6502/alu/Mmux_alu_result3  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N107),
    .I2(N109),
    .I3(N108),
    .I4(\cpu6502/alu/n0137 [2]),
    .O(\cpu6502/alu/alu_result [2])
  );
  LUT5 #(
    .INIT ( 32'hFA50EE44 ))
  \cpu6502/alu/Mmux_alu_result2  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N111),
    .I2(N113),
    .I3(N112),
    .I4(\cpu6502/alu/n0137 [1]),
    .O(\cpu6502/alu/alu_result [1])
  );
  LUT5 #(
    .INIT ( 32'hFEBA5410 ))
  \cpu6502/alu/Mmux_alu_result1  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(\cpu6502/alu/n0137 [0]),
    .I2(N115),
    .I3(N117),
    .I4(N116),
    .O(\cpu6502/alu/alu_result [0])
  );
  LUT6 #(
    .INIT ( 64'hBF379D15FA72D850 ))
  \cpu6502/alu/Mmux_alu_result5_SW5  (
    .I0(\cpu6502/alu_operation_sel [1]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/op2 [4]),
    .I3(\cpu6502/alu/op1 [5]),
    .I4(\cpu6502/alu/op1 [3]),
    .I5(\cpu6502/alu/op1 [4]),
    .O(N120)
  );
  LUT5 #(
    .INIT ( 32'hFAEE5044 ))
  \cpu6502/alu/Mmux_alu_result5  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N119),
    .I2(N121),
    .I3(\cpu6502/alu/n0137 [4]),
    .I4(N120),
    .O(\cpu6502/alu/alu_result [4])
  );
  LUT6 #(
    .INIT ( 64'hBFFA37729DD81550 ))
  \cpu6502/alu/Mmux_alu_result6_SW5  (
    .I0(\cpu6502/alu_operation_sel [1]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/op2 [5]),
    .I3(\cpu6502/alu/op1 [5]),
    .I4(\cpu6502/alu/op1 [6]),
    .I5(\cpu6502/alu/op1 [4]),
    .O(N124)
  );
  LUT5 #(
    .INIT ( 32'hFAEE5044 ))
  \cpu6502/alu/Mmux_alu_result6  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N123),
    .I2(N125),
    .I3(\cpu6502/alu/n0137 [5]),
    .I4(N124),
    .O(\cpu6502/alu/alu_result [5])
  );
  LUT6 #(
    .INIT ( 64'hBF9DFAD837157250 ))
  \cpu6502/alu/Mmux_alu_result7_SW5  (
    .I0(\cpu6502/alu_operation_sel [1]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/op2 [6]),
    .I3(\cpu6502/alu/op1 [5]),
    .I4(\cpu6502/alu/op1 [6]),
    .I5(\cpu6502/alu/op1 [7]),
    .O(N128)
  );
  LUT5 #(
    .INIT ( 32'hFA50EE44 ))
  \cpu6502/alu/Mmux_alu_result7  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(N127),
    .I2(N129),
    .I3(N128),
    .I4(\cpu6502/alu/n0137 [6]),
    .O(\cpu6502/alu/alu_result [6])
  );
  LUT5 #(
    .INIT ( 32'hB4E1B41E ))
  \cpu6502/alu/Madd_n0137_Madd_lut<0>  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N93),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [0])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<1>  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N91),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [1])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<2>  (
    .I0(\cpu6502/mem_din_reg [2]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N89),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [2])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<3>  (
    .I0(\cpu6502/mem_din_reg [3]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N87),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [3])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<4>  (
    .I0(\cpu6502/mem_din_reg [4]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N85),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [4])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<5>  (
    .I0(\cpu6502/mem_din_reg [5]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N83),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [5])
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result4_SW4  (
    .I0(\cpu6502/mem_din_reg [3]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N87),
    .I5(\cpu6502/alu/op2 [3]),
    .O(N103)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result4_SW6  (
    .I0(\cpu6502/mem_din_reg [3]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N87),
    .I5(\cpu6502/alu/op2 [3]),
    .O(N105)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result3_SW4  (
    .I0(\cpu6502/mem_din_reg [2]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N89),
    .I5(\cpu6502/alu/op2 [2]),
    .O(N107)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result3_SW6  (
    .I0(\cpu6502/mem_din_reg [2]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N89),
    .I5(\cpu6502/alu/op2 [2]),
    .O(N109)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result2_SW4  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N91),
    .I5(\cpu6502/alu/op2 [1]),
    .O(N111)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result2_SW6  (
    .I0(\cpu6502/mem_din_reg [1]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N91),
    .I5(\cpu6502/alu/op2 [1]),
    .O(N113)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result1_SW4  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N93),
    .I5(\cpu6502/alu/op2 [0]),
    .O(N115)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result1_SW6  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N93),
    .I5(\cpu6502/alu/op2 [0]),
    .O(N117)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result5_SW4  (
    .I0(\cpu6502/mem_din_reg [4]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N85),
    .I5(\cpu6502/alu/op2 [4]),
    .O(N119)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result5_SW6  (
    .I0(\cpu6502/mem_din_reg [4]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N85),
    .I5(\cpu6502/alu/op2 [4]),
    .O(N121)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result6_SW4  (
    .I0(\cpu6502/mem_din_reg [5]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N83),
    .I5(\cpu6502/alu/op2 [5]),
    .O(N123)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result6_SW6  (
    .I0(\cpu6502/mem_din_reg [5]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N83),
    .I5(\cpu6502/alu/op2 [5]),
    .O(N125)
  );
  LUT6 #(
    .INIT ( 64'h8ACF8A0002030200 ))
  \cpu6502/alu/Mmux_alu_result7_SW4  (
    .I0(\cpu6502/mem_din_reg [6]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N81),
    .I5(\cpu6502/alu/op2 [6]),
    .O(N127)
  );
  LUT6 #(
    .INIT ( 64'hBAFFBA3032333230 ))
  \cpu6502/alu/Mmux_alu_result7_SW6  (
    .I0(\cpu6502/mem_din_reg [6]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N81),
    .I5(\cpu6502/alu/op2 [6]),
    .O(N129)
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<7>_SW0  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(\cpu6502/alu_operation_sel [0]),
    .I2(\cpu6502/alu/n0137 [7]),
    .O(N131)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<7>_SW1  (
    .I0(\cpu6502/alu/stack_ptr_reg [7]),
    .I1(\cpu6502/controller/stack_ctrl_signals [0]),
    .O(N132)
  );
  LUT6 #(
    .INIT ( 64'hAFACA3A0AFAFA3A3 ))
  \cpu6502/alu/Mcount_stack_ptr_reg_lut<7>  (
    .I0(N132),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_44_o_inv ),
    .I3(\cpu6502/alu/Mmux_alu_result81_607 ),
    .I4(\cpu6502/alu/Mmux_alu_result8 ),
    .I5(N131),
    .O(\cpu6502/alu/Mcount_stack_ptr_reg_lut [7])
  );
  LUT6 #(
    .INIT ( 64'hAAAAAA95AA95AA95 ))
  \cpu6502/controller/Mxor_branch_taken_xo<0>1  (
    .I0(\cpu6502/branch_flag_val ),
    .I1(\cpu6502/alu/v_flag_85 ),
    .I2(\cpu6502/sreg_mask [4]),
    .I3(N40),
    .I4(\cpu6502/alu/n_flag_86 ),
    .I5(\cpu6502/sreg_mask [5]),
    .O(\cpu6502/controller/branch_taken )
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<0>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [0]),
    .I2(\cpu6502/alu/y_reg [0]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [0]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [0])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<1>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [1]),
    .I2(\cpu6502/alu/y_reg [1]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [1]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [1])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<2>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [2]),
    .I2(\cpu6502/alu/y_reg [2]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [2]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [2])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<3>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [3]),
    .I2(\cpu6502/alu/y_reg [3]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [3]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [3])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<4>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [4]),
    .I2(\cpu6502/alu/y_reg [4]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [4]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [4])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<5>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [5]),
    .I2(\cpu6502/alu/y_reg [5]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [5]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [5])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<6>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [6]),
    .I2(\cpu6502/alu/y_reg [6]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [6]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [6])
  );
  LUT4 #(
    .INIT ( 16'h1BE4 ))
  \cpu6502/addr_gen/Madd_addr2_l_reg_in_lut<7>  (
    .I0(\cpu6502/index_reg_sel ),
    .I1(\cpu6502/alu/x_reg [7]),
    .I2(\cpu6502/alu/y_reg [7]),
    .I3(\cpu6502/addr_gen/addr2_l_reg [7]),
    .O(\cpu6502/addr_gen/Madd_addr2_l_reg_in_lut [7])
  );
  LUT3 #(
    .INIT ( 8'h59 ))
  \cpu6502/pc/Madd_n0067_lut<0>  (
    .I0(\cpu6502/pc/pc [0]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [0]),
    .O(\cpu6502/pc/Madd_n0067_lut [0])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<1>  (
    .I0(\cpu6502/pc/pc [1]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [1]),
    .O(\cpu6502/pc/Madd_n0067_lut [1])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<2>  (
    .I0(\cpu6502/pc/pc [2]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [2]),
    .O(\cpu6502/pc/Madd_n0067_lut [2])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<3>  (
    .I0(\cpu6502/pc/pc [3]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [3]),
    .O(\cpu6502/pc/Madd_n0067_lut [3])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<4>  (
    .I0(\cpu6502/pc/pc [4]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [4]),
    .O(\cpu6502/pc/Madd_n0067_lut [4])
  );
  LUT5 #(
    .INIT ( 32'hFFFFEAAE ))
  \cpu6502/controller/current_state_FSM_FFd25-In4  (
    .I0(\cpu6502/controller/current_state_FSM_FFd25-In2_599 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .I2(\cpu6502/pc/Madd_n0067_cy [7]),
    .I3(\cpu6502/mem_din_reg [7]),
    .I4(\cpu6502/controller/current_state_FSM_FFd25-In3_600 ),
    .O(\cpu6502/controller/current_state_FSM_FFd25-In4_601 )
  );
  LUT6 #(
    .INIT ( 64'h4E0F4ECC8ACF8A00 ))
  \cpu6502/alu/Mmux_alu_result82  (
    .I0(\cpu6502/mem_din_reg [7]),
    .I1(\cpu6502/alu_operation_sel [2]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N79),
    .I5(\cpu6502/alu/op2 [7]),
    .O(\cpu6502/alu/Mmux_alu_result81_607 )
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<6>  (
    .I0(\cpu6502/mem_din_reg [6]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N81),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut [6])
  );
  LUT5 #(
    .INIT ( 32'h782D78D2 ))
  \cpu6502/alu/Madd_n0137_Madd_lut<7>1  (
    .I0(\cpu6502/mem_din_reg [7]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/alu_operand2_sel [0]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N79),
    .O(\cpu6502/alu/Madd_n0137_Madd_lut<7>1_622 )
  );
  MUXCY   \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy [7]),
    .DI(N0),
    .S(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_lut_648 ),
    .O(\cpu6502/alu/Madd_n0137_Madd_cy<7>_l1 )
  );
  LUT5 #(
    .INIT ( 32'h00000010 ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_lut  (
    .I0(\cpu6502/alu_operation_sel [2]),
    .I1(\cpu6502/alu_operation_sel [1]),
    .I2(\cpu6502/alu_operation_sel [0]),
    .I3(\cpu6502/alu/dest_reg_sel[2]_PWR_6_o_equal_55_o ),
    .I4(\cpu6502/sreg_operation_sel [1]),
    .O(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_lut_648 )
  );
  MUXCY   \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy1_cy_cy  (
    .CI(\cpu6502/alu/Madd_n0137_Madd_cy<7>_l1 ),
    .DI(N1),
    .S(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy1_cy_lut_650 ),
    .O(\cpu6502/alu/status_op[1]_mem_in[0]_MUX_162_o )
  );
  LUT5 #(
    .INIT ( 32'h2020FF20 ))
  \cpu6502/controller/nmi_active_glue_set  (
    .I0(ph2_falling),
    .I1(nmi_n),
    .I2(\cpu6502/controller/nmi_sample_372 ),
    .I3(\cpu6502/controller/nmi_active_370 ),
    .I4(\cpu6502/controller/ph2_rising_nmi_recognized_AND_11_o ),
    .O(\cpu6502/controller/nmi_active_glue_set_620 )
  );
  LUT5 #(
    .INIT ( 32'h5556559A ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<0>  (
    .I0(\cpu6502/addr_gen/addr1_reg [0]),
    .I1(\cpu6502/index_reg_sel ),
    .I2(\cpu6502/alu/x_reg [0]),
    .I3(\cpu6502/controller/addr_ctrl_signals [2]),
    .I4(\cpu6502/alu/y_reg [0]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<0>_253 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<1>  (
    .I0(\cpu6502/addr_gen/addr1_reg [1]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [1]),
    .I4(\cpu6502/alu/y_reg [1]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<1>_251 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<2>  (
    .I0(\cpu6502/addr_gen/addr1_reg [2]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [2]),
    .I4(\cpu6502/alu/y_reg [2]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<2>_249 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<3>  (
    .I0(\cpu6502/addr_gen/addr1_reg [3]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [3]),
    .I4(\cpu6502/alu/y_reg [3]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<3>_247 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<4>  (
    .I0(\cpu6502/addr_gen/addr1_reg [4]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [4]),
    .I4(\cpu6502/alu/y_reg [4]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<4>_245 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<5>  (
    .I0(\cpu6502/addr_gen/addr1_reg [5]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [5]),
    .I4(\cpu6502/alu/y_reg [5]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<5>_243 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<6>  (
    .I0(\cpu6502/addr_gen/addr1_reg [6]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [6]),
    .I4(\cpu6502/alu/y_reg [6]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<6>_241 )
  );
  LUT5 #(
    .INIT ( 32'h999AA9AA ))
  \cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<7>  (
    .I0(\cpu6502/addr_gen/addr1_reg [7]),
    .I1(\cpu6502/controller/addr_ctrl_signals [2]),
    .I2(\cpu6502/index_reg_sel ),
    .I3(\cpu6502/alu/x_reg [7]),
    .I4(\cpu6502/alu/y_reg [7]),
    .O(\cpu6502/addr_gen/Madd_addr1_reg[7]_addr1_value_to_add[7]_add_2_OUT_lut<7>_239 )
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<5>  (
    .I0(\cpu6502/pc/pc [5]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [5]),
    .O(\cpu6502/pc/Madd_n0067_lut [5])
  );
  LUT6 #(
    .INIT ( 64'h2A2AEA2AEA2A2A2A ))
  \cpu6502/controller/current_state_FSM_FFd7-In1  (
    .I0(\cpu6502/controller/current_state_FSM_FFd7_301 ),
    .I1(ph2_rising),
    .I2(\cpu6502/controller/set_next_state_127 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .I4(\cpu6502/pc/Madd_n0067_cy [7]),
    .I5(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/controller/current_state_FSM_FFd7-In )
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<6>  (
    .I0(\cpu6502/pc/pc [6]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [6]),
    .O(\cpu6502/pc/Madd_n0067_lut [6])
  );
  LUT4 #(
    .INIT ( 16'h8AAA ))
  \cpu6502/controller/rst_active_glue_rst  (
    .I0(\cpu6502/controller/rst_active_389 ),
    .I1(rst),
    .I2(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I3(ph2_rising),
    .O(\cpu6502/controller/rst_active_glue_rst_621 )
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_n0067_lut<7>  (
    .I0(\cpu6502/pc/pc [7]),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_n0067_lut [7])
  );
  LUT4 #(
    .INIT ( 16'h0800 ))
  \cpu6502/alu/Mmux_z_flag_mem_in[1]_MUX_166_o1_SW0_SW1  (
    .I0(\cpu6502/alu_dest_reg_sel [0]),
    .I1(\cpu6502/alu_dest_reg_sel [2]),
    .I2(\cpu6502/alu_dest_reg_sel [1]),
    .I3(\cpu6502/mem_din_reg [1]),
    .O(N101)
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<0>  (
    .I0(\cpu6502/pc/pc_8_119 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [0])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<1>  (
    .I0(\cpu6502/pc/pc_9_120 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [1])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<2>  (
    .I0(\cpu6502/pc/pc_10_121 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [2])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<3>  (
    .I0(\cpu6502/pc/pc_11_122 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [3])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<4>  (
    .I0(\cpu6502/pc/pc_12_123 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [4])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<5>  (
    .I0(\cpu6502/pc/pc_13_124 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [5])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<6>  (
    .I0(\cpu6502/pc/pc_14_125 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [6])
  );
  LUT4 #(
    .INIT ( 16'h8880 ))
  \cpu6502/alu/_n0199_inv_SW0  (
    .I0(ph2_falling),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(\cpu6502/controller/stack_ctrl_signals [2]),
    .I3(\cpu6502/controller/alu_enable_131 ),
    .O(N42)
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut<7>  (
    .I0(\cpu6502/pc/pc_15_126 ),
    .I1(\cpu6502/controller/pc_operation [0]),
    .I2(\cpu6502/mem_din_reg [7]),
    .O(\cpu6502/pc/Madd_incremented_pc_value_h_Madd_lut [7])
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>1  (
    .I0(\cpu6502/pc/pc_9_120 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/z_flag_82 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>1_559 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>2  (
    .I0(\cpu6502/pc/pc [1]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [1]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<1>2_560 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>1  (
    .I0(\cpu6502/pc/pc_10_121 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/i_flag_83 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>1_561 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>2  (
    .I0(\cpu6502/pc/pc [2]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [2]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<2>2_562 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>1  (
    .I0(\cpu6502/pc/pc_11_122 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/d_flag_84 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>1_563 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>2  (
    .I0(\cpu6502/pc/pc [3]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [3]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<3>2_564 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>1  (
    .I0(\cpu6502/pc/pc_12_123 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/controller/b_flag_value_128 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>1_565 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>2  (
    .I0(\cpu6502/pc/pc [4]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [4]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<4>2_566 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>1  (
    .I0(\cpu6502/pc/pc_14_125 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/v_flag_85 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>1_567 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>2  (
    .I0(\cpu6502/pc/pc [6]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [6]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<6>2_568 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>1  (
    .I0(\cpu6502/pc/pc_15_126 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/n_flag_86 ),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>1_569 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>2  (
    .I0(\cpu6502/pc/pc [7]),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/alu/result_reg [7]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<7>2_570 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAAAA88A8 ))
  \cpu6502/controller/Reset_OR_DriverANDClockEnable21  (
    .I0(ph1_falling),
    .I1(\cpu6502/controller/nmi_active_370 ),
    .I2(\cpu6502/controller/int_active_371 ),
    .I3(\cpu6502/alu/i_flag_83 ),
    .I4(\cpu6502/controller/rst_active_389 ),
    .I5(rst),
    .O(\cpu6502/controller/Reset_OR_DriverANDClockEnable2 )
  );
  LUT5 #(
    .INIT ( 32'h88888880 ))
  \cpu6502/addr_gen/_n0086_inv1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/addr_ctrl_signals [7]),
    .I3(\cpu6502/controller/addr_ctrl_signals [5]),
    .I4(\cpu6502/controller/addr_ctrl_signals [0]),
    .O(\cpu6502/addr_gen/_n0086_inv )
  );
  LUT5 #(
    .INIT ( 32'h88888880 ))
  \cpu6502/addr_gen/_n0094_inv1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/addr_ctrl_signals [7]),
    .I3(\cpu6502/controller/addr_ctrl_signals [6]),
    .I4(\cpu6502/controller/addr_ctrl_signals [0]),
    .O(\cpu6502/addr_gen/_n0094_inv )
  );
  LUT5 #(
    .INIT ( 32'h88888880 ))
  \cpu6502/addr_gen/_n0080_inv1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/addr_ctrl_signals [5]),
    .I3(\cpu6502/controller/addr_ctrl_signals [4]),
    .I4(\cpu6502/controller/addr_ctrl_signals [0]),
    .O(\cpu6502/addr_gen/_n0080_inv )
  );
  LUT6 #(
    .INIT ( 64'h8888888888888880 ))
  \cpu6502/addr_gen/_n0102_inv1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/addr_ctrl_signals [3]),
    .I3(\cpu6502/controller/addr_ctrl_signals [2]),
    .I4(\cpu6502/controller/addr_ctrl_signals [1]),
    .I5(\cpu6502/controller/addr_ctrl_signals [0]),
    .O(\cpu6502/addr_gen/_n0102_inv )
  );
  LUT4 #(
    .INIT ( 16'h0800 ))
  \cpu6502/pc/pc_enable_GND_5_o_AND_67_o1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/no_pcl_carry_reg_145 ),
    .I3(\cpu6502/controller/pc_operation [3]),
    .O(\cpu6502/pc/pc_enable_GND_5_o_AND_67_o )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(ph2_falling),
    .I2(\cpu6502/controller/pc_operation [3]),
    .O(\cpu6502/pc/pc_enable_pc_operation[3]_AND_65_o )
  );
  LUT6 #(
    .INIT ( 64'h2000000000000000 ))
  \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o1  (
    .I0(\cpu6502/controller/set_next_state_127 ),
    .I1(\cpu6502/alu_dest_reg_sel [2]),
    .I2(ph2_falling),
    .I3(\cpu6502/controller/alu_enable_131 ),
    .I4(\cpu6502/alu_dest_reg_sel [0]),
    .I5(\cpu6502/alu_dest_reg_sel [1]),
    .O(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_87_o )
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o1  (
    .I0(\cpu6502/alu_dest_reg_sel [0]),
    .I1(\cpu6502/alu_dest_reg_sel [2]),
    .I2(ph2_falling),
    .I3(\cpu6502/controller/alu_enable_131 ),
    .I4(\cpu6502/controller/set_next_state_127 ),
    .I5(\cpu6502/alu_dest_reg_sel [1]),
    .O(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_86_o )
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  \cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o1  (
    .I0(\cpu6502/alu_dest_reg_sel [2]),
    .I1(\cpu6502/alu_dest_reg_sel [1]),
    .I2(ph2_falling),
    .I3(\cpu6502/controller/alu_enable_131 ),
    .I4(\cpu6502/controller/set_next_state_127 ),
    .I5(\cpu6502/alu_dest_reg_sel [0]),
    .O(\cpu6502/alu/alu_enable_dest_reg_sel[2]_AND_85_o )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFF7FFFF ))
  \cpu6502/controller/current_state_FSM_FFd13-In_SW1  (
    .I0(\cpu6502/controller/branch_taken ),
    .I1(\cpu6502/controller/current_state_FSM_FFd24_382 ),
    .I2(\cpu6502/operation_type [1]),
    .I3(\cpu6502/operation_type [0]),
    .I4(\cpu6502/operation_type [2]),
    .I5(\cpu6502/addr_mode [2]),
    .O(N137)
  );
  LUT6 #(
    .INIT ( 64'h2A2A2A2A2A2AEA2A ))
  \cpu6502/controller/current_state_FSM_FFd13-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd13_381 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/addr_mode [0]),
    .I4(\cpu6502/addr_mode [1]),
    .I5(N137),
    .O(\cpu6502/controller/current_state_FSM_FFd13-In_317 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \cpu6502/controller/current_state_FSM_FFd11-In_SW1  (
    .I0(\cpu6502/mem_operation [0]),
    .I1(\cpu6502/mem_operation [1]),
    .O(N139)
  );
  LUT6 #(
    .INIT ( 64'h2AEA2A2A2A2A2A2A ))
  \cpu6502/controller/current_state_FSM_FFd11-In  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/addr_gen/address_carry_165 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd21_304 ),
    .I5(N139),
    .O(\cpu6502/controller/current_state_FSM_FFd11-In_315 )
  );
  LUT6 #(
    .INIT ( 64'hEAEA2AAA2AAA2AAA ))
  \cpu6502/controller/nmi_recognized_glue_set  (
    .I0(\cpu6502/controller/nmi_recognized_369 ),
    .I1(\cpu6502/controller/set_next_state_127 ),
    .I2(ph2_rising),
    .I3(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .I4(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .I5(\cpu6502/controller/nmi_active_370 ),
    .O(\cpu6502/controller/nmi_recognized_glue_set_619 )
  );
  LUT6 #(
    .INIT ( 64'hCC5CCCCCFF5FFFFF ))
  \cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy1_cy_lut  (
    .I0(\cpu6502/mem_din_reg [0]),
    .I1(\cpu6502/sreg_operation_sel [1]),
    .I2(\cpu6502/alu_dest_reg_sel [0]),
    .I3(\cpu6502/alu_dest_reg_sel [1]),
    .I4(\cpu6502/alu_dest_reg_sel [2]),
    .I5(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o1 ),
    .O(\cpu6502/alu/Mmux_status_op[1]_mem_in[0]_MUX_162_o13_cy1_cy_lut_650 )
  );
  MUXF7   \cpu6502/alu/Mmux_alu_negative_3  (
    .I0(N141),
    .I1(N142),
    .S(\cpu6502/alu_operation_sel [1]),
    .O(\cpu6502/alu/Mmux_alu_negative_3_455 )
  );
  LUT6 #(
    .INIT ( 64'h6A656A9AFAFFFA9A ))
  \cpu6502/alu/Mmux_alu_negative_3_F  (
    .I0(\cpu6502/alu_operand2_sel [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/mem_din_reg [7]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N79),
    .I5(\cpu6502/alu_operation_sel [0]),
    .O(N141)
  );
  LUT5 #(
    .INIT ( 32'hEFEA4540 ))
  \cpu6502/alu/Mmux_alu_negative_3_G  (
    .I0(\cpu6502/alu_operation_sel [0]),
    .I1(\cpu6502/mem_din_reg [6]),
    .I2(\cpu6502/alu_operand1_sel [2]),
    .I3(N81),
    .I4(\cpu6502/alu/c_in ),
    .O(N142)
  );
  MUXF7   \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>  (
    .I0(N143),
    .I1(N144),
    .S(\cpu6502/data_out_sel [0]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>_54 )
  );
  LUT6 #(
    .INIT ( 64'h5703560255015400 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>_F  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/pc/pc [5]),
    .I4(\cpu6502/alu/result_reg [5]),
    .I5(\cpu6502/mem_din_reg [5]),
    .O(N143)
  );
  LUT4 #(
    .INIT ( 16'h4445 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<5>_G  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/pc/pc_13_124 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .O(N144)
  );
  MUXF7   \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0>3  (
    .I0(N145),
    .I1(N146),
    .S(\cpu6502/data_out_sel [0]),
    .O(\cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0> )
  );
  LUT6 #(
    .INIT ( 64'h5703560255015400 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0>3_F  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/pc/pc [0]),
    .I4(\cpu6502/alu/result_reg [0]),
    .I5(\cpu6502/mem_din_reg [0]),
    .O(N145)
  );
  LUT5 #(
    .INIT ( 32'h44454440 ))
  \cpu6502/data_out_sel[2]_GND_2_o_wide_mux_12_OUT<0>3_G  (
    .I0(\cpu6502/controller/current_state_FSM_FFd11_148 ),
    .I1(\cpu6502/pc/pc_8_119 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd17_386 ),
    .I3(\cpu6502/controller/current_state_FSM_FFd4_385 ),
    .I4(\cpu6502/alu/c_flag_81 ),
    .O(N146)
  );
  MUXF7   \cpu6502/alu/Mmux_alu_result1_SW5  (
    .I0(N147),
    .I1(N148),
    .S(\cpu6502/alu_operation_sel [1]),
    .O(N116)
  );
  LUT6 #(
    .INIT ( 64'h9AA99A56DEFFDE56 ))
  \cpu6502/alu/Mmux_alu_result1_SW5_F  (
    .I0(\cpu6502/alu_operand2_sel [0]),
    .I1(\cpu6502/mem_din_reg [0]),
    .I2(\cpu6502/alu_operand2_sel [1]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N93),
    .I5(\cpu6502/alu_operation_sel [0]),
    .O(N147)
  );
  LUT5 #(
    .INIT ( 32'hF7D5A280 ))
  \cpu6502/alu/Mmux_alu_result1_SW5_G  (
    .I0(\cpu6502/alu_operation_sel [0]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(\cpu6502/mem_din_reg [1]),
    .I3(N91),
    .I4(\cpu6502/alu/c_in ),
    .O(N148)
  );
  MUXF7   \cpu6502/alu/Mmux_alu_result4_SW5  (
    .I0(N149),
    .I1(N150),
    .S(\cpu6502/alu_operation_sel [1]),
    .O(N104)
  );
  LUT6 #(
    .INIT ( 64'h6A656A9AFAFFFA9A ))
  \cpu6502/alu/Mmux_alu_result4_SW5_F  (
    .I0(\cpu6502/alu_operand2_sel [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/mem_din_reg [3]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N87),
    .I5(\cpu6502/alu_operation_sel [0]),
    .O(N149)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \cpu6502/alu/Mmux_alu_result4_SW5_G  (
    .I0(\cpu6502/alu_operation_sel [0]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N85),
    .I3(\cpu6502/mem_din_reg [4]),
    .I4(\cpu6502/mem_din_reg [2]),
    .I5(N89),
    .O(N150)
  );
  MUXF7   \cpu6502/alu/Mmux_alu_result3_SW5  (
    .I0(N151),
    .I1(N152),
    .S(\cpu6502/alu_operation_sel [1]),
    .O(N108)
  );
  LUT6 #(
    .INIT ( 64'h6A656A9AFAFFFA9A ))
  \cpu6502/alu/Mmux_alu_result3_SW5_F  (
    .I0(\cpu6502/alu_operand2_sel [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/mem_din_reg [2]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N89),
    .I5(\cpu6502/alu_operation_sel [0]),
    .O(N151)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \cpu6502/alu/Mmux_alu_result3_SW5_G  (
    .I0(\cpu6502/alu_operation_sel [0]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N87),
    .I3(\cpu6502/mem_din_reg [3]),
    .I4(\cpu6502/mem_din_reg [1]),
    .I5(N91),
    .O(N152)
  );
  MUXF7   \cpu6502/alu/Mmux_alu_result2_SW5  (
    .I0(N153),
    .I1(N154),
    .S(\cpu6502/alu_operation_sel [1]),
    .O(N112)
  );
  LUT6 #(
    .INIT ( 64'h6A656A9AFAFFFA9A ))
  \cpu6502/alu/Mmux_alu_result2_SW5_F  (
    .I0(\cpu6502/alu_operand2_sel [0]),
    .I1(\cpu6502/alu_operand2_sel [1]),
    .I2(\cpu6502/mem_din_reg [1]),
    .I3(\cpu6502/alu_operand1_sel [2]),
    .I4(N91),
    .I5(\cpu6502/alu_operation_sel [0]),
    .O(N153)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \cpu6502/alu/Mmux_alu_result2_SW5_G  (
    .I0(\cpu6502/alu_operation_sel [0]),
    .I1(\cpu6502/alu_operand1_sel [2]),
    .I2(N89),
    .I3(\cpu6502/mem_din_reg [2]),
    .I4(\cpu6502/mem_din_reg [0]),
    .I5(N93),
    .O(N154)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/addr_gen/address_carry_rstpot  (
    .I0(\cpu6502/addr_gen/_n0086_inv ),
    .I1(\cpu6502/addr_gen/address_carry_165 ),
    .I2(\cpu6502/addr_gen/address_carry_GND_7_o_MUX_198_o ),
    .O(\cpu6502/addr_gen/address_carry_rstpot_667 )
  );
  FDR   \cpu6502/addr_gen/address_carry  (
    .C(clk),
    .D(\cpu6502/addr_gen/address_carry_rstpot_667 ),
    .R(rst),
    .Q(\cpu6502/addr_gen/address_carry_165 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/controller/set_i_flag_rstpot  (
    .I0(\cpu6502/controller/ph1_falling_set_next_state_AND_61_o ),
    .I1(\cpu6502/controller/set_i_flag_129 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd3_384 ),
    .O(\cpu6502/controller/set_i_flag_rstpot_668 )
  );
  FDR   \cpu6502/controller/set_i_flag  (
    .C(clk),
    .D(\cpu6502/controller/set_i_flag_rstpot_668 ),
    .R(\cpu6502/controller/rst_set_i_flag_OR_110_o ),
    .Q(\cpu6502/controller/set_i_flag_129 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/controller/inst_reg_we_rstpot  (
    .I0(ph1_falling),
    .I1(\cpu6502/controller/inst_reg_we_143 ),
    .I2(\cpu6502/controller/current_state_FSM_FFd25_383 ),
    .O(\cpu6502/controller/inst_reg_we_rstpot_669 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/controller/inst_reg_clr_rstpot  (
    .I0(ph1_falling),
    .I1(\cpu6502/controller/inst_reg_clr_144 ),
    .I2(\cpu6502/controller/is_interrupt ),
    .O(\cpu6502/controller/inst_reg_clr_rstpot_670 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/controller/no_pcl_carry_reg_rstpot  (
    .I0(ph1_falling),
    .I1(\cpu6502/controller/no_pcl_carry_reg_145 ),
    .I2(\cpu6502/controller/operation_type[2]_PWR_4_o_equal_90_o ),
    .O(\cpu6502/controller/no_pcl_carry_reg_rstpot_671 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/alu/c_flag_rstpot  (
    .I0(\cpu6502/alu/_n0221_inv ),
    .I1(\cpu6502/alu/c_flag_81 ),
    .I2(\cpu6502/alu/status_op[1]_mem_in[0]_MUX_162_o ),
    .O(\cpu6502/alu/c_flag_rstpot_672 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \cpu6502/alu/c_flag  (
    .C(clk),
    .D(\cpu6502/alu/c_flag_rstpot_672 ),
    .R(rst),
    .Q(\cpu6502/alu/c_flag_81 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/alu/i_flag_rstpot  (
    .I0(\cpu6502/alu_en ),
    .I1(\cpu6502/alu/i_flag_83 ),
    .I2(\cpu6502/alu/status_op[1]_mem_in[2]_MUX_171_o ),
    .O(\cpu6502/alu/i_flag_rstpot_673 )
  );
  FDS #(
    .INIT ( 1'b1 ))
  \cpu6502/alu/i_flag  (
    .C(clk),
    .D(\cpu6502/alu/i_flag_rstpot_673 ),
    .S(\cpu6502/controller/rst_set_i_flag_OR_110_o ),
    .Q(\cpu6502/alu/i_flag_83 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \cpu6502/controller/b_flag_value_rstpot  (
    .I0(ph1_rising),
    .I1(\cpu6502/controller/b_flag_value_128 ),
    .I2(\cpu6502/controller/current_state[4]_operation_type[2]_Select_182_o ),
    .O(\cpu6502/controller/b_flag_value_rstpot_674 )
  );
  FD   \cpu6502/controller/b_flag_value  (
    .C(clk),
    .D(\cpu6502/controller/b_flag_value_rstpot_674 ),
    .Q(\cpu6502/controller/b_flag_value_128 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \cpu6502/controller/inst_reg_we_rstpot1  (
    .I0(\cpu6502/controller/inst_reg_we_rstpot_669 ),
    .I1(\cpu6502/controller/Reset_OR_DriverANDClockEnable2 ),
    .O(\cpu6502/controller/inst_reg_we_rstpot1_675 )
  );
  FD   \cpu6502/controller/inst_reg_we  (
    .C(clk),
    .D(\cpu6502/controller/inst_reg_we_rstpot1_675 ),
    .Q(\cpu6502/controller/inst_reg_we_143 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \cpu6502/controller/inst_reg_clr_rstpot1  (
    .I0(\cpu6502/controller/inst_reg_clr_rstpot_670 ),
    .I1(\cpu6502/controller/Reset_OR_DriverANDClockEnable1_336 ),
    .O(\cpu6502/controller/inst_reg_clr_rstpot1_676 )
  );
  FD   \cpu6502/controller/inst_reg_clr  (
    .C(clk),
    .D(\cpu6502/controller/inst_reg_clr_rstpot1_676 ),
    .Q(\cpu6502/controller/inst_reg_clr_144 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \cpu6502/controller/no_pcl_carry_reg_rstpot1  (
    .I0(\cpu6502/controller/no_pcl_carry_reg_rstpot_671 ),
    .I1(\cpu6502/controller/Reset_OR_DriverANDClockEnable ),
    .O(\cpu6502/controller/no_pcl_carry_reg_rstpot1_677 )
  );
  FD   \cpu6502/controller/no_pcl_carry_reg  (
    .C(clk),
    .D(\cpu6502/controller/no_pcl_carry_reg_rstpot1_677 ),
    .Q(\cpu6502/controller/no_pcl_carry_reg_145 )
  );
  INV   \cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT111_INV_0  (
    .I(\cpu6502/controller/rst_active_389 ),
    .O(\cpu6502/controller/Mram_rst_active_PWR_4_o_wide_mux_92_OUT1 )
  );
  INV   \cpu6502/controller/int_n_INV_5_o1_INV_0  (
    .I(int_n),
    .O(\cpu6502/controller/int_n_INV_5_o )
  );
  INV   \cpu6502_decoder/_n0040_0_inv_INV_0  (
    .I(\cpu6502/decoder/_n0040_0 ),
    .O(\cpu6502_decoder/_n0040_0_inv )
  );
  RAMB16BWER #(
    .INIT_00 ( 256'h0000000023068833220C0013000000000000000000000000220C001600000060 ),
    .INIT_01 ( 256'h0000000023068832220C00120000000000000000230E8000220C0001800000A0 ),
    .INIT_02 ( 256'h0000000023068835220C0015000000000000000000000000220C001F20C00121 ),
    .INIT_03 ( 256'h0000000023068834220C0014000000000000000000000000220C001C01800000 ),
    .INIT_04 ( 256'h0000000023060833220A0013320300130000000000000000220A001600000162 ),
    .INIT_05 ( 256'h0000000023060832220A00123203001200000000230E0000220A0001002808D0 ),
    .INIT_06 ( 256'h0000000023060835220A0015000000000000000000000000220A001F60C00121 ),
    .INIT_07 ( 256'h0000000023060834220A0014000000000000000000000000220A001C01400000 ),
    .INIT_08 ( 256'h0000000023078833220D0013000000000000000000000000220D0016002809E0 ),
    .INIT_09 ( 256'h0000000023078832220D00120000012200000000230F8000220D0001000000A0 ),
    .INIT_0A ( 256'h0000000023078835220D0015000000000000000000000000220D001F10C00121 ),
    .INIT_0B ( 256'h0000000023078834220D0014000000000000000000000000220D001C04800000 ),
    .INIT_0C ( 256'h00000000230708333309001300000000000000000000000033090016000001A0 ),
    .INIT_0D ( 256'h0000000023070832330900120000012600000000230F000033090001220808D0 ),
    .INIT_0E ( 256'h0000000023070835330900150000000000000000000000003309001F50C00121 ),
    .INIT_0F ( 256'h0000000023070834330900140000000000000000000000003309001C04400000 ),
    .INIT_10 ( 256'h0000000000000423000000230000062300000000000000000000002600000000 ),
    .INIT_11 ( 256'h000000000000042200000022000006220000000022080400000000002219F600 ),
    .INIT_12 ( 256'h000000000000042D000000250000062500000000000000000000002F01C00121 ),
    .INIT_13 ( 256'h0000000000000000000000240000000000000000002004000000002C22080600 ),
    .INIT_14 ( 256'h0000000022100813220808132218081300000000221008012208081622180801 ),
    .INIT_15 ( 256'h0000000022100812220808122218081200000000221000002208080122180000 ),
    .INIT_16 ( 256'h000000002210081D220808152218081500000000000000002208081F41C00121 ),
    .INIT_17 ( 256'h000000002210081C220808142218081400000000221002002208081C10800000 ),
    .INIT_18 ( 256'h000000002201F8332301D0132301D61300000000000000002301D0162301D601 ),
    .INIT_19 ( 256'h000000002201F8322301D0122301D612000000002211F4002301D0012219A600 ),
    .INIT_1A ( 256'h000000002201F8352301D0150000000000000000000000002301D01F02C00121 ),
    .INIT_1B ( 256'h000000002201F8342301D0140000000000000000000000002301D01C08800000 ),
    .INIT_1C ( 256'h000000002201A833330910132301D4130000000000000000330910162301D401 ),
    .INIT_1D ( 256'h000000002201A832330910122301D4120000000000000000330910012211A400 ),
    .INIT_1E ( 256'h000000002201A835330910150000000000000000000000003309101F42C00121 ),
    .INIT_1F ( 256'h000000002201A834330910140000000000000000000000003309101C08400000 ),
    .SRVAL_A ( 36'h000000000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .DATA_WIDTH_A ( 36 ),
    .DATA_WIDTH_B ( 0 ),
    .DOA_REG ( 0 ),
    .DOB_REG ( 0 ),
    .EN_RSTRAM_A ( "TRUE" ),
    .EN_RSTRAM_B ( "TRUE" ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_20 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_21 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_22 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_23 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_24 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_25 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_26 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_27 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_28 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_29 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_30 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_31 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_32 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_33 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_34 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_35 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_36 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_37 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_38 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_39 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_A ( 36'h000000000 ),
    .INIT_B ( 36'h000000000 ),
    .RST_PRIORITY_A ( "CE" ),
    .RST_PRIORITY_B ( "CE" ),
    .RSTTYPE ( "SYNC" ),
    .SRVAL_B ( 36'h000000000 ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .SIM_COLLISION_CHECK ( "ALL" ),
    .SIM_DEVICE ( "SPARTAN6" ),
    .INIT_FILE ( "NONE" ))
  \cpu6502_decoder/Mram_instr_decoder_rom  (
    .REGCEA(N0),
    .CLKA(clk),
    .ENB(\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ENB_UNCONNECTED ),
    .RSTB(\NLW_cpu6502_decoder/Mram_instr_decoder_rom_RSTB_UNCONNECTED ),
    .CLKB(\NLW_cpu6502_decoder/Mram_instr_decoder_rom_CLKB_UNCONNECTED ),
    .REGCEB(\NLW_cpu6502_decoder/Mram_instr_decoder_rom_REGCEB_UNCONNECTED ),
    .RSTA(\cpu6502/decoder/_n0035 ),
    .ENA(\cpu6502_decoder/_n0040_0_inv ),
    .DIPA({N0, N0, N0, N0}),
    .WEA({N0, N0, N0, N0}),
    .DOA({\cpu6502/sreg_to_dout , \cpu6502/branch_flag_val , \cpu6502/sreg_mask [5], \cpu6502/sreg_mask [4], \cpu6502/sreg_mask [3], 
\cpu6502/sreg_mask [2], \cpu6502/sreg_mask [1], \cpu6502/sreg_mask [0], \cpu6502/sreg_operation_sel [1], \cpu6502/sreg_operation_sel [0], 
\cpu6502/alu_dest_reg_sel [2], \cpu6502/alu_dest_reg_sel [1], \cpu6502/alu_dest_reg_sel [0], \cpu6502/alu_operation_sel [2], 
\cpu6502/alu_operation_sel [1], \cpu6502/alu_operation_sel [0], \cpu6502/alu_cin_sel [1], \cpu6502/alu_cin_sel [0], \cpu6502/alu_operand2_sel [1], 
\cpu6502/alu_operand2_sel [0], \cpu6502/alu_operand1_sel [2], \cpu6502/alu_operand1_sel [1], \cpu6502/alu_operand1_sel [0], 
\cpu6502/operation_type [2], \cpu6502/operation_type [1], \cpu6502/operation_type [0], \cpu6502/mem_operation [1], \cpu6502/mem_operation [0], 
\cpu6502/index_reg_sel , \cpu6502/addr_mode [2], \cpu6502/addr_mode [1], \cpu6502/addr_mode [0]}),
    .ADDRA({N0, mst_mem_din[7], mst_mem_din[6], mst_mem_din[5], mst_mem_din[4], mst_mem_din[3], mst_mem_din[2], mst_mem_din[1], mst_mem_din[0], 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<4>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<3>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<2>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<1>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRA<0>_UNCONNECTED }),
    .ADDRB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<13>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<12>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<11>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<10>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<9>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<8>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<7>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<6>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<5>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<4>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_ADDRB<0>_UNCONNECTED }),
    .DIB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<31>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<30>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<29>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<28>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<27>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<26>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<25>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<24>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<23>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<22>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<21>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<20>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<19>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<18>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<17>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<16>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<15>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<14>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<13>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<12>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<11>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<10>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<9>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<8>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<7>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<6>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<5>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<4>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIB<0>_UNCONNECTED }),
    .DOPA({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPA<0>_UNCONNECTED }),
    .DIPB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DIPB<0>_UNCONNECTED }),
    .DOPB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOPB<0>_UNCONNECTED }),
    .DOB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<31>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<30>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<29>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<28>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<27>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<26>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<25>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<24>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<23>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<22>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<21>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<20>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<19>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<18>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<17>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<16>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<15>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<14>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<13>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<12>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<11>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<10>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<9>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<8>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<7>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<6>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<5>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<4>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_DOB<0>_UNCONNECTED }),
    .WEB({\NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<3>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<2>_UNCONNECTED , 
\NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<1>_UNCONNECTED , \NLW_cpu6502_decoder/Mram_instr_decoder_rom_WEB<0>_UNCONNECTED }),
    .DIA({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0})
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

