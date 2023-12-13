`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:49:19 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input CLK100MHZ,
    input wire reset,
    input wire start_stop,
    output reg [15:0] counter = 0
    //output wire [3:0] num_hund
    //input wire [3:0] points
    );
    
    wire [3:0] num_hund;
    wire seconds_clock;// 1 Hz fast_clock;
    wire fsm_clock; //1 kHz
    clock_divider clock_div(CLK100MHZ, seconds_clock);
    faster_clock_divider fast_clock(CLK100MHZ, fsm_clock);// instantiate the clock divider
   
   
   reg is_running;
   assign num_hund = (counter / 100) % 10;

    always @(posedge seconds_clock) begin
        if (reset | num_hund) begin
            counter <= 4'b0000;
            is_running <= 0;
        end
        if (start_stop) begin
            is_running <= ~is_running;
        end
        if (is_running) begin
            counter <= counter +1;
        end

    end
    
/*always @(posedge CLK100MHZ) begin
    num_hund = (counter/100) % 10;
    if (num_hund == 4'b0001) begin
            counter <= 16'b0000000000000000; // Reset the main counter
        end
        end*/

endmodule