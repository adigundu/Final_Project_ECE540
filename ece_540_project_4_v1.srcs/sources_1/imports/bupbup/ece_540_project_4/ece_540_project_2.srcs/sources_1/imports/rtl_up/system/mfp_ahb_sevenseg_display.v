`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 04:51:00 PM
// Design Name: 
// Module Name: mfp_ahb_sevenseg_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "mfp_ahb_const.vh"

module mfp_ahb_sevenseg_display(    
    input                        HCLK,//
    input                        HRESETn,
    input      [ 31          :0] HADDR,//
    input      [ 31          :0] HWDATA,//
    input                        HWRITE,// write enable
    input                        HSEL,

// memory-mapped I/O
// 7 segment outputs ////////////////////////
    output reg CA,CB,CC,CD,CE,CF,CG, // cathodes
    output reg [7:0] AN, // anodes
    output reg DP, // decimal points
/////////////////////////////////////////////
    input      [`MFP_N_SW-1 :0] IO_Switch, // switch for debugging purposes
    
    // for the RojoBot interface
    input  [7:0]            IO_BotCtrl, // originally output
    input                   IO_INT_ACK, // originally output
    
    input  [31:0]           IO_BotInfo,
    input                   IO_BotUpdt_Sync,
    
    input      [ 31          :0] HRDATA
    );
    

      reg  [31:0]  HADDR_d;
      reg          HWRITE_d;
      reg          HSEL_d;
      
      // BCD version of HWDATA for the 1st 3 digits
      wire  [31:0] HWDATA_d;
      reg   [63:0] DIGITS_d;   
      
      wire         we;            // write enable
      
       wire CA_d,CB_d,CC_d,CD_d,CE_d,CF_d,CG_d; // cathodes
       wire [7:0] AN_d; // anodes
       wire DP_d; // decimal points 
       
    
      // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
      always @ (posedge HCLK) 
      begin
        HADDR_d  <= HADDR;
      end
      
      // overall write enable signal
      assign we = HWRITE;
      
  

  // SWITCHES FOR TESTING.  THIS TESTS 
  // IF THE DISPLAY IS DISPLAYING THE CORRECT
  // VALUES
  initial 
  begin
    DIGITS_d[63:0] = 64'h0F0E_0D0C_0B0A_0908;
  end
  
  always @(posedge HCLK)
  begin
    case (IO_Switch[15:12])

        4'b0000:  // actual spec - no switches turned on
        
        begin
        if (~(HRESETn || ~HSEL))
            DIGITS_d[31:0] <= 32'h0;
        else
        begin
        // digit 0
        DIGITS_d[3:0]   <= IO_BotInfo[27:24]; // loc_y
        DIGITS_d[7:4]   <= 4'b0000;
        // digit 1
        DIGITS_d[11:8]  <= IO_BotInfo[31:28]; // loc_y
        DIGITS_d[15:12] <= 4'b0000;
        // digit 2
        DIGITS_d[19:16] <= IO_BotInfo[19:16]; // loc_x
        DIGITS_d[23:20] <= 4'b0000;
        // digit 3
        DIGITS_d[27:24] <= IO_BotInfo[23:20]; // loc_x
        DIGITS_d[31:28] <= 4'b0000;
        // digit 4
        case (IO_BotInfo[7:4])
            4'h0:
            begin
                DIGITS_d[36:32] <= 5'h17;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'h4:
            begin
                DIGITS_d[36:32] <= 5'h0F;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'h8:
            begin
                DIGITS_d[36:32] <= 5'h0B;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'hC:
            begin
                DIGITS_d[36:32] <= 5'h18;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'hD:
            begin
                DIGITS_d[36:32] <= 5'h1A;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'hE:
            begin
                DIGITS_d[36:32] <= 5'h19;
                DIGITS_d[39:37] <= 3'b000;
            end
            4'hF:
            begin
                DIGITS_d[36:32] <= 5'h13;
                DIGITS_d[39:37] <= 3'b000;
            end
        endcase
        case (IO_BotInfo[3:0])
        4'h0:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h0;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h0;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h0;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h1:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h5;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h4;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h0;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h2:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h0;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h9;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h0;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h3:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h5;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h3;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h1;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h4:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h0;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h8;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h1;
            DIGITS_d[63:60] <= 4'b0000; 
        end        
        4'h5:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h5;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h2;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h2;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h6:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h0;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h7;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h2;
            DIGITS_d[63:60] <= 4'b0000; 
        end
        4'h7:
        begin
            // digit 5
            DIGITS_d[43:40] <= 4'h5;
            DIGITS_d[47:44] <= 4'b0000;
            // digit 6
            DIGITS_d[51:48] <= 4'h1;
            DIGITS_d[55:52] <= 4'b0000;
            // digit 7
            DIGITS_d[59:56] <= 4'h3;
            DIGITS_d[63:60] <= 4'b0000; 
        end   
        endcase
        

        end
        end
        
        4'b0001:   // display IO_BOTINFO line.  This is how it looks like
                   // when it goes thru the processor
        begin
        DIGITS_d[3:0]   <= IO_BotInfo[3:0];   // botinfo_reg
        DIGITS_d[7:4]   <= 4'b0000;
        DIGITS_d[11:8]  <= IO_BotInfo[7:4];   // botinfo_reg
        DIGITS_d[15:12] <= 4'b0000;
        DIGITS_d[19:16] <= IO_BotInfo[11:8];  // sensors_reg
        DIGITS_d[23:20] <= 4'b0000;
        DIGITS_d[27:24] <= IO_BotInfo[15:12]; // sensors_reg
        DIGITS_d[31:28] <= 4'b0000;
        DIGITS_d[35:32] <= IO_BotInfo[19:16]; // loc_x
        DIGITS_d[39:36] <= 4'b0000;
        DIGITS_d[43:40] <= IO_BotInfo[23:20]; // loc_x
        DIGITS_d[47:44] <= 4'b0000;
        DIGITS_d[51:48] <= IO_BotInfo[27:24]; // loc_y
        DIGITS_d[55:52] <= 4'b0000;
        DIGITS_d[59:56] <= IO_BotInfo[31:28]; // loc_y
        DIGITS_d[63:60] <= 4'b0000; 
        end
        
        4'b0011: 
        begin
        DIGITS_d[3:0]   <= IO_BotCtrl[3:0];
        DIGITS_d[7:4]   <= 4'b0000;
        DIGITS_d[11:8]  <= IO_BotCtrl[7:4];
        DIGITS_d[15:12] <= 4'b0000;
        DIGITS_d[19:16] <= IO_INT_ACK;
        DIGITS_d[23:20] <= 4'b0000;
        DIGITS_d[27:24] <= IO_BotUpdt_Sync;
        DIGITS_d[31:28] <= 4'b0000;
        DIGITS_d[35:32] <= 4'b0000;
        DIGITS_d[39:36] <= 4'b0000;
        DIGITS_d[43:40] <= 4'b0000;
        DIGITS_d[47:44] <= 4'b0000;
        DIGITS_d[51:48] <= 4'b0000;
        DIGITS_d[55:52] <= 4'b0000;
        DIGITS_d[59:56] <= 4'b0000;
        DIGITS_d[63:60] <= 4'b0000; 
        end
        
        4'b0010: // display raw data
         // each digit was hooked up to the data directly. There is no memory mapping here
         // this was used just to test if writing addresses could be displayed in the display
        begin
         DIGITS_d[3:0]   <= HWDATA[3:0];
         DIGITS_d[7:4]   <= 4'b0000;
         DIGITS_d[11:8]  <= HWDATA[7:4];
         DIGITS_d[15:12] <= 4'b0000;
         DIGITS_d[19:16] <= HWDATA[11:8];
         DIGITS_d[23:20] <= 4'b0000;
         DIGITS_d[27:24] <= HWDATA[15:12];
         DIGITS_d[31:28] <= 4'b0000;
         DIGITS_d[35:32] <= HWDATA[19:16];
         DIGITS_d[39:36] <= 4'b0000;
         DIGITS_d[43:40] <= HWDATA[23:20];
         DIGITS_d[47:44] <= 4'b0000;
         DIGITS_d[51:48] <= HWDATA[27:24];
         DIGITS_d[55:52] <= 4'b0000;
         DIGITS_d[59:56] <= HWDATA[31:28];
         DIGITS_d[63:60] <= 4'b0000;      
        end
        4'b0100: // display raw address
        // this is to check if the address was being displayed/ accessed correctly.
        // each address hex digit is connected directly to the digit in the display
        begin
         DIGITS_d[3:0]   <= HADDR[3:0];
         DIGITS_d[7:4]   <= 4'b0000;
         DIGITS_d[11:8]  <= HADDR[7:4];
         DIGITS_d[15:12] <= 4'b0000;
         DIGITS_d[19:16] <= HADDR[11:8];
         DIGITS_d[23:20] <= 4'b0000;
         DIGITS_d[27:24] <= HADDR[15:12];
         DIGITS_d[31:28] <= 4'b0000;
         DIGITS_d[35:32] <= HADDR[19:16];
         DIGITS_d[39:36] <= 4'b0000;
         DIGITS_d[43:40] <= HADDR[23:20];
         DIGITS_d[47:44] <= 4'b0000;
         DIGITS_d[51:48] <= HADDR[27:24];
         DIGITS_d[55:52] <= 4'b0000;
         DIGITS_d[59:56] <= HADDR[31:28];
         DIGITS_d[63:60] <= 4'b0000;      
        end
        //3'b011: //(no case here)
        // switch values for initial testing to see if the timer
        // was functioning correclty.
        4'b1000: DIGITS_d <= {32'h0102_0304,32'h0506_0708};
        4'b1010: DIGITS_d <= {32'h090A_0B0C,32'h0D0E_0F10};
        4'b1100: DIGITS_d <= {32'h1112_1314,32'h1516_1718};
        4'b1110: DIGITS_d <= {32'h1112_1314,32'h1516_1718};
         // actual spec, but in hex
        // before going with a software solution to the BCD compass display
        // a hardware one was initially implemented.  This was to keep the original 
        // hex values for comparison.  There should not be a difference between this case
        // and case 000, in which no switches are flipped
        default:
        begin 
        // default case - nothing should be changed in here.
        DIGITS_d <= DIGITS_d;
        AN <= AN;
        end
    endcase
    

  end
 
 // connects the output of the seven segment timer to the 
 // actual 7 segment outputs to be interfaced with the fpga
 
 always @(*)
 begin
     //AN[7:4] <= 4'b1111;   // disable top digits
     AN[7:4] <= AN_d[7:4];
     AN[3:0] <= AN_d[3:0]; // connect right 4 anode digits
     // connect cathode outputs from the 7seg timer to the
     // cathode outputs   
     CA <= CA_d;
     CB <= CB_d;
     CC <= CC_d;
     CD <= CD_d;
     CE <= CE_d;
     CF <= CF_d;
     CG <= CG_d;
     // to enable the decimal point in one place only
     // instead of editing memory mapping
     case (AN_d[3])
        1'b0:     DP <= 1'b0;
        default:  DP <= 1'b1;
     endcase
 end
  

  // 7 segment timer instantiation.  This is from the module provided
  // commentary here is not 
 mfp_ahb_sevensegtimer seg_7_timer
  (
                       .clk(HCLK),
                       .resetn(HRESETn),
                       
                       .EN(),  // display is always on.  This will be initialized to 0
                               // except for the 4 digits 
                               // which are already handled in software
                               // since they can be disabled there
                       .DIGITS(DIGITS_d), 
                       // decimal points not handled here since
                       // they are disabled above.
                       // could have written this in C and have it properly mapped to memory
                       .dp(),
                       
                       .DISPENOUT(AN_d), //enable for each digits
                       // output for each segments
                       .DISPOUT({DP_d,CA_d,CB_d,CC_d,CD_d,CE_d,CF_d,CG_d})
  );

//////////////////////////        
      
    
  
    
endmodule
