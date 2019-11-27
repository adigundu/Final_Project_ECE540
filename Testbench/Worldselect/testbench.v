`timescale 1ns / 1ps

// ECE 540
// Michael Escue
// Final project
//
// Blocks modeled after examples given in Lecture 1 ECE 585.

module top();

parameter TRUE = 1'b1;
parameter FALSE = 1'b0;
parameter CLOCK_CYCLE = 20 ;
parameter CLOCK_WIDTH = CLOCK_CYCLE/2;
parameter IDLE_CLOCKS = 2;

// Outputs
wire [3:0] map_en;

// Inputs
reg clk;
reg reset; 
reg map_change; 
reg [1:0] map_select;

// Stimulus Variables
reg[3:0] i; // Main loop

// Initial Values
initial begin
    i = 0;
    map_change = 0;
    map_select = 0;
end

    
// DUT
  worldselect worldselect1(.clk(clk), .reset(reset), .map_change(map_change), .map_select(map_select), .map_en(map_en));

// Initialize Monitor
initial
    begin
		// Displey scoreboard results
        $monitor($time,"\t i:%d \t reset:%d \t map_change:%d \t map_select:%d \n ", i, reset, map_change, map_select);
    end
	
// Initialize free running clock.
initial
begin
    clk = FALSE;
    forever #CLOCK_WIDTH clk = ~clk;
end

// Reset for 2 cycles.
initial
    begin
        reset = TRUE;
        repeat(IDLE_CLOCKS) @(negedge clk);
        reset = FALSE;
    end
	
// Stimulus generator
initial begin
    for( i = 0 ; i < 9 ; i = i + 1 ) begin
        map_change = 0;
        repeat(1) @(negedge clk);
    
        if( i % 5 == 0) reset = 1;
        else reset = 0;
        repeat(3) @(negedge clk);
        
        if( i % 3 == 0) map_select = map_select + 1;
        else map_select = map_select;
        repeat(3) @(negedge clk);
        
        map_change = 1;
        repeat(1) @(negedge clk);
       
	end	
    $stop;
end

endmodule