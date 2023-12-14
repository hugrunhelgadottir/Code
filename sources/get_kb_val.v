`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:53:49 PM
// Design Name: 
// Module Name: get_kb_val
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


module get_kb_val(
  input clk, kb_data, kb_clk,
    //input timer_flag, //resets keyboard when timer for that question runs out
    output [6:0] cathode_disp,
    output [6:0] user_answer_out,
    output reg enter_flag_out
    );
    
    
    wire [4:0] pressed_key;
    wire back_space_flag, enter_flag, done_reading_bitstream;
    reg [6:0] cathode;
    reg dp = 1;
    assign cathode_disp = cathode;
    reg [4:0] display_key;
    
    reg [6:0] user_answer = 0;
    assign user_answer_out = user_answer;
    reg [6:0] total_val = 0;
   
    keyboard kb(clk,kb_clk,kb_data,pressed_key,done_reading_bitstream,back_space_flag,enter_flag);
    
    always @(posedge clk) begin
       enter_flag_out <= enter_flag;
    end
    
    always @(done_reading_bitstream or enter_flag) begin
    
        //if (back_space_flag)
           //user_answer = user_answer - pressed_key;
        //else
        
        if (done_reading_bitstream) begin 
        //display_key = (back_space_flag) ? ((user_answer - (user_answer % 10)) % 10) : pressed_key;
           display_key <= (enter_flag) ? 'd0: pressed_key;
           total_val <= (enter_flag) ? 'd0: (user_answer*('b1010));
            case (display_key)
                'd0: cathode <= 7'b0000001;
                'd1: cathode <= 7'b1001111;
                'd2: cathode <= 7'b0010010;
                'd3: cathode <= 7'b0000110;
                'd4: cathode <= 7'b1001100;
                'd5: cathode <= 7'b0100100;
                'd6: cathode <= 7'b0100000;
                'd7: cathode <= 7'b0001111;
                'd8: cathode <= 7'b0000000;
                'd9: cathode <= 7'b0000100;
               'd10: cathode <= 7'b1111111;
             endcase
         end
         else begin
            user_answer <= total_val + display_key;
         end
    end
    
     
   //always @(*) $display("Input: %b",kb_input);
       
   //always @(err_flag)
   //$display("Error, invalid input");
endmodule
