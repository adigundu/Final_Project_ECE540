// mfp_ahb.v
// 
// January 1, 2017
//
// AHB-lite bus module with 3 slaves: boot RAM, program RAM, and
// GPIO (memory-mapped I/O: switches and LEDs from the FPGA board).
// The module includes an address decoder and multiplexer (for 
// selecting which slave module produces HRDATA).

`include "mfp_ahb_const.vh"


module mfp_ahb
(
    input                       HCLK,
    input                       HRESETn,
    input      [ 31         :0] HADDR,
    input      [  2         :0] HBURST,
    input                       HMASTLOCK,
    input      [  3         :0] HPROT,
    input      [  2         :0] HSIZE,
    input      [  1         :0] HTRANS,
    input      [ 31         :0] HWDATA,
    input                       HWRITE,
    output     [ 31         :0] HRDATA,
    output                      HREADY,
    output                      HRESP,
    input                       SI_Endian,

// memory-mapped I/O
    input      [`MFP_N_SW-1 :0] IO_Switch,
    input      [`MFP_N_PB-1 :0] IO_PB,
    output     [`MFP_N_LED-1:0] IO_LED,
    
// 7 segment outputs ////////////////////////
    output CA,CB,CC,CD,CE,CF,CG, // cathodes
    output [7:0] AN, // anodes
    output DP, // decimal points
/////////////////////////////////////////////
    ////////////////////////////////////////
// for the RojoBot interface
    output [7:0]            IO_BotCtrl,
    output                  IO_INT_ACK,

    input  [31:0]           IO_BotInfo,
    input                   IO_BotUpdt_Sync,
    
                        // player 2 interface
    output [7:0]            IO_BotCtrl_2,
    output                  IO_INT_ACK_2,
    
    input  [31:0]           IO_BotInfo_2,
    input                   IO_BotUpdt_Sync_2,
    
    input      [`MFP_N_PB-1 : 0] IO_PB_2,
    input                    [15:0] score



);

  wire [31:0] HRDATA2, HRDATA1, HRDATA0;
  wire [ 3:0] HSEL;
  reg  [ 3:0] HSEL_d;

  assign HREADY = 1;
  assign HRESP = 0;
	
  // Delay select signal to align for reading data
  always @(posedge HCLK)
    HSEL_d <= HSEL;

  // Module 0 - boot ram
  mfp_ahb_b_ram mfp_ahb_b_ram(HCLK, HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE,
                              HTRANS, HWDATA, HWRITE, HRDATA0, HSEL[0]);
  // Module 1 - program ram
  mfp_ahb_p_ram mfp_ahb_p_ram(HCLK, HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE,
                              HTRANS, HWDATA, HWRITE, HRDATA1, HSEL[1]);
  // Module 2 - GPIO
  mfp_ahb_gpio mfp_ahb_gpio(.HCLK(HCLK), .HRESETn(HRESETn), .HADDR(HADDR[5:2]), .HTRANS(HTRANS), .HWDATA(HWDATA), .HWRITE(HWRITE), .HSEL(HSEL[2]), 
                            .HRDATA(HRDATA2), .IO_Switch(IO_Switch), .IO_LED(IO_LED), 
                            
                            .IO_PB(IO_PB),
                            // rojobot interface boes here
                            .IO_BotCtrl(IO_BotCtrl),  // outputs 
                            .IO_INT_ACK(IO_INT_ACK),  // outputs
                            
                            .IO_BotInfo(IO_BotInfo),
                            .IO_BotUpdt_Sync(IO_BotUpdt_Sync),
                            
                            ///////////////////////////////////////////////////////// 
                            // player 2 
                            .IO_BotCtrl_2(IO_BotCtrl_2), 
                            .IO_INT_ACK_2(IO_INT_ACK_2),
                            
                            .IO_BotInfo_2(IO_BotInfo_2),
                            .IO_BotUpdt_Sync_2(IO_BotUpdt_Sync_2),
                            
                            .IO_PB_2(IO_PB_2)
                            );
  // Module 3 - seven seg display
  mfp_ahb_sevenseg_display mfp_7seg_disp
  (    
// specified inputs as stated in the document
    .HCLK(HCLK),
    .HRESETn(HRESETn),
    .HADDR(HADDR),
    .HWDATA({16'b0,score}),
    .HWRITE(HWRITE),/*************/
    .HSEL(HSEL[3]),
// 7 segment outputs ////////////////////////
    .CA(CA), // cathodes
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG), 
    .AN(AN), // anodes
    .DP(DP),  // decimal points
    .IO_Switch(IO_Switch),
/////////////////////////////////////////////
    // Rojobot testing
    .IO_BotCtrl(IO_BotCtrl_2), 
    .IO_INT_ACK(IO_INT_ACK_2),

    .IO_BotInfo(IO_BotInfo_2),
    .IO_BotUpdt_Sync(IO_BotUpdt_Sync_2),
    .HRDATA(HRDATA)
);

  ahb_decoder ahb_decoder(HADDR, HSEL);
  ahb_mux ahb_mux(HCLK, HSEL_d, HRDATA2, HRDATA1, HRDATA0, HRDATA);

endmodule


module ahb_decoder
(
    input  [31:0] HADDR,
    output [ 3:0] HSEL
);

  // Decode based on most significant bits of the address
  assign HSEL[0] = (HADDR[28:22] == `H_RAM_RESET_ADDR_Match); // 128 KB RAM  at 0xbfc00000 (physical: 0x1fc00000)
  assign HSEL[1] = (HADDR[28]    == `H_RAM_ADDR_Match);       // 256 KB RAM at 0x80000000 (physical: 0x00000000)
  assign HSEL[2] = (HADDR[28:22] == `H_LED_ADDR_Match);       // GPIO at 0xbf800000 (physical: 0x1f800000)
  assign HSEL[3] = (HADDR[28:22] == `IO_7SEGEN_N_MATCH);       // GPIO at 0xbf800000 (physical: 0x1f800000)
endmodule


module ahb_mux
(
    input             HCLK,
    input      [ 2:0] HSEL,
    input      [31:0] HRDATA2, HRDATA1, HRDATA0,
    output reg [31:0] HRDATA
);

    always @(*)
      casez (HSEL)
	      3'b??1:    HRDATA = HRDATA0;
	      3'b?10:    HRDATA = HRDATA1;
	      3'b100:    HRDATA = HRDATA2;
	      default:   HRDATA = HRDATA1;
      endcase
endmodule

