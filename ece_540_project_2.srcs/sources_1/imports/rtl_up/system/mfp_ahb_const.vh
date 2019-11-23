// 
// mfp_ahb_const.vh
//
// Verilog include file with AHB definitions
// 

//---------------------------------------------------
// Physical bit-width of memory-mapped I/O interfaces
//---------------------------------------------------
`define MFP_N_LED             16
`define MFP_N_SW              16
`define MFP_N_PB              5

// Bit width size for 7 segment register/////////////
`define MFP_N_SEG             32


//---------------------------------------------------
// Memory-mapped I/O addresses
//---------------------------------------------------
`define H_LED_ADDR    			(32'h1f800000)
`define H_SW_ADDR   			(32'h1f800004)
`define H_PB_ADDR   			(32'h1f800008)

// 7 Segment adresses//////////////////////////////////////
`define IO_7SEGEN_N_MATCH        (7'hf7)  // top address bits

`define IO_7SEGEN_N             (32'h1f700000)  // enables
`define IO_7SEGEN_N_BOTTOM4     (32'h1f700004)  // bottom 4 segs
`define IO_7SEGEN_N_TOP4        (32'h1f700008)  // top 4 segs
`define IO_SEG_N                (32'h1f70000C)  // decimal pts


`define PORT_BOTINFO		    (32'h1f80000c)		// (i) Bot Info port
`define PORT_BOTCTRL		    (32'h1f800010)		// (o) Bot Control port
`define PORT_BOTUPDT		    (32'h1f800014)	    // (i) Bot Update port (Poll)
`define PORT_INTACK			    (32'h1f800018)		// (o) Bot Int Ack


`define PORT_BOTINFO_2		    (32'h1f80002c)		// (i) Bot Info port
`define PORT_BOTCTRL_2		    (32'h1f800020)		// (o) Bot Control port
`define PORT_BOTUPDT_2		    (32'h1f800024)	        // (i) Bot Update port (Poll)
`define PORT_INTACK_2		    (32'h1f800028)		// (o) Bot Int Ack 
`define P2_PORT_BTNS                (32'h1f80001c)              // address of p2 buttons


`define H_LED_IONUM   			(4'h0)
`define H_SW_IONUM  			(4'h1)
`define H_PB_IONUM  			(4'h2)


`define PORT_BOTINFO_IONUM      (4'h3) // (o) Bot Control port
`define PORT_BOTCTRL_IONUM      (4'h4) // (i) Bot Info port
`define PORT_BOTUPDT_IONUM      (4'h5) // (i) Bot Update port (Poll)
`define PORT_INTACK_IONUM       (4'h6) // (o) Bot Int Ack
//---------------------------------------------------
// RAM addresses
//---------------------------------------------------
`define H_RAM_RESET_ADDR 		(32'h1fc?????)
`define H_RAM_ADDR	 		    (32'h0???????)
`define H_RAM_RESET_ADDR_WIDTH  (8) 
`define H_RAM_ADDR_WIDTH		(16) 

`define H_RAM_RESET_ADDR_Match  (7'h7f)
`define H_RAM_ADDR_Match 		(1'b0)
`define H_LED_ADDR_Match		(7'h7e)

//---------------------------------------------------
// AHB-Lite values used by MIPSfpga core
//---------------------------------------------------

`define HTRANS_IDLE    2'b00
`define HTRANS_NONSEQ  2'b10
`define HTRANS_SEQ     2'b11

`define HBURST_SINGLE  3'b000
`define HBURST_WRAP4   3'b010

`define HSIZE_1        3'b000
`define HSIZE_2        3'b001
`define HSIZE_4        3'b010
