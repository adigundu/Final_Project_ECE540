`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2019 04:17:00 PM
// Design Name: 
// Module Name: colorizer
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


module colorizer(
    input [1:0] world_pixel,
    input [1:0] icon_pixel,
    input [1:0] icon_pixel_2,
    input video_on,
    input sw_debounced_8,
    
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B
    );
    
    reg [3:0] VGA_R_d;
    reg [3:0] VGA_G_d;
    reg [3:0] VGA_B_d;
    
    always_comb
    begin
        VGA_R <= VGA_R_d;
        VGA_G <= VGA_G_d;
        VGA_B <= VGA_B_d;    
    // turn off the video if out of range
        if(video_on == 0)
        begin
            VGA_R[3:0] <= 4'b0000;
            VGA_G[3:0] <= 4'b0000;
            VGA_B[3:0] <= 4'b0000;
        end
        else
        if(icon_pixel == 2'b00)
        begin
        // draw out the pixels for the world map
            case(world_pixel)
            // for the background - all white
                2'b00:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b1111;
                end
                2'b01:
            // for the black  line - all black
                begin
                    VGA_R_d[3:0] <= 4'b0000;
                    VGA_G_d[3:0] <= 4'b0000;
                    VGA_B_d[3:0] <= 4'b0000;
                end
            // for the obstruction(wall) - all red
                2'b10:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b0000;
                    VGA_B_d[3:0] <= 4'b0000;
                end
                2'b11:
                begin
                    VGA_R_d[3:0] <= 4'b0000;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b0000;
                end 
                default:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b1111;
                end
            endcase  
        end  
        else
        begin
        if(icon_pixel == 2'b11) // green rojobot
        begin
            VGA_R_d[3:0] <= 4'b0000;
            VGA_G_d[3:0] <= 4'b1111;
            VGA_B_d[3:0] <= 4'b0000;        
        end
        else
        if(icon_pixel == 2'b10) // blue/purple direction
        begin
            VGA_R_d[3:0] <= 4'b0010;
            VGA_G_d[3:0] <= 4'b0000;
            VGA_B_d[3:0] <= 4'b1111;        
        end  
        
        // for player 2:
        else
        if(icon_pixel_2 == 2'b00)
        begin
        // draw out the pixels for the world map
            case(world_pixel)
            // for the background - all white
                2'b00:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b1111;
                end
                2'b01:
            // for the black  line - all black
                begin
                    VGA_R_d[3:0] <= 4'b0000;
                    VGA_G_d[3:0] <= 4'b0000;
                    VGA_B_d[3:0] <= 4'b0000;
                end
            // for the obstruction(wall) - all red
                2'b10:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b0000;
                    VGA_B_d[3:0] <= 4'b0000;
                end
                2'b11:
                begin
                    VGA_R_d[3:0] <= 4'b0000;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b0000;
                end 
                default:
                begin
                    VGA_R_d[3:0] <= 4'b1111;
                    VGA_G_d[3:0] <= 4'b1111;
                    VGA_B_d[3:0] <= 4'b1111;
                end
            endcase  
        end  
        else
        begin
        if(icon_pixel_2 == 2'b11) // green rojobot
        begin
            VGA_R_d[3:0] <= 4'b0000;
            VGA_G_d[3:0] <= 4'b1111;
            VGA_B_d[3:0] <= 4'b0000;        
        end
        else
        if(icon_pixel_2 == 2'b10) // blue/purple direction
        begin
            VGA_R_d[3:0] <= 4'b0010;
            VGA_G_d[3:0] <= 4'b0000;
            VGA_B_d[3:0] <= 4'b1111;        
        end  
        
        
        end //end of video on      
    end
endmodule
