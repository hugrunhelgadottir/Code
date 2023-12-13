`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 08:21:51 PM
// Design Name: 
// Module Name: vga_top
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


module vga_top(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         //add inputs to display
    output reg VGA_HS_O,       // horizontal sync output
    output reg VGA_VS_O,        // vertical sync output
    output reg [3:0] VGA_R,    // 4-bit VGA red output
    output reg [3:0] VGA_G,    // 4-bit VGA green output
    output reg [3:0] VGA_B,    // 4-bit VGA blue output
     input wire [1:0] mode,
     input wire [2:0] a,
    input wire [2:0] b,
    input generate_input,
    input switch1,
    input level
    );
    
    
    
    //equation outputs
     wire VGA_HS_O_eq;      
     wire VGA_VS_O_eq;    
     wire [3:0] VGA_R_eq; 
     wire [3:0] VGA_G_eq;  
     wire [3:0] VGA_B_eq;
     
     //multiple choice outputs
     wire VGA_HS_O_mc;      
     wire VGA_VS_O_mc;    
     wire [3:0] VGA_R_mc; 
     wire [3:0] VGA_G_mc;  
     wire [3:0] VGA_B_mc;
    
    top_module vga_equation(.CLK(CLK), .RST_BTN(RST_BTN), .rand_num(a), .rand_num_2(b), .mode(mode), .VGA_HS_O(VGA_HS_O_eq), .VGA_VS_O(VGA_VS_O_eq), .VGA_R(VGA_R_eq), .VGA_G(VGA_G_eq), .VGA_B(VGA_B_eq));
    //mult_choice_screen multiple_choice_vga(.CLK(CLK), .generate_input(generate_input), .mode(mode), .switch1(switch1), .RST_BTN(RST_BTN), .VGA_HS_O(VGA_HS_O_mc), .VGA_VS_O(VGA_VS_O_mc), .VGA_R(VGA_R_mc), .VGA_G(VGA_G_mc), .VGA_B(VGA_B_mc));
    //game_over_screen game_over_vga(.CLK(CLK), .RST_BTN(RST_BTN), .mode(mode), , .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));
    mult_choice_screen multiple_choice_vga(.CLK(CLK), .RST_BTN(RST_BTN), .VGA_HS_O(VGA_HS_O_mc), .VGA_VS_O(VGA_VS_O_mc), .VGA_R(VGA_R_mc), .VGA_G(VGA_G_mc), .VGA_B(VGA_B_mc));


always @(posedge CLK) begin
     case (level)
        1'b0: begin VGA_HS_O = VGA_HS_O_eq;      
         VGA_VS_O = VGA_VS_O_eq;    
         VGA_R = VGA_R_eq; 
         VGA_G = VGA_G_eq;  
         VGA_B = VGA_B_eq;
         end
         
      1'b1: begin
        VGA_HS_O = VGA_HS_O_mc;      
         VGA_VS_O = VGA_VS_O_mc;    
         VGA_R = VGA_R_mc; 
         VGA_G = VGA_G_mc;  
         VGA_B = VGA_B_mc;
         end
         
     endcase
 end
    
endmodule
