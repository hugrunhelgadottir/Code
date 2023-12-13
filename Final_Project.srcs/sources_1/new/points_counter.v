`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 09:51:23 PM
// Design Name: 
// Module Name: points_counter
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


module points_counter(
    input clk,
    input rst,
    input right,
    output reg [3:0] units_counter,
    output reg [3:0] tens_counter
    );
    reg [1:0] life_count = 2'b11;
    wire [3:0] result;
    wire [3:0] answer;
    //wire game_over;
    //reg [2:0] life;

    //answer_check check(.result(result), .answer(answer), .right(right), .life(life), .game_over(game_over));

reg [3:0] units_counter_buff = 0;
reg [3:0] tens_counter_buff = 0;

always @(posedge right) begin
    //life = 3'b111; 
  //if (right == 1) begin
      if (units_counter < 4'd9) begin
      units_counter_buff <= units_counter + 1;
    end else begin
      units_counter_buff <= 4'b0;
      if (tens_counter < 4'd9) begin
        tens_counter_buff <= tens_counter + 1;
      end else begin
        tens_counter_buff <= 4'b0;end end //end // Reset tens digit after 9
   /*if (right ==0)
           life_count = life_count - 1;
        case(life_count)
                2'b11: life = 3'b111; 
                2'b10: life = 3'b011;
                2'b01: life = 3'b001;  
                2'b00: begin life = 3'b000;end //game_over = 1; end
     endcase*/
      
end
  
always @(negedge right) begin
    units_counter <= units_counter_buff;
    tens_counter <= tens_counter_buff;
end

/*
always@(posedge clk)begin 
    if (right ==0)
           life_count = life_count - 1;
    case(life_count)
                2'b11: life = 3'b111; 
                2'b10: life = 3'b011;
                2'b01: life = 3'b001;  
                2'b00: begin life = 3'b000;end //game_over = 1; end
     endcase
     */
//end 
/*
              life_count = life_count - 1;
            case(life_count)
                2'b10: life = 3'b011;
                2'b01: life = 3'b001;  
                2'b00: begin life = 3'b000; game_over = 1; end
               // 3'b000: game_over = 1; 
*/
/*always @(posedge rst) begin
  if (rst) begin
    units_counter <= 4'b0;
    tens_counter <= 4'b0;
end
end*/

endmodule
