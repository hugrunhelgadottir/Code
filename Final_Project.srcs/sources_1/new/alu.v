`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:47:31 PM
// Design Name: 
// Module Name: FSM
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


module alu(
 input c_in,
  input [1:0] mode, //this is a switch on the FPGA (2 switches)
  output [6:0] result,
  output c_out,
  input  [2:0] a,
  input  [2:0] b
);
//wire b2;
//wire a2;
 
  reg [6:0] result_reg;
  reg c_out_reg;
  always @(a, b or mode) begin
        case (mode)
          2'b00: {c_out_reg, result_reg} = a + b;
          2'b01: {c_out_reg, result_reg} = a - b;
          2'b10: {c_out_reg, result_reg} = a * b;
        endcase
    // Assign to outputs
    //{c_out, result} = {c_out_reg, result_reg};
  end
  
  assign c_out = c_out_reg;
  assign result = result_reg;
  
  endmodule