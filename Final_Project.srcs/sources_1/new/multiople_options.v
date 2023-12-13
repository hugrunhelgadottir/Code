`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 03:40:09 PM
// Design Name: 
// Module Name: multiple_options
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


module multiple_options(
    input [3:0] correct_answer,
    output reg [3:0] option_1,
    output reg [3:0] option_2,
    output reg [3:0] option_3,
    output reg [3:0] option_4
    );
    
    
    
    
    always@(correct_answer)begin
    if (correct_answer == 0) begin
     option_1 = correct_answer + 1;
     option_2 = correct_answer + 2;
     option_3 = correct_answer + 3;
     option_4 = correct_answer;

    end else begin
    if (correct_answer == 8) begin
     option_1 = correct_answer + 1;
     option_2 = correct_answer - 1;
     option_3 = correct_answer - 2;
     option_4 = correct_answer;

    end else begin
    if (correct_answer == 9) begin
     option_1 = correct_answer - 1;
     option_2 = correct_answer - 2;
     option_3 = correct_answer - 3;
     option_4 = correct_answer;

    end else begin
     option_1 = correct_answer - 1;
     option_2 = correct_answer + 1;
     option_3 = correct_answer + 2;
     option_4 = correct_answer;

    end
    end
    end
    end
endmodule