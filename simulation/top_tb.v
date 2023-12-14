`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2023 05:14:54 PM
// Design Name: 
// Module Name: top_tb
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

module top_tb;

  // Inputs
  reg clock;
  reg reset;
  reg start_stop;
  reg [1:0] mode;
  reg kb_data;
  reg kb_clk;
  reg RST_BTN;

  // Outputs
  wire VGA_HS_O;
  wire VGA_VS_O;
  wire [3:0] VGA_R;
  wire [3:0] VGA_G;
  wire [3:0] VGA_B;
  wire [6:0] SEG;
  wire [7:0] AN;
  wire DP;
  wire [2:0] life;
  wire right;
  wire game_over;

  // Instantiate the DUT (Device Under Test)
  top dut (
    .clock(clock),
    .reset(reset),
    .start_stop(start_stop),
    .mode(mode),
    .kb_data(kb_data),
    .kb_clk(kb_clk),
    .RST_BTN(RST_BTN),
    .VGA_HS_O(VGA_HS_O),
    .VGA_VS_O(VGA_VS_O),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .SEG(SEG),
    .AN(AN),
    .DP(DP),
    .life(life),
    .right(right),
    .game_over(game_over)
  );

  // Clock generation
  always #5 clock = ~clock;

  // Initial stimulus
  initial begin
    // Initialize inputs
    reset = 1;
    start_stop = 1;
    mode = 2'b00;
    kb_data = 0;
    kb_clk = 0;
    RST_BTN = 1;
    #20 kb_data = 4; 
    #20 kb_data = 2;
    #20 kb_data = 3;  
    $finish;
  end

endmodule