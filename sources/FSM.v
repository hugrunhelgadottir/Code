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


module FSM(
    input clock,
    input reset,
    input start_stop,
    input kb_data, kb_clk,
    input right,
    output reg [6:0] SEG, //cathode
    output reg [7:0] AN = 8'b11111111, //anode
    output reg DP,
    output [6:0] user_answer,
    output new_ques //goes off is user presses enter OR if timer runs out
    //output enter_flag
    //output wire [3:0] num_hund
    );
    
    wire [15:0] sixteen_bit_number;
    counter counter(.CLK100MHZ(clock), .reset(reset), .start_stop(start_stop), .counter(sixteen_bit_number));
    
    reg [1:0] state = 0; // stores state of FSM
    wire [3:0] num_thous, num_tens, num_ones;
    wire [3:0] num_hund;
    // num_hund
    assign num_thous = (sixteen_bit_number / 1000) % 10;
    assign num_hund = (sixteen_bit_number / 100) % 10;
    assign num_tens = (sixteen_bit_number / 10) % 10;          
    assign num_ones = sixteen_bit_number % 10;
        
    wire [3:0] units_counter;
    wire [3:0] tens_counter;
   
    points_counter points_counter(.clk(clock) ,.rst(reset), .right(right), .units_counter(units_counter), .tens_counter(tens_counter));

    // Parameters for segment patterns
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9
    parameter DASH  = 7'b111_1110;  // a dash
   
   
    // To select each digit in turn
    reg [2:0] anode_select;         // 3 bit counter for selecting each of 4 digits
    reg [16:0] anode_timer;         // counter for digit refresh
   
    // Logic for controlling digit select and digit timer
    always @(posedge clock) begin
        // 1ms x 8 displays = 8ms refresh period
        if(anode_timer == 99_999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
            anode_timer <= 0;                   // 10ns x 100,000 = 1ms
            anode_select <=  anode_select + 1;
        end
        /*if (reset) begin
            anode_timer <= 0;
            anode_select <=  anode_select + 1;
        end*/
        else
            anode_timer <=  anode_timer + 1;
    end
   
    wire [6:0] seg_buffer;
    wire enter_flag;
    get_kb_val get_val(clock,kb_data,kb_clk,seg_buffer,user_answer, enter_flag);
    
     reg new_ques_flag;
        always @(enter_flag) begin
            if (enter_flag == 1)
                new_ques_flag <= 'd1;
            else
                new_ques_flag <= 'd0;
        end
        assign new_ques = new_ques_flag;
   
    // Logic for driving the 8 bit anode output based on digit select
    always @(anode_select) begin
        case(anode_select)
            3'o0 : AN = 8'b1111_1110;
            3'o1 : AN = 8'b1111_1101;
            3'o2 : AN = 8'b1111_1011;
            3'o3 : AN = 8'b1111_0111;
            3'o4 : AN = 8'b1110_1111;
            3'o5 : AN = 8'b1101_1111;
            3'o6 : AN = 8'b1011_1111;
            3'o7 : AN = 8'b0111_1111;
        endcase
    end
   
    always @(*) begin
        case(anode_select)
            3'o0 :begin
                        case(num_ones)
                            4'b0000 : SEG = ZERO;
                            4'b0001 : SEG = ONE;
                            4'b0010 : SEG = TWO;
                            4'b0011 : SEG = THREE;
                            4'b0100 : SEG = FOUR;
                            4'b0101 : SEG = FIVE;
                            4'b0110 : SEG = SIX;
                            4'b0111 : SEG = SEVEN;
                            4'b1000 : SEG = EIGHT;
                            4'b1001 : SEG = NINE;
                        endcase
                        DP = 1'b1;
                    end
                       
            3'o1 : begin
                        case(num_tens)
                            4'b0000 : SEG = ZERO;
                            4'b0001 : SEG = ONE;
                            4'b0010 : SEG = TWO;
                            4'b0011 : SEG = THREE;
                            4'b0100 : SEG = FOUR;
                            4'b0101 : SEG = FIVE;
                            4'b0110 : SEG = SIX;
                            4'b0111 : SEG = SEVEN;
                            4'b1000 : SEG = EIGHT;
                            4'b1001 : SEG = NINE;
                        endcase
                        DP = 1'b0;
                    end
                   
            3'o2 : begin
                        case(num_hund)
                            4'b0000 : SEG = ZERO;
                            4'b0001 : SEG = ONE;
                            4'b0010 : SEG = TWO;
                            4'b0011 : SEG = THREE;
                            4'b0100 : SEG = FOUR;
                            4'b0101 : SEG = FIVE;
                            4'b0110 : SEG = SIX;
                            4'b0111 : SEG = SEVEN;
                            4'b1000 : SEG = EIGHT;
                            4'b1001 : SEG = NINE;
                        endcase
                        DP = 1'b1;
                    end
                   
            3'o3 : begin
                        SEG = DASH;
                        DP = 1'b1;
                    end
            3'o4 :  begin  
                        case(units_counter)
                            4'b0000 : SEG = ZERO;
                            4'b0001 : SEG = ONE;
                            4'b0010 : SEG = TWO;
                            4'b0011 : SEG = THREE;
                            4'b0100 : SEG = FOUR;
                            4'b0101 : SEG = FIVE;
                            4'b0110 : SEG = SIX;
                            4'b0111 : SEG = SEVEN;
                            4'b1000 : SEG = EIGHT;
                            4'b1001 : SEG = NINE;
                        endcase
                        DP = 1'b1;
                    end
                       
           3'o5 :  begin  
                        case(tens_counter)
                            4'b0000 : SEG = ZERO;
                            4'b0001 : SEG = ONE;
                            4'b0010 : SEG = TWO;
                            4'b0011 : SEG = THREE;
                            4'b0100 : SEG = FOUR;
                            4'b0101 : SEG = FIVE;
                            4'b0110 : SEG = SIX;
                            4'b0111 : SEG = SEVEN;
                            4'b1000 : SEG = EIGHT;
                            4'b1001 : SEG = NINE;
                        endcase
                        DP = 1'b1;
                    end
             
            3'o6 : begin SEG = DASH;
                    DP = 1'b1; end

            3'o7 : //this will be the keyboard input
                    begin
                        SEG <= seg_buffer;
                    DP = 1'b1; end
       endcase
      end
      

endmodule
