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
    wrong
    );
    // result is pulled from the ALU
    input [6:0] result;
    input [6:0] kb_result; //output byte from keyboard is 8 bits
    input new_ques; //is flagged when timer for round runs out and new question is generated
    output reg right; // point is a binary 1 or 0 for right or wrong
    output reg wrong; //so wrong is not flagged at initialization
    
    
    always @(new_ques) begin //user has to press enter ("new_ques" flag) for their answer to be read
        if (new_ques == 1) begin
            if(result == kb_result) begin
                right <= 1; 
                wrong <= 0;
            end        
            else begin
                right <= 0;
                wrong <= 1;
            end
        end
    end 
endmodule
