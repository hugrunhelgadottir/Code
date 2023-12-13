`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 04:52:24 PM
// Design Name: 
// Module Name: alu_tb
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

module alu_tb;

  // Inputs
  reg c_in;
  reg [1:0] mode;
  reg [6:0] a;
  reg [6:0] b;

  // Outputs
  wire [6:0] result;
  wire c_out;

  // Instantiate the ALU module
  alu uut (
    .c_in(c_in),
    .mode(mode),
    .result(result),
    .c_out(c_out),
    .a(a),
    .b(b)
  );

  // Clock
  reg clk = 0;
  always #5 clk = ~clk;

  // Test stimuli
  initial begin
    // Test case 1: Addition (mode = 00)
    c_in = 0;
    mode = 2'b00;
    a = 8; // Change input values as needed
    b = 4;
    #10; // Wait for some time

    // Test case 2: Subtraction (mode = 01)
    c_in = 0;
    mode = 2'b01;
    a = 12; // Change input values as needed
    b = 5;
    #10; // Wait for some time

    // Test case 3: Multiplication (mode = 10)
    c_in = 0;
    mode = 2'b10;
    a = 7; // Change input values as needed
    b = 3;
    #10; // Wait for some time

    // Add more test cases if needed

   // $finish; // End simulation
  end

endmodule