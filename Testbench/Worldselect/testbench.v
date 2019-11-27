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
reg[3:0] p;
reg j;
reg k;

// DUT
worldselect worldselect1(.clk(clk), .reset(reset), .map_change(map_change), .map_select(map_select), .map_en(map_en));

// Initialize Monitor
initial
    begin
		// Displey scoreboard results
        $monitor($time,"\t i:%d \t j:%d \t k:%d \t reset:%d \t map_change:%d \t map_select:%d \n ", p, j, k, reset, map_change, map_select);
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
        clk = TRUE;
        repeat(IDLE_CLOCKS) @(negedge clk);
        clk = FALSE;
    end
	
// Stimulus generator
initial begin
    for( p = 0, j = 0, k = 0; p < 9; p = p + 1 )begin
        j = ~j;
        k = ~k;
        end
        
$stop;
end

endmodule