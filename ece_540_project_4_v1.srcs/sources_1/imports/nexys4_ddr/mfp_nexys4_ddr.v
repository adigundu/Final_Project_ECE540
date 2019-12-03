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
                        
   
    // Signals used for worldselect.
reg [1:0] mapdata1, mapdata2, mappixel;
wire [1:0] world_pixel1, world_pixel2, world_pixel3, world_pixel4;
wire [1:0]  worldmap_data_1_1, worldmap_data_1_2,
            worldmap_data_2_1, worldmap_data_2_2,
            worldmap_data_3_1, worldmap_data_3_2,
            worldmap_data_4_1, worldmap_data_4_2;
wire [3:0] map_en;

wire map_change;
reg map_change_db;   
reg [16:0] map_change_counter;
    // test buttons
    //assign JA[2] = 1'b1;
    
    reg JA_1;
    reg JA_2;
    reg JA_3;
    reg JA_4;
                        
  // Press btnCpuReset to reset the processor. 
    wire clk_out; 
    wire tck_in, tck;
  
  // for the 75 mhz clock
    wire clk_out_75mhz; 
    wire tck_in_75mhz, tck_75mhz;
  
  // debounced switches and buttons -Beau /////////////////////
    wire [5:0] pbtn_debounced;
    wire [5:0] pbtn_debounced_2;
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
    wire [13:0] worldmap_addr,    // output wire [13 : 0] worldmap_addr
                worldmap_addr1,
                worldmap_addr2,
                worldmap_addr3,
                worldmap_addr4;
    wire [1:0]  worldmap_data,    // input wire [1 : 0] worldmap_data
                worldmap_data1,
                worldmap_data2, 
                worldmap_data3,
                worldmap_data4;              
    wire        clk_in_75mhz,     // input wire clk_in
                reset,            // input wire reset
                upd_sysregs, upd_sysregs_2;      // output wire upd_sysregs
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
  
  
  debounce debouncer2
  (
        // ports
  .clk(clk_out),                                       // clock    
  .pbtn_in({BTNU, JA_2, JA_3, JA_1, JA_4}),            // pushbutton inputs - including CPU RESET button
  .switch_in(),                                      // slider switch inputs

  .pbtn_db(pbtn_debounced_2),                            // debounced outputs of pushbuttons    
  .swtch_db()                              // debounced outputs of slider switches
    );
  
  
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
                    .IO_BotUpdt_Sync_2(IO_BotUpdt_Sync_2),
                    
                    .IO_PB_2(pbtn_debounced_2) // NEW BUTTONS for Player 2),                    

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
                      .worldmap_data(worldmap_data_2),      // input  wire [1 : 0] worldmap_data
                      .clk_in(clk_out_75mhz),             // input wire clk_in
                      .reset(reset),                      // input wire reset
                      .upd_sysregs(upd_sysregs_2),        // output wire upd_sysregs
                      .Bot_Config_reg(Bot_Config_reg)     // input wire [7 : 0] Bot_Config_reg
                        );

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
                        
assign worldmap_data = mapdata1;    //robot 1
assign worldmap_data2 = mapdata2;   //robot 2
assign world_pixel = mappixel;   
   
always@(*) begin
    if(map_en == 4'b0001) begin
        mapdata1 = worldmap_data_1_1;
        mapdata2 = worldmap_data_1_2;
        mappixel = world_pixel1;
    end
    if(map_en == 4'b0010) begin
        mapdata1 = worldmap_data_2_1;
        mapdata2 = worldmap_data_2_2;
        mappixel = world_pixel2;
    end
    if(map_en == 4'b0100) begin
        mapdata1 = worldmap_data_3_1;
        mapdata2 = worldmap_data_3_2;
        mappixel = world_pixel3;
    end    
    if(map_en == 4'b1000) begin
        mapdata1 = worldmap_data_4_1;
        mapdata2 = worldmap_data_4_2;
        mappixel = world_pixel4;
    end    
end


//  Worldmap implementation for the demo
// this is a copy for the worldmap for p2, just for the sensors to see something
    map1 map1_1(
                             .clka (clk_out_75mhz),  //input clka;
                             .addra(worldmap_addr),  //input [13 : 0] addra;
                             .douta(worldmap_data_1_1),  //output [1 : 0] douta;
                             .clkb (clk_out_75mhz),  // input clkb;
                             .addrb(), // input [13 : 0] addrb;
                             .doutb(),     // output [1 : 0] doutb;
                             .ena(map_en[0]),
                             .enb(map_en[0])
                             );
//  Worldmap implementation for the demo
     map1 map1_2(
                              .clka (clk_out_75mhz),  //input clka;
                              .addra(worldmap_addr2),  //input [13 : 0] addra;
                              .douta(worldmap_data_1_2),  //output [1 : 0] douta;
                              .clkb (clk_out_75mhz),  // input clkb;
                              .addrb({pixel_row_scaled,pixel_column_scaled}), // input [13 : 0] addrb;
                              .doutb(world_pixel1),     // output [1 : 0] doutb;
                              .ena(map_en[0]),
                              .enb(map_en[0])
                              );
// Map 2 for bot 1
    map2 map2_1(
                           .clka (clk_out_75mhz),  //input clka;
                           .addra(worldmap_addr),  //input [13 : 0] addra;
                           .douta(worldmap_data_2_1),  //output [1 : 0] douta;
                           .clkb (clk_out_75mhz),  // input clkb;
                           .addrb(), // input [13 : 0] addrb;
                           .doutb(),     // output [1 : 0] doutb;
                           .ena(map_en[1]),
                           .enb(map_en[1])
                           );
// Map 2 for bot 2
    map2 map2_2(
                            .clka (clk_out_75mhz),  //input clka;
                            .addra(worldmap_addr2),  //input [13 : 0] addra;
                            .douta(worldmap_data_2_2),  //output [1 : 0] douta;
                            .clkb (clk_out_75mhz),  // input clkb;
                            .addrb({pixel_row_scaled,pixel_column_scaled}), // input [13 : 0] addrb;
                            .doutb(world_pixel2),     // output [1 : 0] doutb;
                            .ena(map_en[1]),
                            .enb(map_en[1])
                            );
// Map 2 for bot 1
    map3 map3_1(
                           .clka (clk_out_75mhz),  //input clka;
                           .addra(worldmap_addr),  //input [13 : 0] addra;
                           .douta(worldmap_data_3_1),  //output [1 : 0] douta;
                           .clkb (clk_out_75mhz),  // input clkb;
                           .addrb(), // input [13 : 0] addrb;
                           .doutb(),     // output [1 : 0] doutb;
                           .ena(map_en[2]),
                           .enb(map_en[2])
                           );
// Map 2 for bot 2
    map3 map3_2(
                            .clka (clk_out_75mhz),  //input clka;
                            .addra(worldmap_addr2),  //input [13 : 0] addra;
                            .douta(worldmap_data_3_2),  //output [1 : 0] douta;
                            .clkb (clk_out_75mhz),  // input clkb;
                            .addrb({pixel_row_scaled,pixel_column_scaled}), // input [13 : 0] addrb;
                            .doutb(world_pixel3),     // output [1 : 0] doutb;
                            .ena(map_en[2]),
                            .enb(map_en[2])
                            );
// Map 2 for bot 1
    map4 map4_1(
                           .clka (clk_out_75mhz),  //input clka;
                           .addra(worldmap_addr),  //input [13 : 0] addra;
                           .douta(worldmap_data_4_1),  //output [1 : 0] douta;
                           .clkb (clk_out_75mhz),  // input clkb;
                           .addrb(), // input [13 : 0] addrb;
                           .doutb(),     // output [1 : 0] doutb;
                           .ena(map_en[3]),
                           .enb(map_en[3])
                           );
// Map 2 for bot 2
    map4 map4_2(
                            .clka (clk_out_75mhz),  //input clka;
                            .addra(worldmap_addr2),  //input [13 : 0] addra;
                            .douta(worldmap_data_4_2),  //output [1 : 0] douta;
                            .clkb (clk_out_75mhz),  // input clkb;
                            .addrb({pixel_row_scaled,pixel_column_scaled}), // input [13 : 0] addrb;
                            .doutb(world_pixel4),     // output [1 : 0] doutb;
                            .ena(map_en[3]),
                            .enb(map_en[3])
                            );
                            
                      
// Module to select worlds                            
worldselect select_world(.clk(clk_out),.reset(reset),.map_change(map_change), .map_select(sw_debounced[1:0]), .map_en(map_en) ); 
        
scoreboard score_board(.clk(clk_out), .Sensors_reg1(Sensors_reg), .Sensors_reg2(Sensors_reg_2), .board_rst(reset), .map_rst(reset), .map_change(), .score() );

// Debug for map select
assign map_change = map_change_db; // removed connection from scoreboad to facilitate testing.

always@(posedge clk_out)begin
    if(reset) map_change_counter <= 0;
    else if(map_change_counter >= (1000*sw_debounced[15:2])) begin
        map_change_db <= 1;
        map_change_counter <= 0;
    end
    else begin
        map_change_db <= 0;
        map_change_counter <= map_change_counter + 1;
    end
end
          
                  
 //assign JA[1] = JA_1;
//                                assign LED[`MFP_N_LED-1] = ~JA_1;
//                                assign LED[`MFP_N_LED-2] = ~JA_2;
//                                assign LED[`MFP_N_LED-3] = ~JA_3;
//                                assign LED[`MFP_N_LED-4] = ~JA_4;
//                                always @(*)
//                                begin
                                
//                                    case (JC[1])
//                                        1'b0:    JA_1 <= 1'b0;
//                                        1'b1:    JA_1 <= 1'b1;
//                                        default: JA_1 <= 1'b0; 
//                                    endcase
                                    
//                                    case (JC[2])
//                                        1'b0:    JA_2 <= 1'b0;
//                                        1'b1:    JA_2 <= 1'b1;
//                                        default: JA_2 <= 1'b0; 
//                                    endcase
//                                    case (JC[3])
//                                        1'b0:    JA_3 <= 1'b0;
//                                        1'b1:    JA_3 <= 1'b1;
//                                        default: JA_3 <= 1'b0; 
//                                    endcase
//                                    case (JC[4])
//                                        1'b0:    JA_4 <= 1'b0;
//                                        1'b1:    JA_4 <= 1'b1;
//                                        default: JA_4 <= 1'b0; 
//                                    endcase
                               
                              ////////////////////////////////////////////////////  
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
                                
//                                end
                                
                                
endmodule
