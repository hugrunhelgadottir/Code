`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:54:39 PM
// Design Name: 
// Module Name: keyboard
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


module keyboard(//keyboard plugged into ps2 port
    input clk,
    input kb_clk, kb_data,
    output reg [4:0] pressed_key,
    output reg done_reading_bitstream, //flag if bistream for keypress is complete (8 bits to read)
    output reg back_space_flag,
    output reg enter_flag //flag to stop saving sequence of key presses
    );
    
    reg kb_clk_out;
    reg kb_data_out;
   
    reg [4:0] clk_cnt;
    reg [4:0] data_cnt; //synchronizes the bit count to get code of key pressed
   
    //clk and data condition
    reg clk_cond = 0;
    reg data_cond = 0;
   
    always @(posedge clk) begin
        if (kb_clk == clk_cond)begin
            if (clk_cnt == 19)
                kb_clk_out <= kb_clk;
            else  
                clk_cnt <= clk_cnt + 1;
        end
        else begin
            clk_cnt <= 4'b0000; //reset clk counter
            clk_cond <= kb_clk;
        end
        if (kb_data == data_cond) begin
            if (data_cnt == 19)
                kb_data_out <= kb_data;
            else
                data_cnt <= data_cnt + 1;
        end
        else begin
            data_cnt <= 4'b0000;
            data_cond <= kb_data;
        end
    end
   
   
    reg [3:0] sync_bit_cnt; //synchronizes the bit count to get code of key pressed
    reg [7:0] num_code;
   
    always@(negedge kb_clk) begin
   
        if(sync_bit_cnt < 10)
                sync_bit_cnt <= sync_bit_cnt+1;
        else if(sync_bit_cnt == 10)
                sync_bit_cnt <= 0; //reset for new key
               
        case(sync_bit_cnt)
            1  :    num_code[0] <= kb_data_out;
            2  :    num_code[1] <= kb_data_out;
            3  :    num_code[2] <= kb_data_out;
            4  :    num_code[3] <= kb_data_out;
            5  :    num_code[4] <= kb_data_out;
            6  :    num_code[5] <= kb_data_out;
            7  :    num_code[6] <= kb_data_out;
            8  :    num_code[7] <= kb_data_out;
           
            9  :    done_reading_bitstream <= 1; //reading current key is ended
            10 :    done_reading_bitstream <= 0; //begin reading next key
       endcase  
   end
   
   //interpret key code
   //add key code to 7 bit output register to compare to expected value
   always @(done_reading_bitstream, num_code) begin
        if (done_reading_bitstream) begin
            case(num_code)
                'h45    :   pressed_key = 'b0000;
                'h16    :   pressed_key = 'b0001;
                'h1e    :   pressed_key = 'b0010;
                'h26    :   pressed_key = 'b0011;
                'h25    :   pressed_key = 'b0100;
                'h2e    :   pressed_key = 'b0101;
                'h36    :   pressed_key = 'b0110;
                'h3d    :   pressed_key = 'b0111;
                'h3e    :   pressed_key = 'b1000;
                'h46    :   pressed_key = 'b1001;
                'h66    :   back_space_flag = 1;
                'h5a    :   enter_flag = 1;
                default :   pressed_key = 'b1010;
            endcase
        end
        else begin
            enter_flag = 0;  
            back_space_flag = 0;
        end
    end

endmodule
