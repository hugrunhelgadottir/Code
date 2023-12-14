`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 07:21:12 PM
// Design Name: 
// Module Name: points_counter_tb
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

module points_counter_tb;

  // Inputs
  reg clk;
  reg rst;
  reg right;

  // Outputs
  wire [3:0] units_counter;
  wire [3:0] tens_counter;
  wire [2:0] life;

  // Instantiate the DUT (Device Under Test)
  points_counter dut (
    .clk(clk),
    .rst(rst),
    .right(right),
    .units_counter(units_counter),
    .tens_counter(tens_counter),
    .life(life)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initial stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    right = 0;

    // Apply reset
    #10;
    rst = 0;

    // Release reset
    #10;
    rst = 1;
    right = 1; 
    // Simulate some clock cycles
    #20;

    // Test scenarios
    // Simulate correct answers triggering right signal
    right = 0;
    #10;
    // At positive edges of right signal, units and tens counters should increment
    right = 1; 
    // Simulate incorrect answers not triggering right signal
    #10 right = 0;
    #10;
    // At positive edges of clock, life should decrement
    #10 right = 1; 
    // More test scenarios can be added here
  end

endmodule
