
`include "mfp_ahb_const.vh"

module mfp_ahb_withloader (
    input         HCLK,
    input         HRESETn,
    input  [31:0] HADDR,
    input  [ 2:0] HBURST,
    input         HMASTLOCK,
    input  [ 3:0] HPROT,
    input  [ 2:0] HSIZE,
    input  [ 1:0] HTRANS,
    input  [31:0] HWDATA,
    input         HWRITE,
    output [31:0] HRDATA,
    output        HREADY,
    output        HRESP,
    input         SI_Endian,

	// memory-mapped I/O
    input      [`MFP_N_SW-1 : 0] IO_Switch,
    input      [`MFP_N_PB-1 : 0] IO_PB,
    output     [`MFP_N_LED-1: 0] IO_LED,

	// for serial loading of memory using uart
    input         UART_RX,

	// reset system due to serial load
    output        MFP_Reset_serialload,
    
    // 7 segment outputs ///////////////////
    output CA,CB,CC,CD,CE,CF,CG, // cathodes
    output [7:0] AN, // anodes
    output DP, // decimal points
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
    
    input      [`MFP_N_PB-1 : 0] IO_PB_2
    
);
/*
// test code for 7 segment
  assign AN = 8'b11111110;
  assign CA = 1'b0;
  assign CB = 1'b0;
  assign CC = 1'b0;
  assign CD = 1'b0;
  assign CE = 1'b0;
  assign CF = 1'b0;
  assign CG = 1'b1;
  
  assign DP = 1'b0;
*/


    wire [7:0] char_data;
    wire       char_ready;

    mfp_uart_receiver mfp_uart_receiver
    (
        .clock      ( HCLK       ),
        .reset_n    ( HRESETn    ),
        .rx         ( UART_RX    ),
        .byte_data  ( char_data  ),
        .byte_ready ( char_ready )
    );                     

    wire        in_progress;
    wire        format_error;
    wire        checksum_error;
    wire [ 7:0] error_location;

    wire [31:0] write_address;
    wire [ 7:0] write_byte;
    wire        write_enable;

//    assign IO_RedLEDs = { in_progress, format_error, checksum_error, write_enable, write_address [31:0] };

    mfp_srec_parser mfp_srec_parser
    (
        .clock           ( HCLK           ),
        .reset_n         ( HRESETn        ),

        .char_data       ( char_data      ),
        .char_ready      ( char_ready     ), 

        .in_progress     ( in_progress    ),
        .format_error    ( format_error   ),
        .checksum_error  ( checksum_error ),
        .error_location  ( error_location ),

        .write_address   ( write_address  ),
        .write_byte      ( write_byte     ),
        .write_enable    ( write_enable   )
    );

    assign MFP_Reset_serialload = in_progress;

    wire [31:0] loader_HADDR;
    wire [ 2:0] loader_HBURST;
    wire        loader_HMASTLOCK;
    wire [ 3:0] loader_HPROT;
    wire [ 2:0] loader_HSIZE;
    wire [ 1:0] loader_HTRANS;
    wire [31:0] loader_HWDATA;
    wire        loader_HWRITE;

    mfp_srec_parser_to_ahb_lite_bridge mfp_srec_parser_to_ahb_lite_bridge
    (
        .clock          ( HCLK             ),
        .reset_n        ( HRESETn          ),
        .big_endian     ( SI_Endian        ),
    
        .write_address  ( write_address    ),
        .write_byte     ( write_byte       ),
        .write_enable   ( write_enable     ), 
    
        .HADDR          ( loader_HADDR     ),
        .HBURST         ( loader_HBURST    ),
        .HMASTLOCK      ( loader_HMASTLOCK ),
        .HPROT          ( loader_HPROT     ),
        .HSIZE          ( loader_HSIZE     ),
        .HTRANS         ( loader_HTRANS    ),
        .HWDATA         ( loader_HWDATA    ),
        .HWRITE         ( loader_HWRITE    )
    );

    mfp_ahb mfp_ahb
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
                         
        .HADDR            ( in_progress ? loader_HADDR     : HADDR     ),
        .HBURST           ( in_progress ? loader_HBURST    : HBURST    ),
        .HMASTLOCK        ( in_progress ? loader_HMASTLOCK : HMASTLOCK ),
        .HPROT            ( in_progress ? loader_HPROT     : HPROT     ),
        .HSIZE            ( in_progress ? loader_HSIZE     : HSIZE     ),
        .HTRANS           ( in_progress ? loader_HTRANS    : HTRANS    ),
        .HWDATA           ( in_progress ? loader_HWDATA    : HWDATA    ),
        .HWRITE           ( in_progress ? loader_HWRITE    : HWRITE    ),
                         
        .HRDATA           ( HRDATA          ),
        .HREADY           ( HREADY          ),
        .HRESP            ( HRESP           ),
        .SI_Endian        ( SI_Endian       ),
                                             
        .IO_Switch        ( IO_Switch       ),
        .IO_PB            ( IO_PB           ),
        .IO_LED           ( IO_LED          ),
        
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
        /////////////////////
        /////////////////////////////////
        // Interface to the Rojobot                    
        .IO_BotCtrl(IO_BotCtrl), 
        .IO_INT_ACK(IO_INT_ACK),
        
        .IO_BotInfo(IO_BotInfo),
        .IO_BotUpdt_Sync(IO_BotUpdt_Sync),     
        /////////////////////////////////
        
        //interface for player 2
        
                            // Interface for Player 2
        
        .IO_BotCtrl_2(IO_BotCtrl_2), //outputs of the mfp_sys
        .IO_INT_ACK_2(IO_INT_ACK_2),
        
        // synchronization for player 2                    
        
        .IO_BotInfo_2(IO_BotInfo_2), // inputs to the mfp_sys
        .IO_BotUpdt_Sync_2(IO_BotUpdt_Sync_2),
        
        
        .IO_PB_2(IO_PB_2) // NEW BUTTONS for Player 2),                    
        
    );

endmodule
