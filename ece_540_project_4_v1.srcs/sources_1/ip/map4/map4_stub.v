// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2.1 (win64) Build 2288692 Thu Jul 26 18:24:02 MDT 2018
// Date        : Tue Dec  3 06:03:20 2019
// Host        : caplab12 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map4/map4_stub.v
// Design      : map4
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2.1" *)
module map4(clka, ena, addra, douta, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[13:0],douta[1:0],clkb,enb,addrb[13:0],doutb[1:0]" */;
  input clka;
  input ena;
  input [13:0]addra;
  output [1:0]douta;
  input clkb;
  input enb;
  input [13:0]addrb;
  output [1:0]doutb;
endmodule
