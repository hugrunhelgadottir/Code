`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 05:26:24 PM
// Design Name: 
// Module Name: answer_check_tb
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

module answer_check_tb;

  // Inputs
  reg [6:0] result;
  reg [6:0] kb_result;
  reg new_ques;
   reg [2:0] current_lives; 
  // Outputs
  wire right;
  wire [2:0] life;
  wire game_over;

  // Instantiate the DUT (Device Under Test)
  answer_check dut (
    .result(result),
    .kb_result(kb_result),
    .new_ques(new_ques),
    .right(right),
    .current_lives(current_lives), 
    .life(life)
   // .game_over(game_over)
  );

  // Clock generation
  reg clock = 0;
  always #5 clock = ~clock;

  // Test stimulus
  initial begin
    // Initialize inputs
    result = 7'b0000000; // Change values as needed for testing
        kb_result = 7'b0000001;
    new_ques = 0;
    current_lives = 7; 
    // Stimulate new question signal
    #10;
    kb_result = 7'b0000000;

    new_ques = 1;

    // Simulate some clock cycles
    #20;
    new_ques = 0; 
    // Test different scenarios
    // Example scenario where answer is correct
    result = 7'b1010101; // Set result and kb_result to same value for a correct answer
    kb_result = 7'b1010101;
    #10;
    // At the positive edge of new_ques, the right signal should be 1
    new_ques = 1; 
    #10 new_ques = 0; 
    // Example scenario where answer is incorrect
    result = 7'b1111111; // Set result and kb_result to different values for an incorrect answer
    kb_result = 7'b0000000;
    #10;
    // At the positive edge of new_ques, the right signal should be 0 and decrement life

    // More test scenarios can be added here

    // End simulation
    $finish;
  end

endmodule
