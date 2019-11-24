`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 02:07:13 PM
// Design Name: 
// Module Name: icon
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


module icon(
    // location and information of the rojobot
    input      [7:0]    LocX_reg,         // output wire [7 : 0] LocX_reg
    input      [7:0]    LocY_reg,         // output wire [7 : 0] LocY_reg
    input      [7:0]    BotInfo_reg,      // output wire [7 : 0] BotInfo_reg

    // values for the pixel counters
    input      [11:0]   pixel_row_offset,        // DTG to icon
    input      [11:0]   pixel_column_offset,     // DTG to icon 
    
    output reg [1:0]    icon_pixel
    );
    
    wire     [11:0]   pixel_row;        // DTG to icon
    wire      [11:0]  pixel_column;     // DTG to icon 
    
    assign pixel_row = pixel_row_offset + 1;
    assign pixel_column = pixel_column_offset + 1;
    
    always_comb
    begin
    // limit the color for the rojobot to the 16x16 square/rectangle
    // use location x and y for reference
    // +2 and +3 for scaled down sizes from 16x16
        if ( (LocY_reg     <= pixel_row)     &&
             (pixel_row    <= LocY_reg + 2)  &&
             (LocX_reg     <= pixel_column)  &&
             (pixel_column <= LocX_reg + 2)  
            )
        begin
        // facing up right
            case(BotInfo_reg[2:0])
                3'b100:  // robot facing down
                begin
                    if (
                        (pixel_row    == LocY_reg + 2)  &&
                        (pixel_column == LocX_reg + 1)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere   
                end
                3'b101:  // bot facing downleft
                    if (
                        (pixel_row    == LocY_reg + 2)  &&
                        (pixel_column == LocX_reg)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b110:  // bot facing left
                    if (
                        (pixel_row    == LocY_reg + 1)  &&
                        (pixel_column == LocX_reg)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b111: // bot facing up left
                    if (
                        (pixel_row    == LocY_reg + 0)  &&
                        (pixel_column == LocX_reg)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b000:  // bot facing up
                    if (
                        (pixel_row    == LocY_reg + 0)  &&
                        (pixel_column == LocX_reg + 1)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b001:  // bot facing up right
                    if (
                        (pixel_row    == LocY_reg + 0)  &&
                        (pixel_column == LocX_reg + 2)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b010:  // bot facing right
                    if (
                        (pixel_row    == LocY_reg + 1)  &&
                        (pixel_column == LocX_reg + 2)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                3'b011:  // bot facing down right
                    if (
                        (pixel_row    == LocY_reg + 2)  &&
                        (pixel_column == LocX_reg + 2)  
                        )icon_pixel   <= 2'b10; // pointer color for direction
                    else icon_pixel   <= 2'b11; // green elsewhere 
                default:
                    icon_pixel   <= 2'b11;
            endcase
        end 
        else 
            icon_pixel <= 2'b00;
    end
    
endmodule
