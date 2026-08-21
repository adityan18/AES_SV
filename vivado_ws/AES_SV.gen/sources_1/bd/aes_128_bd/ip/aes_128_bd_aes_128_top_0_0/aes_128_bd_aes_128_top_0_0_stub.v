// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Sun Aug 16 17:19:41 2026
// Host        : freak5ter running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aditya/Documents/ZUB/AES_SV/vivado_ws/AES_SV.gen/sources_1/bd/aes_128_bd/ip/aes_128_bd_aes_128_top_0_0/aes_128_bd_aes_128_top_0_0_stub.v
// Design      : aes_128_bd_aes_128_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu1cg-sbva484-1-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "aes_128_bd_aes_128_top_0_0,aes_128_top,{}" *) (* CORE_GENERATION_INFO = "aes_128_bd_aes_128_top_0_0,aes_128_top,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=aes_128_top,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "aes_128_top,Vivado 2024.2" *) 
module aes_128_bd_aes_128_top_0_0(clk, aes_ctrl, key_in_0, key_in_1, key_in_2, 
  key_in_3, text_in_0, text_in_1, text_in_2, text_in_3, text_out_0, text_out_1, text_out_2, 
  text_out_3, event_flags)
/* synthesis syn_black_box black_box_pad_pin="aes_ctrl[1:0],key_in_0[31:0],key_in_1[31:0],key_in_2[31:0],key_in_3[31:0],text_in_0[31:0],text_in_1[31:0],text_in_2[31:0],text_in_3[31:0],text_out_0[31:0],text_out_1[31:0],text_out_2[31:0],text_out_3[31:0],event_flags[1:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN aes_128_bd_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  input [1:0]aes_ctrl;
  input [31:0]key_in_0;
  input [31:0]key_in_1;
  input [31:0]key_in_2;
  input [31:0]key_in_3;
  input [31:0]text_in_0;
  input [31:0]text_in_1;
  input [31:0]text_in_2;
  input [31:0]text_in_3;
  output [31:0]text_out_0;
  output [31:0]text_out_1;
  output [31:0]text_out_2;
  output [31:0]text_out_3;
  output [1:0]event_flags;
endmodule
