//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 04:07:54 PM
// Design Name: 
// Module Name: blah
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

module scoreboard ( input clk, input wire [7:0]Sensors_reg1, input wire [7:0]Sensors_reg2, input rst, output logic map_change, output logic [15:0]score );
reg [7:0] bot_score1, bot_score2;
reg d1, d2, q1 = 0, q2 = 0, q3;

assign d1 = ~(Sensors_reg1[2] | Sensors_reg1[1] | Sensors_reg1[0] ) ;  // nor black line sensor values to check for black line presence
assign d2 = ~(Sensors_reg2[2] | Sensors_reg2[1] | Sensors_reg2[0] ) ;	// nor black line sensor values to check for black line presence
assign score = { bot_score1, bot_score2 };								// scores from both the bots
assign q3 = q1 | q2;													// whichever score appears first would trigger map change

always @ ( negedge d1 or posedge rst)						 // flag register which gets enabled when leaving the black line for rojobot1
	begin
		if (rst)
			q1 <= 0;								// flag is deasserted on reset
		else
			q1 <=1;									// flag is asserted on passing the black line 
	end
always @ ( negedge d2 or posedge rst)						// flag register which gets enabled when leaving the black line for rojobot2
	begin
		if (rst)
			q2 <= 0;								// flag is deasserted on reset
		else
			q2 <= 1;								// flag is asserted on passing the black line 
	end

always @ (posedge clk)
	begin	
		map_change <= q3;							// when one bot reaches the finish line then map_change is asserted to switch to next map
	end
counter botscore1 ( .clk(clk), .rst(rst), .inc(q1), .botscore(bot_score1)); // botscore of rojobot 1
counter botscore2 ( .clk(clk), .rst(rst), .inc(q2), .botscore(bot_score2)); // botscore of rojobot 2

	
endmodule

// module to keep track of score and bcd conversion to the seven seg display

module counter ();   
input logic rst, inc, clk;   
output logic [7:0] botscore;
reg [3:0] upper, lower;  							 // lower 2 and upper 2 digits of seven seg display 

always @ (posedge clk or posedge rst)
begin
	if (rst)
		begin
		botscore = '0;								// when reset, score is reset
		end
	else 
		begin 
			if ( lower == 9 )						// bcd checking
				begin
					lower = 0;
					upper = upper + 1;				// incrementing the tens digit if units digit is 9
				end
			else 
				lower = lower + 1;					// incrementing units digit
		end
end

assign botscore = { upper, lower };					// getting both the digits concatenated as 8 bit output
			
endmodule

 