`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:52:11 PM
// Design Name: 
// Module Name: answer_check
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


module answer_check(
    result,
    kb_result,
    new_ques,
    right,
    current_lives,
    life
    );
    // result is pulled from the ALU
    input [6:0] result;
    input [6:0] kb_result; //output byte from keyboard is 8 bits
    input new_ques; //is flagged when timer for round runs out and new question is generated
    output reg right; // point is a binary 1 or 0 for right or wrong
    input [2:0] current_lives;
    output reg [2:0] life;
    
    
    always @(new_ques) begin //user has to press enter for their answer to be read
       if(result == kb_result) begin
            right <= 1; 
       end        
       else begin
            right <= 0;
            //life <= current_lives - 1;
        end
    end 
endmodule
