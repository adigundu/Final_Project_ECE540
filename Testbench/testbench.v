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
wire score, map_change;

// Inputs
reg clk, Sensors_reg1, Sensors_reg1, rst;

fsm scoreboard(clk, Sensors_reg1, Sensors_reg2, rst, map_change, score);

// Establish monitor block
initial
    begin
		// Displey scoreboard results
        $display("\tTime\tScore 1\tScore 2\n");
        $monitor($time,"\t%d\5%d\n", botscore1, botscore2);
    end
    
// Initiate free running clock.
initial
begin
    Clock = FALSE;
    forever #CLOCK_WIDTH Clock = ~Clock;
end

 // Reset for 2 cycles.
initial
    begin
        Reset = TRUE;
        repeat(IDLE_CLOCKS) @(negedge Clock);
        Reset = FALSE;
    end
    
// STimulus generation.
initial
    for(int i = 0; i < 10; i++)
    begin
        {S1,S2,S3} = 3'b000;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b001;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b010;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b011;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b100;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b101;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b110;
        repeat(10) @(negedge Clock);
        {S1,S2,S3} = 3'b111;
        repeat(1) @(negedge Clock);
        Reset = TRUE;
        repeat(1) @(negedge Clock);
        Reset = FALSE;
        
   $stop;
   end
      

    
endmodule
