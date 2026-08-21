-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Sun Aug 16 17:19:41 2026
-- Host        : freak5ter running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/aditya/Documents/ZUB/AES_SV/vivado_ws/AES_SV.gen/sources_1/bd/aes_128_bd/ip/aes_128_bd_aes_128_top_0_0/aes_128_bd_aes_128_top_0_0_stub.vhdl
-- Design      : aes_128_bd_aes_128_top_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu1cg-sbva484-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aes_128_bd_aes_128_top_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    aes_ctrl : in STD_LOGIC_VECTOR ( 1 downto 0 );
    key_in_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    key_in_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    key_in_2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    key_in_3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    text_in_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    text_in_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    text_in_2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    text_in_3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    text_out_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    text_out_1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    text_out_2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    text_out_3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    event_flags : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of aes_128_bd_aes_128_top_0_0 : entity is "aes_128_bd_aes_128_top_0_0,aes_128_top,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of aes_128_bd_aes_128_top_0_0 : entity is "aes_128_bd_aes_128_top_0_0,aes_128_top,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=aes_128_top,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of aes_128_bd_aes_128_top_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of aes_128_bd_aes_128_top_0_0 : entity is "module_ref";
end aes_128_bd_aes_128_top_0_0;

architecture stub of aes_128_bd_aes_128_top_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk,aes_ctrl[1:0],key_in_0[31:0],key_in_1[31:0],key_in_2[31:0],key_in_3[31:0],text_in_0[31:0],text_in_1[31:0],text_in_2[31:0],text_in_3[31:0],text_out_0[31:0],text_out_1[31:0],text_out_2[31:0],text_out_3[31:0],event_flags[1:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN aes_128_bd_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "aes_128_top,Vivado 2024.2";
begin
end;
