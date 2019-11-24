`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2019 07:54:54 PM
// Design Name: 
// Module Name: addr_scaler
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


module addr_scaler(		
	input	[11:0]	pixel_row, pixel_column,
	output  [6:0]	pixel_row_scaled, pixel_column_scaled
    );
    
    assign pixel_row_scaled        = pixel_row/6;
    assign pixel_column_scaled     = pixel_column/8;
    
endmodule
