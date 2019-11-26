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
wire [15:0]score;
wire map_change;
wire [7:0] botscore1, botscore2;

// Score outputs.
assign botscore1 = score[15:8];
assign botscore2 = score[7:0];

// Inputs
reg clk, board_rst, map_rst;
reg [7:0]Sensors_reg1, Sensors_reg2;
reg [3:0] i;

scoreboard scoreboard(clk, Sensors_reg1, Sensors_reg2, board_rst, map_rst, map_change, score);

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
        board_rst = TRUE;
        repeat(IDLE_CLOCKS) @(negedge clk);
        board_rst = FALSE;
    end
    
// STimulus generation.
initial begin
    for(i = 0; i < 10; i=i+1) begin
        Sensors_reg1= 3'b111;
        Sensors_reg2 = 3'b111;
        repeat(10) @(negedge clk);
        Sensors_reg1 = 3'b010;
        Sensors_reg1 = 3'b111;
        if((i % 2) == 0)
            Sensors_reg2 = 3'b000;
        else
            Sensors_reg1 = 3'b000;
        repeat(10) @(negedge clk);
        repeat(1) @(negedge clk);
        map_rst = TRUE; // Board level reset after Mapchange asserted.
        repeat(1) @(negedge clk);
        map_rst = FALSE;
        repeat(10) @(negedge clk);
        Sensors_reg2 = 3'b111; 
        repeat(1) @(negedge clk);
        if(i % 5 == 0) board_rst = TRUE;
        repeat(1) @(negedge clk);
        if( board_rst == TRUE) board_rst = FALSE;
        Sensors_reg1= 3'b111;
        Sensors_reg2 = 3'b111;
        repeat(10) @(negedge clk);
        Sensors_reg1 = 3'b010;
        Sensors_reg1 = 3'b111;
        if((i % 3) == 0)
            Sensors_reg2 = 3'b000;
        else
            Sensors_reg1 = 3'b000;
        repeat(10) @(negedge clk);
        repeat(1) @(negedge clk);
        map_rst = TRUE; // Board level reset after Mapchange asserted.
        repeat(1) @(negedge clk);
        map_rst = FALSE;
        repeat(10) @(negedge clk);
        Sensors_reg2 = 3'b111; 
        repeat(1) @(negedge clk);
   end
      $stop;
   end
     

    
endmodule
