//
///////////////////////////////////////////////////////////////////////////////////////////
// Copyright � 2010-2013, Xilinx, Inc.
// This file contains confidential and proprietary information of Xilinx, Inc. and is
// protected under U.S. and international copyright and other intellectual property laws.
///////////////////////////////////////////////////////////////////////////////////////////
//
// Disclaimer:
// This disclaimer is not a license and does not grant any rights to the materials
// distributed herewith. Except as otherwise provided in a valid license issued to
// you by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE
// MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY
// DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
// INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,
// OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable
// (whether in contract or tort, including negligence, or under any other theory
// of liability) for any loss or damage of any kind or nature related to, arising
// under or in connection with these materials, including for any direct, or any
// indirect, special, incidental, or consequential loss or damage (including loss
// of data, profits, goodwill, or any type of loss or damage suffered as a result
// of any action brought by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-safe, or for use in any
// application requiring fail-safe performance, such as life-support or safety
// devices or systems, Class III medical devices, nuclear facilities, applications
// related to the deployment of airbags, or any other applications that could lead
// to death, personal injury, or severe property or environmental damage
// (individually and collectively, "Critical Applications"). Customer assumes the
// sole risk and liability of any use of Xilinx products in Critical Applications,
// subject only to applicable laws and regulations governing limitations on product
// liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
// Production definition of a 1K program for KCPSM6 in a 7-Series device using a 
// RAMB18E1 primitive.
//
// Note: The complete 12-bit address bus is connected to KCPSM6 to facilitate future code 
//       expansion with minimum changes being required to the hardware description. 
//       Only the lower 10-bits of the address are actually used for the 1K address range
//       000 to 3FF hex.  
//
// Program defined by '\\thoth.cecs.pdx.edu\Home06\ksaranya\Downloads\KCPSM6_Release9_30Sept14\compiler\bot31_pgm.psm'.
//
// Generated by KCPSM6 Assembler: 19 Nov 2019 - 14:44:21. 
//
// Assembler used ROM_form template: ROM_form_7S_1K_14March13.v
//
//
module bot31_pgm2 (
input  [11:0] address,
output [17:0] instruction,
input         enable,
input         clk);
//
//
wire [13:0] address_a;
wire [17:0] data_in_a;
wire [17:0] data_out_a;
wire [13:0] address_b;
wire [17:0] data_in_b;
wire [17:0] data_out_b;
wire        enable_b;
wire        clk_b;
wire [3:0]  we_b;
//
//
assign address_a = {address[9:0], 4'b1111};
assign instruction = data_out_a[17:0];
assign data_in_a = {16'h0000, address[11:10]};
//
assign address_b = 14'b11111111111111;
assign data_in_b = data_out_b[17:0];
assign enable_b = 1'b0;
assign we_b = 4'h0;
assign clk_b = 1'b0;
//
// 
RAMB18E1 # ( .READ_WIDTH_A              (18),
             .WRITE_WIDTH_A             (18),
             .DOA_REG                   (0),
             .INIT_A                    (16'b000000000000000000),
             .RSTREG_PRIORITY_A         ("REGCE"),
             .SRVAL_A                   (36'h000000000000000000),
             .WRITE_MODE_A              ("WRITE_FIRST"),
             .READ_WIDTH_B              (18),
             .WRITE_WIDTH_B             (18),
             .DOB_REG                   (0),
             .INIT_B                    (36'h000000000000000000),
             .RSTREG_PRIORITY_B         ("REGCE"),
             .SRVAL_B                   (36'h000000000000000000),
             .WRITE_MODE_B              ("WRITE_FIRST"),
             .INIT_FILE                 ("NONE"),
             .SIM_COLLISION_CHECK       ("ALL"),
             .RAM_MODE                  ("TDP"),
             .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
             .SIM_DEVICE                ("7SERIES"),
             .INIT_00                   (256'h01A09007003901B3002A1C201D201E001F0200B8006C004E2004200420042004),
             .INIT_01                   (256'h008A02E001F02028E01DC800D031E01DC900B030002A00390E00006701B99000),
             .INIT_02                   (256'h0A0001970B00010C02C001D0200E01EA180019000C100D0000DA02E001F00F00),
             .INIT_03                   (256'h400E00105000D00DD00DD806D9055000D00ED00ED00CD00CDA03DB04DC02DD01),
             .INIT_04                   (256'h110010205000A02002105000300F5000400E400E400E400EE049410EA0200200),
             .INIT_05                   (256'hE10011EE1001E10011CC1001E10011CE1001E10011CE1001E10011001001E100),
             .INIT_06                   (256'h1001E100111710005000003E1220310F01005000E100114F1001E10011D81001),
             .INIT_07                   (256'h11751001E10011641001E10011531001E10011421001E10011311001E1001120),
             .INIT_08                   (256'h20B700406090D500052004105000003E1200013041065000E10011061001E100),
             .INIT_09                   (256'h60A7D50D20B7008513000140609ED50C20B700406098D50820B700406094D504),
             .INIT_0A                   (256'h014060B6D50F20B700851301014060ADD50E20B7008513000100008513000140),
             .INIT_0B                   (256'h11101001E100111F1001E100110F10105000004020B700851301010000851301),
             .INIT_0C                   (256'hE10011FF1001E10011F01001E10011F11001E10011011001E10011111001E100),
             .INIT_0D                   (256'hD40400D107C006D0051004205000400E400E400E400E310F0100004B12105000),
             .INIT_0E                   (256'h60F2D00F60F9D40820FC071020FC970160EAD10F060020E6960160E5D00F60EC),
             .INIT_0F                   (256'hD00201070270016050000170006020FC871020FC170160F7D10F860020F31601),
             .INIT_10                   (256'h0700010702C001D05000900A0000D209D108500001700060500001C000D06104),
             .INIT_11                   (256'h612CDF01500001820600010711010500010711010400010792019101611EDF00),
             .INIT_12                   (256'h92011101613ADF02500001820600010711010500010712010400010792021101),
             .INIT_13                   (256'h04000107120111026148DF035000018206000107120105000107120104000107),
             .INIT_14                   (256'h0107910104000107120111016156DF0450000182060001071201050001079101),
             .INIT_15                   (256'h910105000107920104000107120291016164DF05500001820600010791010500),
             .INIT_16                   (256'h06000107920105000107920104000107120191016172DF065000018206000107),
             .INIT_17                   (256'h5000018206000107920105000107110104000107920191026180DF0750000182),
             .INIT_18                   (256'h50186190D50230F8618DD70150074006400640064006400640060070500010FF),
             .INIT_19                   (256'h50004010310701F0400640064006400600E0500050086196D60250106193D402),
             .INIT_1A                   (256'h311F0100F1321107F1331101D000400EF1311105F1301105F1321101F1331100),
             .INIT_1B                   (256'h420E420E420E420E0200310F010050000A0001971B00180019005000F131F130),
             .INIT_1C                   (256'h504008100120E1CEC12021D0D10022302130B332400E400E4008420E4008410E),
             .INIT_1D                   (256'h500061DD900110185000400E400E400E400E508009200210E1D5C21021D7D200),
             .INIT_1E                   (256'h1364500061EB930101E51332500061E6920101E01219500061E1910101DC1128),
             .INIT_1F                   (256'h0330130A500061FA940101F41405500061F5930101E513C8500061F0930101E5),
             .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000500061FF9301),
             .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_30                   (256'hD90598049902D00CD00CDC02DD014C060CD01D01D004900018FF19FF1C001D00),
             .INIT_31                   (256'h0000000000000000000000000000000000002304D00ED00E01F4D00DD00DD806),
             .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INITP_00                  (256'h1861861860A0286186186186086255D14AAAAAAA220A008082D74A288A802AAA),
             .INITP_01                  (256'h60826759DD99D677600954228618618618608A0836836820DA0D8D8D8D0A1686),
             .INITP_02                  (256'hA24925DA24925DA24925DA24925DA24925DA24925DA24925DA24925D2082A083),
             .INITP_03                  (256'h0B62D8B62D8B62D8B49544DD137405555502202A088D88888055234D34D15548),
             .INITP_04                  (256'h000000000000000000000000000000000000000000000000000000000000002D),
             .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
             .INITP_06                  (256'h00000000000000000000000000000000000000000000000000002AAA96A91800),
             .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
 kcpsm6_rom( .ADDRARDADDR               (address_a),
             .ENARDEN                   (enable),
             .CLKARDCLK                 (clk),
             .DOADO                     (data_out_a[15:0]),
             .DOPADOP                   (data_out_a[17:16]), 
             .DIADI                     (data_in_a[15:0]),
             .DIPADIP                   (data_in_a[17:16]), 
             .WEA                       (2'b00),
             .REGCEAREGCE               (1'b0),
             .RSTRAMARSTRAM             (1'b0),
             .RSTREGARSTREG             (1'b0),
             .ADDRBWRADDR               (address_b),
             .ENBWREN                   (enable_b),
             .CLKBWRCLK                 (clk_b),
             .DOBDO                     (data_out_b[15:0]),
             .DOPBDOP                   (data_out_b[17:16]), 
             .DIBDI                     (data_in_b[15:0]),
             .DIPBDIP                   (data_in_b[17:16]), 
             .WEBWE                     (we_b),
             .REGCEB                    (1'b0),
             .RSTRAMB                   (1'b0),
             .RSTREGB                   (1'b0));
//
//
endmodule
//
////////////////////////////////////////////////////////////////////////////////////
//
// END OF FILE bot31_pgm.v
//
////////////////////////////////////////////////////////////////////////////////////
