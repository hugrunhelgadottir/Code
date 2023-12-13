`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:45:01 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input in_clk,
    output reg out_clk = 0
    );
    
reg[32:0] count = 0;

// initialize everything to zero

always @(negedge in_clk)
begin
// increment count by one
count = count +1;
// if count equals to some big number (that you need to calculate),
if(count == 5000000) begin //5,000,000 when on board
//   then flip the output clock,
 out_clk <= ~out_clk;
//   and reset count to zero.
 count <= 0;
 end
end
 
endmodule
