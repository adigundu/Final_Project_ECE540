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
reg [3:0] map_en;

// Inputs
reg clk, reset, map_change;
reg [2:0] map_select;

// Stimulus index
reg [3:0] i;

// DUT
worldselect worldselect( clk, reset, map_change,  map_select,  map_en);

// Establish monitor block
initial
    begin
		// Displey scoreboard results
        $display("\tTime\ti\t\tScore 1\t\tScore 2\n");
        $monitor($time,"\t%d\t%d%d\n",i, botscore1, botscore2);
    end
    
// Initiate free running clock.
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
    
// STimulus generation.
initial begin
    for( i = 0; i < 10; i=i+1 ) begin
        repeat (1) @(negedge clk);
        map_select = 0;
        
        
   end
      $stop;
   end
     

    
endmodule
