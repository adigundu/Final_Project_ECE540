// mfp_ahb_gpio.v
//
// General-purpose I/O module for Altera's DE2-115 and 
// Digilent's (Xilinx) Nexys4-DDR board

/*
for reference

`define PORT_BOTINFO_2		    (32'h1f80002c)		// (i) Bot Info port
`define PORT_BOTCTRL_2		    (32'h1f800020)		// (o) Bot Control port
`define PORT_BOTUPDT_2		    (32'h1f800024)	        // (i) Bot Update port (Poll)
`define PORT_INTACK_2		    (32'h1f800028)		// (o) Bot Int Ack 
`define P2_PORT_BTNS            (32'h1f80001c)              // address of p2 buttons


`define PORT_BOTINFO_IONUM_2      (4'hb) // (o) Bot Control port
`define PORT_BOTCTRL_IONUM_2      (4'h8) // (i) Bot Info port
`define PORT_BOTUPDT_IONUM_2      (4'h9) // (i) Bot Update port (Poll)
`define PORT_INTACK_IONUM_2       (4'ha) // (o) Bot Int Ack

`define P2_PORT_BTNS_IONUM_2      (4'h7) // (o) Bot Int Ack

*/
`include "mfp_ahb_const.vh"

module mfp_ahb_gpio(
    input                        HCLK,
    input                        HRESETn,
    input      [  3          :0] HADDR,
    input      [  1          :0] HTRANS,
    input      [ 31          :0] HWDATA,
    input                        HWRITE,
    input                        HSEL,
    output reg [ 31          :0] HRDATA,

// memory-mapped I/O

/*
These are just outputs to the modules, not actual memory locations
bit sizes for reference
`define MFP_N_LED             16
`define MFP_N_SW              16
`define MFP_N_PB              5
*/
    input      [`MFP_N_SW-1  :0] IO_Switch,
    input      [`MFP_N_PB-1  :0] IO_PB,
    output reg [`MFP_N_LED-1 :0] IO_LED,
    
    // for the RojoBot interface
    output reg [7:0]            IO_BotCtrl,
    output reg                 IO_INT_ACK,
    
    input  [31:0]               IO_BotInfo,
    input                       IO_BotUpdt_Sync,
    
                            // player 2 interface
    output reg [7:0]            IO_BotCtrl_2,
    output reg                  IO_INT_ACK_2,

    input  [31:0]               IO_BotInfo_2,
    input                       IO_BotUpdt_Sync_2,

    input      [`MFP_N_PB-1 : 0] IO_PB_2
    
    
);

  reg  [3:0]  HADDR_d;
  reg         HWRITE_d;
  reg         HSEL_d;
  reg  [1:0]  HTRANS_d;
  wire        we;            // write enable

  // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
  always @ (posedge HCLK) 
  begin
    HADDR_d  <= HADDR;
	HWRITE_d <= HWRITE;
	HSEL_d   <= HSEL;
	HTRANS_d <= HTRANS;
  end
  
  // overall write enable signal
  assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;

    always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn) begin  // if reset is low, write 0 to IO_LED location
         IO_LED                            <= `MFP_N_LED'b0;  
         IO_BotCtrl                        <= `MFP_N_LED'b0;
         IO_INT_ACK                        <= `MFP_N_LED'b0; 
         
         // player 2
         IO_BotCtrl_2                      <= `MFP_N_LED'b0;
         IO_INT_ACK_2                      <= `MFP_N_LED'b0;         
         
         
       end else if (we)
         case (HADDR_d)
           `H_LED_IONUM:           IO_LED       <= HWDATA[`MFP_N_LED-1:0];
           `PORT_BOTCTRL_IONUM:    IO_BotCtrl   <= HWDATA[`MFP_N_LED-1:0]; //
           `PORT_INTACK_IONUM:     IO_INT_ACK   <= HWDATA[`MFP_N_LED-1:0]; //
           // player 2
           `PORT_BOTCTRL_IONUM_2:  IO_BotCtrl_2 <= HWDATA[`MFP_N_LED-1:0]; //
           `PORT_INTACK_IONUM_2 :  IO_INT_ACK_2 <= HWDATA[`MFP_N_LED-1:0]; //           
           
           
           // add more for the rojobot here ///////////////////

           ////////////////////////////////////////////////////
         endcase
    
	always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn)
         HRDATA <= 32'h0;
       else
	     case (HADDR)
           `H_SW_IONUM:         HRDATA <= { {32 - `MFP_N_SW {1'b0}}, IO_Switch };
           `H_PB_IONUM:         HRDATA <= { {32 - `MFP_N_PB {1'b0}}, IO_PB };
           // add more for the rojobot here /////////////////////////////
           `PORT_BOTINFO_IONUM: HRDATA <= IO_BotInfo;
           `PORT_BOTUPDT_IONUM: HRDATA <= IO_BotUpdt_Sync;
           
           // player 2
           `PORT_BOTINFO_IONUM_2: HRDATA <= IO_BotInfo_2;
           `PORT_BOTUPDT_IONUM_2: HRDATA <= IO_BotUpdt_Sync_2;  
           
           `P2_PORT_BTNS_IONUM_2: HRDATA <= { {32 - `MFP_N_PB {1'b0}}, IO_PB_2 };         
           //////////////////////////////////////////////////////////////           
            default:    HRDATA <= 32'h00000000;
         endcase
		 
endmodule
