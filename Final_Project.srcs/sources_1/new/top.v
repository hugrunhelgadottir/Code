`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 11:25:27 AM
// Design Name: 
// Module Name: top
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

module top(
    input clock,
  
    input wire START_STOP_GAME_BUTTON,
    input wire [1:0] mode,
    input kb_data, kb_clk,
   
       input wire RST_BTN,
       output wire VGA_HS_O,
       output wire VGA_VS_O,        // vertical sync output
   
       output [3:0] VGA_R,
       output [3:0] VGA_G,
       output [3:0] VGA_B,
       output [6:0] SEG,
       output [7:0] AN,
       output DP,
       output reg [2:0] current_lives = 'b111,
       output wire right
    );
    
    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video //FOR VGA
    wire [2:0] a;
    wire [2:0] b;
    wire c_in;
    reg [3:0] point_total;
    wire [6:0] result;
    wire [6:0] kb_result;
    wire c_out;
    wire new_ques;
    wire game_over_flag = 0;
    
    reg reset;
    reg start_stop;
    reg [31:0] counter = 0; // 32-bit counter to time 10 seconds
   
   reg [1:0] game_state, game_state_next;
   reg [3:0] debouncer_count;
    
    
    always @(posedge clock) begin
            
        case (game_state)
            2'b00: begin // waiting for start_button
                reset = 0;
                start_stop = 0;
                if (START_STOP_GAME_BUTTON == 1)
                    game_state_next <= 2'b01; // Move to the running state if start_button 
                else
                    game_state_next <= 2'b00; //wait for start_button
            end
            
            2'b01: begin // Running state
                start_stop = 1;
                //reset <= 1; //start with not 0+0 values
                if (counter == 100_000_000 * 10) begin // clock divider
                    reset <= 1;
                    start_stop <= 0;
                    counter <= 0;
                end else begin
                    counter <= (new_ques) ? 0 :(counter + 1);
                    reset <= (new_ques) ? 1 : 0;
                    start_stop <= (new_ques) ? 0 : 1;
                end
                if (START_STOP_GAME_BUTTON && debouncer_count == 4) begin //if noise detected again at 4th cycle
                    game_state_next <= 2'b01;
                    debouncer_count <= debouncer_count + 1;
                end
                else if (START_STOP_GAME_BUTTON)
                    game_state_next <= 2'b00;
                else begin
                    game_state_next <= 2'b01;
                    debouncer_count <= 0;
                end
            end
        endcase //DEBOUNCER WORKS BAHAHHHAHHAAHAAHHA WWWOOOPPPPP WHOOOP i wanna sleep
    end
    
    always @(posedge clock) begin
        game_state <= game_state_next;
    end


wire [1:0] lives_update;
always @(new_ques) begin
    if (new_ques == 1) current_lives <= lives_update;
end

top_module vga_equation(.CLK(clock), .RST_BTN(rst), .rand_num(a), .rand_num_2(b), .mode(mode), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));
LFSR RNG(.clock(clock), .reset(reset), .generate_input(reset), .random_num({a,b}));
FSM fsm(.clock(clock), .reset(reset), .start_stop(start_stop), .kb_data(kb_data), .kb_clk(kb_clk), .right(right), .SEG(SEG), .AN(AN), .DP(DP), .user_answer(kb_result), .new_ques(new_ques));
alu enter(.c_in(c_in), .mode(mode), .result(result), .c_out(c_out), .a(a), .b(b));

answer_check answer_check(.result(result), .kb_result(kb_result), .new_ques(new_ques), .right(right), .current_lives(current_lives), .life(lives_update));
//game_over_screen game_over_sc(.CLK(clock), .RST_BTN(rst), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

//assign right_LED = right;



//vga_multiple_choice mc_screen(.CLK(clock), .a(a), .b(b), .mode(mode), .RST_BTN(RST_BTN), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O),  .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

//multiple_choice uut(.result(result), .optiona(optiona), .optionb(optionb), .optionc(optionc), .correct(correct));

endmodule
