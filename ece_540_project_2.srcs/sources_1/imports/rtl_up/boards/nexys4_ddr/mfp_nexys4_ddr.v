// mfp_nexys4_ddr.v
// January 1, 2017
//
// Instantiate the mipsfpga system and rename signals to
// match the GPIO, LEDs and switches on Digilent's (Xilinx)
// Nexys4 DDR board

// Outputs:
// 16 LEDs (IO_LED) 
// Inputs:
// 16 Slide switches (IO_Switch),
// 5 Pushbuttons (IO_PB): {BTNU, BTND, BTNL, BTNC, BTNR}
//

`include "mfp_ahb_const.vh"

module mfp_nexys4_ddr( 
                        input                   CLK100MHZ,
                        input                   CPU_RESETN,
                        input                   BTNU, BTND, BTNL, BTNC, BTNR, 
                        input  [`MFP_N_SW-1 :0] SW,
                        output [`MFP_N_LED-1:0] LED,
                        inout  [ 8          :1] JB,

                        input                   UART_TXD_IN,
                        
                        // 7 segment outputs
                        output CA,CB,CC,CD,CE,CF,CG,
                        output [7:0] AN,
                        output DP,
                        
                        // vsync and hsync
                        output VGA_VS,
                        output VGA_HS,
                        
                        output [3:0] VGA_R,
                        output [3:0] VGA_G,
                        output [3:0] VGA_B,
                        
                        output [2:1] JA,      
                                         
                        input [4:1] JC 
                        );
                        
    
    // test buttons
    //assign JA[2] = 1'b1;
    
    reg JA_1;
    reg JA_2;
    reg JA_3;
    reg JA_4;

    
    //assign JA[1] = JA_1;
    assign LED[`MFP_N_LED-1] = ~JA_1;
    assign LED[`MFP_N_LED-2] = ~JA_2;
    assign LED[`MFP_N_LED-3] = ~JA_3;
    assign LED[`MFP_N_LED-4] = ~JA_4;
    always @(*)
    begin
    
        case (JC[1])
            1'b0:    JA_1 <= 1'b0;
            1'b1:    JA_1 <= 1'b1;
            default: JA_1 <= 1'b0; 
        endcase
        
        case (JC[2])
            1'b0:    JA_2 <= 1'b0;
            1'b1:    JA_2 <= 1'b1;
            default: JA_2 <= 1'b0; 
        endcase
        case (JC[3])
            1'b0:    JA_3 <= 1'b0;
            1'b1:    JA_3 <= 1'b1;
            default: JA_3 <= 1'b0; 
        endcase
        case (JC[4])
            1'b0:    JA_4 <= 1'b0;
            1'b1:    JA_4 <= 1'b1;
            default: JA_4 <= 1'b0; 
        endcase
    
  //////////////////////////////////////////////////////  
  /*
    case (BTNU)
        1'b0:    JA_1 <= 1'b0;
        1'b1:    JA_1 <= 1'b1;
        default: JA_1 <= 1'b0; 
    endcase
    
    case (BTND)
        1'b0:    JA_2 <= 1'b0;
        1'b1:    JA_2 <= 1'b1;
        default: JA_2 <= 1'b0; 
    endcase
    case (BTNL)
        1'b0:    JA_3 <= 1'b0;
        1'b1:    JA_3 <= 1'b1;
        default: JA_3 <= 1'b0; 
    endcase
    case (BTNR)
        1'b0:    JA_4 <= 1'b0;
        1'b1:    JA_4 <= 1'b1;
        default: JA_4 <= 1'b0; 
    endcase
    */
    ///////////////////////////////////////////////////////
    
    end
    
    
                        
  // Press btnCpuReset to reset the processor. 
    wire clk_out; 
    wire tck_in, tck;
  
  // for the 75 mhz clock
    wire clk_out_75mhz; 
    wire tck_in_75mhz, tck_75mhz;
  
  // debounced switches and buttons -Beau /////////////////////
    wire [5:0] pbtn_debounced;
    wire [15:0]sw_debounced;
  
    /////////////////////////////////////////////////////////////
  // for the RojoBot interface
    wire [7:0]            IO_BotCtrl; // mfp_sys outputs
    wire                  IO_INT_ACK;
 
    wire  [31:0]          IO_BotInfo; // mfp_sys inputs
    reg                   IO_BotUpdt_Sync;
     
    // wires for the DTG
    wire [7:0]  MotCtl_in,        // input wire [7 : 0] MotCtl_in
                LocX_reg,         // output wire [7 : 0] LocX_reg
                LocY_reg,         // output wire [7 : 0] LocY_reg
                Sensors_reg,      // output wire [7 : 0] Sensors_reg
                BotInfo_reg;      // output wire [7 : 0] BotInfo_reg
    wire [13:0] worldmap_addr;    // output wire [13 : 0] worldmap_addr
    wire [1:0]  worldmap_data;    // input wire [1 : 0] worldmap_data
    wire        clk_in_75mhz,     // input wire clk_in
                reset,            // input wire reset
                upd_sysregs;      // output wire upd_sysregs
    wire [7:0]  Bot_Config_reg;   // input wire [7 : 0] Bot_Config_reg
     
    wire IO_BotUpdt;
    
    

    
    
  /////////////////////////////////////////////////////////////
  // H/V sync wires for VGA 
    wire video_on;                // DTG to colourizer
    
    wire [11:0] pixel_row;        // DTG to icon
    wire [11:0] pixel_column;     // DTG to icon 
    
    //scaled versions of pixel_row and pixel_column
    wire [6:0]	pixel_row_scaled;
    wire [6:0]  pixel_column_scaled;    
    
    wire [1:0]  world_pixel;    // input wire [1 : 0] world_pixel
    wire [1:0]  icon_pixel;     // from icon to colorizer.  
                                // this is the data for the 
                                // icon
  /////////////////////////////////////////////////////////////
    
    // renaming of signals from the processor to Rojobot
    assign IO_BotCtrl  = MotCtl_in;
     
    assign BotInfo_reg = IO_BotInfo[7:0];
    assign Sensors_reg = IO_BotInfo[15:8];
    assign LocX_reg    = IO_BotInfo[23:16];
    assign LocY_reg    = IO_BotInfo[31:24];
     
    assign IO_BotUpdt  = upd_sysregs;
     
    assign Bot_Config_reg = sw_debounced[7:0];
     
      
    assign reset = ~CPU_RESETN;
      
  /////////////////////////////////////////////////////////////
    clk_wiz_0 clk_wiz_0(.clk_in1(CLK100MHZ), .clk_out1(clk_out), .clk_out2(clk_out_75mhz));
  
  
  IBUF IBUF1(.O(tck_in),.I(JB[4]));
  BUFG BUFG1(.O(tck), .I(tck_in));
  
  //  Instantiation of Debouncer Circuit ////////////////////////////////////////////////////////////////////
  debounce debouncer
  (
      // ports
      .clk(clk_out),                                       // clock    
      .pbtn_in({BTNU, BTND, BTNL, BTNC, BTNR}),            // pushbutton inputs - including CPU RESET button
      .switch_in(SW),                                      // slider switch inputs
  
      .pbtn_db(pbtn_debounced),                            // debounced outputs of pushbuttons    
      .swtch_db(sw_debounced)                              // debounced outputs of slider switches
  );
  
  /*
  debounce debouncer2
  (
        // ports
  .clk(clk_out),                                       // clock    
  .pbtn_in({BTNU, BTND, BTNL, BTNC, BTNR}),            // pushbutton inputs - including CPU RESET button
  .switch_in(),                                      // slider switch inputs

  .pbtn_db(),                            // debounced outputs of pushbuttons    
  .swtch_db()                              // debounced outputs of slider switches
    );
  */
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  mfp_sys mfp_sys(
			        .SI_Reset_N(CPU_RESETN),
                    .SI_ClkIn(clk_out),
                    .HADDR(),
                    .HRDATA(),
                    .HWDATA(),
                    .HWRITE(),
					.HSIZE(),
                    .EJ_TRST_N_probe(JB[7]),
                    .EJ_TDI(JB[2]),
                    .EJ_TDO(JB[3]),
                    .EJ_TMS(JB[1]),
                    .EJ_TCK(tck),
                    .SI_ColdReset_N(JB[8]),
                    .EJ_DINT(1'b0),
                    ////////////////////////////////////////////////////////////////
                    // debounced inputs to mfp_sys
                    // original un-debounced code included for reference
                    .IO_Switch(sw_debounced),//.IO_Switch(SW), 
                    .IO_PB(pbtn_debounced),//.IO_PB({BTNU, BTND, BTNL, BTNC, BTNR}),
                    ////////////////////////////////////////////////////////////////
                    .IO_LED(LED[`MFP_N_LED-5:0]),
                    .UART_RX(UART_TXD_IN),
                    
                    /////////////////////
                    // 7 segment outputs
                    // cathodes
                    
                    .CA(CA),     
                    .CB(CB),
                    .CC(CC),
                    .CD(CD),
                    .CE(CE),
                    .CF(CF),
                    .CG(CG),
                    // anodes
                    .AN(AN),
                    // decimal 
                    .DP(DP),

                    // Interface to the Rojobot                    
                    .IO_BotCtrl(IO_BotCtrl), //outputs of the mfp_sys
                    .IO_INT_ACK(IO_INT_ACK),
                    
                    .IO_BotInfo(IO_BotInfo), // inputs to the mfp_sys
                    .IO_BotUpdt_Sync(IO_BotUpdt_Sync),
                    
                    // Interface for Player 2
                    
                    .IO_BotCtrl_2(IO_BotCtrl_2), //outputs of the mfp_sys
                    .IO_INT_ACK_2(IO_INT_ACK_2),
                    
                    // synchronization for player 2                    
                    
                    .IO_BotInfo_2(IO_BotInfo_2), // inputs to the mfp_sys
                    .IO_BotUpdt_Sync_2(IO_BotUpdt_Sync_2)                    

                    );
                    
 
// flipflop for handshaking
// copied from the document
    always @(posedge clk_out) begin
        if (IO_INT_ACK == 1'b1) begin
            IO_BotUpdt_Sync <= 1'b0;
        end        
        else if (IO_BotUpdt == 1'b1) begin
            IO_BotUpdt_Sync <= 1'b1;
        end else begin
            IO_BotUpdt_Sync <= IO_BotUpdt_Sync;
        end
     end
 
// rojobot instantiation template for rojobot.v               
    rojobot31 rojobot_1(
                      .player(0),
                      .MotCtl_in(MotCtl_in),            // input wire [7 : 0] MotCtl_in
                      .LocX_reg(LocX_reg),              // output wire [7 : 0] LocX_reg
                      .LocY_reg(LocY_reg),              // output wire [7 : 0] LocY_reg
                      .Sensors_reg(Sensors_reg),        // output wire [7 : 0] Sensors_reg
                      .BotInfo_reg(BotInfo_reg),        // output wire [7 : 0] BotInfo_reg
                      .worldmap_addr(worldmap_addr),    // output wire [13 : 0] worldmap_addr
                      .worldmap_data(worldmap_data),    // input wire [1 : 0] worldmap_data
                      .clk_in(clk_out_75mhz),                  // input wire clk_in
                      .reset(reset),                    // input wire reset
                      .upd_sysregs(upd_sysregs),        // output wire upd_sysregs
                      .Bot_Config_reg(Bot_Config_reg)  // input wire [7 : 0] Bot_Config_reg
                        );
                        
                    
//  Worldmap implementation for the demo
    world_map worldmap_part_1(
                             .clka (clk_out_75mhz),  //input clka;
                             .addra(worldmap_addr),  //input [13 : 0] addra;
                             .douta(worldmap_data),  //output [1 : 0] douta;
                             .clkb (clk_out_75mhz),  // input clkb;
                             .addrb({pixel_row_scaled,pixel_column_scaled}), // input [13 : 0] addrb;
                             .doutb(world_pixel)     // output [1 : 0] doutb;
                             );
                        
    // Display Timing Generator                    
    dtg hv_sync(   
                // clk generator
                .clock(clk_out_75mhz), .rst(reset),                           // input
                // hsync and vsync
                .horiz_sync(VGA_HS), .vert_sync(VGA_VS), .video_on(video_on), // output
                // output    reg    [11:0]
                // row and column pixels
                .pixel_row(pixel_row), .pixel_column(pixel_column)  
               );
    // scaling the address to fit the 128x128 from 1024x768
    // NOTE:  Uses the division circuit
    addr_scaler scale_1(
                       .pixel_row(pixel_row), .pixel_column(pixel_column),
                     
                       .pixel_row_scaled(pixel_row_scaled), 
                       .pixel_column_scaled(pixel_column_scaled)
                       );  
                             

    colorizer colorizer_1(
         .world_pixel(world_pixel),             //input [1:0] world_pixel,
         .icon_pixel(icon_pixel),             //input [1:0] icon_pixel,
         .icon_pixel_2(icon_pixel_2),
         .video_on(video_on),                //input video_on,
         .sw_debounced_8(sw_debounced[8]),          //input sw_debounced_8,
         
         .VGA_R(VGA_R),                   //output reg [3:0] VGA_R,
         .VGA_G(VGA_G),                   //output reg [3:0] VGA_G,
         .VGA_B(VGA_B)                   //output reg [3:0] VGA_B
    );

    // icon generator for the rojobot
    icon rojobot_icon(
    // location and information of the rojobot
        .LocX_reg(LocX_reg),         // output wire [7 : 0] LocX_reg
        .LocY_reg(LocY_reg),         // output wire [7 : 0] LocY_reg
        .BotInfo_reg(BotInfo_reg),   // output wire [7 : 0] BotInfo_reg

    // values for the pixel counters
        .pixel_row_offset(pixel_row_scaled),       // DTG to icon
        .pixel_column_offset(pixel_column_scaled), // DTG to icon 
    
        .icon_pixel(icon_pixel)      // pixels for the icon
    );
    
/************************************************************************/
/************************************************************************/
/************************************************************************/
/************************************************************************/    
/************************************************************************/
// some player 2 shit

    // duplicate signals
    
    

    wire [7:0]    MotCtl_in_2,        // input  wire [7 : 0] MotCtl_in
                  LocX_reg_2,         // output wire [7 : 0] LocX_reg
                  LocY_reg_2,         // output wire [7 : 0] LocY_reg
                  Sensors_reg_2,      // output wire [7 : 0] Sensors_reg
                  BotInfo_reg_2;      // output wire [7 : 0] BotInfo_reg
                
    wire [1:0]    icon_pixel_2; 
    
    wire [13:0]   worldmap_addr_2;    // output wire [13 : 0] worldmap_addr
    wire [1:0]    worldmap_data_2;    // input wire [1 : 0] worldmap_data
    
    wire [31:0]   IO_BotInfo_2;       // mfp_sys inputs
    
    // for handshaking the second player
    wire          IO_INT_ACK_2;
    wire          IO_BotUpdt_2;
    reg           IO_BotUpdt_Sync_2;
    
    // for controlling player 2
    
    wire [7:0]    IO_BotCtrl_2; // mfp_sys outputs
    
    
    // split the bus of IO_BotInfo_2
    
    assign BotInfo_reg_2 = IO_BotInfo_2[7:0];
    assign Sensors_reg_2 = IO_BotInfo_2[15:8];
    assign LocX_reg_2    = IO_BotInfo_2[23:16];
    assign LocY_reg_2    = IO_BotInfo_2[31:24];
    
    assign IO_BotUpdt_2  = upd_sysregs_2;
    
    
    assign IO_BotCtrl_2  = MotCtl_in_2;
    
    
        
    // flipflop for handshaking the second player
    // copied from the document
    
        always @(posedge clk_out) begin
            if (IO_INT_ACK_2 == 1'b1) begin
                IO_BotUpdt_Sync_2 <= 1'b0;
            end        
            else if (IO_BotUpdt_2 == 1'b1) begin
                IO_BotUpdt_Sync_2 <= 1'b1;
            end else begin
                IO_BotUpdt_Sync_2 <= IO_BotUpdt_Sync_2;
            end
         end
    
  
  
   

    // icon generator for the rojobot
    icon rojobot_icon_2(
    // location and information of the rojobot
        .LocX_reg(LocX_reg_2),         // output wire [7 : 0] LocX_reg
        .LocY_reg(LocY_reg_2),         // output wire [7 : 0] LocY_reg
        .BotInfo_reg(BotInfo_reg_2),   // output wire [7 : 0] BotInfo_reg

    // values for the pixel counters
        .pixel_row_offset(pixel_row_scaled),       // DTG to icon
        .pixel_column_offset(pixel_column_scaled), // DTG to icon 
    
        .icon_pixel(icon_pixel_2)      // pixels for the icon
    );

// rojobot instantiation template for rojobot.v               
    rojobot31 rojobot_2(
                      .player(1),
                      .MotCtl_in(MotCtl_in_2),            // input  wire [7 : 0] MotCtl_in
                      .LocX_reg(LocX_reg_2),              // output wire [7 : 0] LocX_reg
                      .LocY_reg(LocY_reg_2),              // output wire [7 : 0] LocY_reg
                      .Sensors_reg(Sensors_reg_2),        // output wire [7 : 0] Sensors_reg
                      .BotInfo_reg(BotInfo_reg_2),        // output wire [7 : 0] BotInfo_reg
                      .worldmap_addr(worldmap_addr_2),    // output wire [13 : 0] worldmap_addr
                      .worldmap_data(worldmap_data),      // input  wire [1 : 0] worldmap_data
                      .clk_in(clk_out_75mhz),             // input wire clk_in
                      .reset(reset),                      // input wire reset
                      .upd_sysregs(upd_sysregs_2),        // output wire upd_sysregs
                      .Bot_Config_reg(Bot_Config_reg)     // input wire [7 : 0] Bot_Config_reg
                        );


endmodule
