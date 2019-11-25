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

module worldselect ( input wire [7:0]Sensors_reg, output logic map_change, output logic [15:0]score );


endmodule

module counter ();
input rst, inc;
output [7:0] botscore;

always @ (negedge inc or rst)

	if (rst)
		begin
		botscore = '0;
endmodule

 