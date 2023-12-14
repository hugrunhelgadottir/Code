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
    
    input mult_mode,
    //input op1, op2, op3, op4, //for user to select answer in multiple choice
    input wire switch1,
   
       input wire RST_BTN,
       output reg VGA_HS_O,
       output reg VGA_VS_O,        // vertical sync output
       output reg [3:0] VGA_R,
       output reg [3:0] VGA_G,
       output reg [3:0] VGA_B,
       
       output [6:0] SEG,
       output [7:0] AN,
       output DP,
       output reg [2:0] current_lives = 'b111,
       output wire right
       
       //input start_stop,
       //input reset
    );
    
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
   
   //code for lives
    wire wrong;
    reg [1:0] lives_update = 3;
    
    //code for multiple choice
   //wire [2:0] right_option_index;
   
   //following wires to decide which vga screen to display
   wire VGA_HS_O_eq, VGA_HS_O_game_over, VGA_HS_O_mult;
   wire VGA_VS_O_eq, VGA_VS_O_game_over, VGA_VS_O_mult;
   wire [3:0] VGA_R_eq, VGA_R_game_over, VGA_R_mult;
   wire [3:0] VGA_G_eq, VGA_G_game_over, VGA_G_mult;
   wire [3:0] VGA_B_eq, VGA_B_game_over, VGA_B_mult;
   //ayyyyooooo the different vgas worrkkkkkkkkk
   
   
   reg [1:0] game_state = 2'b00; 
   reg [1:0] game_state_next;
   reg [3:0] debouncer_count;
   reg [1:0] start_button_counter = 0;
   //le fsm:
    always @(posedge clock) begin           
        case (game_state)
            2'b00: begin // idle state
                reset = 0;
                start_stop = 0;
                if (START_STOP_GAME_BUTTON == 1)
                    game_state_next <= 2'b01; // Move to the running state if start_button 
                else
                    game_state_next <= 2'b00; //wait for start_button
            end
            
            2'b01: begin // Running state
                start_stop = 1;
                if (counter == 100_000_000 * 10) begin // "clock divider" logic
                    reset <= 1;
                    start_stop <= 0;
                    counter <= 0;
                end else begin
                    counter <= (new_ques) ? 0 :(counter + 1);
                    reset <= (new_ques) ? 1 : 0;
                    start_stop <= (new_ques) ? 0 : 1;
                end
                
                if (lives_update == 0) begin
                    game_state_next <= 2'b11; //KABOOM
                end
                else begin
                    if (START_STOP_GAME_BUTTON && debouncer_count == 4) begin //if noise detected again at 4th cycle
                        game_state_next <= 2'b01;
                        debouncer_count <= debouncer_count + 1;
                    end
                    else if (START_STOP_GAME_BUTTON)
                        if (start_button_counter == 0) begin
                            game_state_next <= 2'b01;
                            start_button_counter <= start_button_counter + 1;
                        end
                        else if (start_button_counter == 4) begin
                             game_state_next <= 2'b11; //if the user pauses the game, it ends
                        end
                    else begin
                        game_state_next <= 2'b01;
                        debouncer_count <= 0; //THE DEBOUNCERRR WORKKSSS YALL 
                    end
                end
            end
            
            2'b11 : begin
              //GAME OVER!!!
              //UR BAD AT MATHHH /:[
              reset = 0;
              start_stop = 0;
            end
        endcase //DEBOUNCER WORKS YALL WWWOOOPPPPP WHOOOP i wanna sleep
    end
    
    always @(posedge clock) begin //look vga switch.... ta daaaaaaa
         VGA_HS_O = ((game_state_next == 0) || (game_state_next == 1)) ? (mult_mode) ? VGA_HS_O_mult : VGA_HS_O_eq : VGA_HS_O_game_over;
         VGA_VS_O = ((game_state_next == 0) || (game_state_next == 1)) ? (mult_mode) ? VGA_VS_O_mult : VGA_VS_O_eq : VGA_VS_O_game_over;
         VGA_R = ((game_state_next == 0) || (game_state_next == 1)) ? (mult_mode) ? VGA_R_mult : VGA_R_eq : VGA_R_game_over;
         VGA_G = ((game_state_next == 0) || (game_state_next == 1)) ? (mult_mode) ? VGA_G_mult : VGA_G_eq : VGA_G_game_over;
         VGA_B = ((game_state_next == 0) || (game_state_next == 1)) ? (mult_mode) ? VGA_B_mult : VGA_B_eq : VGA_B_game_over;
         game_state <= game_state_next;
    end

top_module vga_equation(.CLK(clock), .RST_BTN(RST_BTN), .rand_num(a), .rand_num_2(b), .mode(mode), .VGA_HS_O(VGA_HS_O_eq), .VGA_VS_O(VGA_VS_O_eq), .VGA_R(VGA_R_eq), .VGA_G(VGA_G_eq), .VGA_B(VGA_B_eq));
game_over_screen game_over_sc(.CLK(clock), .RST_BTN(RST_BTN), .VGA_HS_O(VGA_HS_O_game_over), .VGA_VS_O(VGA_VS_O_game_over), .VGA_R(VGA_R_game_over), .VGA_G(VGA_G_game_over), .VGA_B(VGA_B_game_over));
mult_choice_screen mc_screen(.CLK(clock), .generate_input(reset), .switch1(switch1), .mode(mode), .RST_BTN(RST_BTN), .VGA_HS_O(VGA_HS_O_mult), .VGA_VS_O(VGA_VS_O_mult),  .VGA_R(VGA_R_mult), .VGA_G(VGA_G_mult), .VGA_B(VGA_B_mult));
//... .right_option_index(right_option_index));

//MULTIPLE CHOICE CODE:
//WE DID NOT HAVE TIME TO COMPLETE THIS MODE SO WE HARD CODED HE RIGHT ANSWER TO ALWAYS BE 4
//TH HYPOTEHTICAL CODE BELOW IS AS FOLLOWS
/*always@(*) begin
    if (op4 == 1 && right_option_index == 4)
        //increment points
    else if (op3 == 1 && right_option_index == 3)
        //increment points
    else if (op2 == 1 && right_option_index == 2)
        //increment points
    else if (op1 == 1 && right_option_index == 1)
        //increment points
end*/


LFSR RNG(.clock(clock), .reset(reset), .generate_input(reset), .random_num({a,b}));
FSM fsm(.clock(clock), .reset(reset), .start_stop(start_stop), .kb_data(kb_data), .kb_clk(kb_clk), .right(right), .SEG(SEG), .AN(AN), .DP(DP), .user_answer(kb_result), .new_ques(new_ques));
alu enter(.c_in(c_in), .mode(mode), .result(result), .c_out(c_out), .a(a), .b(b));


answer_check answer_check(.result(result), .kb_result(kb_result), .new_ques(new_ques), .right(right));
always @(*) begin
        if (wrong == 1) begin
            lives_update <= lives_update - 1;
            case (lives_update)
                2 : begin current_lives[0] = ~current_lives[0]; end
                1 : begin current_lives[1] = ~current_lives[1]; end
                0 : begin current_lives[2] = ~current_lives[2]; end
            endcase
        end
end


endmodule
