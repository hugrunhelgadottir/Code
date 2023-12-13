`timescale 1ns / 1ps

module mult_choice_screen(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    //input wire [2:0] correct_answer,
    input wire generate_input,
    input wire [1:0] mode,
    input switch1, 
    input wire RST_BTN,         //add inputs to display
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,        // vertical sync output
    output reg [3:0] VGA_R,    // 4-bit VGA red output
    output reg [3:0] VGA_G,    // 4-bit VGA green output
    output reg [3:0] VGA_B,     // 4-bit VGA blue output
    output reg [3:0] correct_answer
    );
    wire [3:0] option_1; 
    wire [3:0] option_2; 
    wire [3:0] option_3;
    wire [3:0] option_4;
    reg [2:0] rand_num;
    reg [2:0] rand_num_2;
   wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
   multiple_options get_opt(.correct_answer(correct_answer), .option_1(option_1), .option_2(option_2), .option_3(option_3), .option_4(option_4));
  // rand_num_gen RNG (.clock(CLK), .reset(rst), .generate_input(generate_input), .random_num({rand_num, rand_num_2}));
    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)begin
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000
    end

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511


    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O),
        .o_vs(VGA_VS_O),
        .o_x(x),
        .o_y(y)
    );    

always @ (*) begin
    if (switch1 && mode == 2'b10) begin
        rand_num <= 3'b010;
        rand_num_2 <= 3'b011;
        correct_answer <= 4'b0110;
        end else if (!switch1 && mode == 2'b10) begin
        rand_num <= 3'b001;
        rand_num_2 <= 3'b111;
        correct_answer <= 4'b0111;
        end else if (switch1 && mode == 2'b01) begin
        rand_num <= 3'b110;
        rand_num_2 <= 3'b010;
        correct_answer <= 4'b0100;
        end else if (!switch1 && mode == 2'b01) begin
        rand_num <= 3'b101;
        rand_num_2 <= 3'b011;
        correct_answer <= 4'b0010;
        end else if (switch1 && mode == 2'b00) begin
        rand_num <= 3'b110;
        rand_num_2 <= 3'b010;
        correct_answer <= 4'b1000;
        end else if (!switch1 && mode == 2'b00) begin
        rand_num <= 3'b101;
        rand_num_2 <= 3'b100;
        correct_answer <= 4'b1001;
        end else begin
        rand_num <= 3'b000;
        rand_num_2 <= 3'b000;
        correct_answer <= 4'b0000;
        end
end


    wire [9:0] a1_x_size = 30;
    wire [9:0] a1_y_size = 10;
    wire [9:0] a1_x_start = 80;
    wire [9:0] a2_x_start = 280;
    wire [8:0] a1_y_start = 65;
    wire [9:0] a1_x_offset = x - a1_x_start;
    wire [9:0] a2_x_offset = x - a2_x_start;
    wire [9:0] a1_y_offset = y - a1_y_start;
    wire [9:0] b1_x_size = 10;
    wire [9:0] b1_y_size = 30;
    wire [9:0] b1_x_start = 110;
    wire [9:0] b2_x_start = 310;
    wire [8:0] b1_y_start = 75;
    wire [9:0] b1_x_offset = x - b1_x_start;
    wire [9:0] b2_x_offset = x - b2_x_start;
    wire [9:0] b1_y_offset = y - b1_y_start;
    wire [9:0] g1_x_size = 30;
    wire [9:0] g1_y_size = 10;
    wire [9:0] g1_x_start = 80;
    wire [9:0] g2_x_start = 280;
    wire [8:0] g1_y_start = 105;
    wire [9:0] g1_x_offset = x - g1_x_start;
    wire [9:0] g2_x_offset = x - g2_x_start;
    wire [9:0] g1_y_offset = y - g1_y_start;
    wire [9:0] e1_x_size = 10;
    wire [9:0] e1_y_size = 30;
    wire [9:0] e1_x_start = 70;
    wire [9:0] e2_x_start = 270;
    wire [8:0] e1_y_start = 115;
    wire [9:0] e1_x_offset = x - e1_x_start;
    wire [9:0] e2_x_offset = x - e2_x_start;
    wire [9:0] e1_y_offset = y - e1_y_start;
    wire [9:0] d1_x_size = 30;
    wire [9:0] d1_y_size = 10;
    wire [9:0] d1_x_start = 80;
    wire [9:0] d2_x_start = 280;
    wire [8:0] d1_y_start = 145;
    wire [9:0] d1_x_offset = x - d1_x_start;
    wire [9:0] d2_x_offset = x - d2_x_start;
    wire [9:0] d1_y_offset = y - d1_y_start;
    wire [9:0] f1_x_size = 10;
    wire [9:0] f1_y_size = 30;
    wire [9:0] f1_x_start = 70;
    wire [9:0] f2_x_start = 270;
    wire [8:0] f1_y_start = 75;
    wire [9:0] f1_x_offset = x - f1_x_start;
    wire [9:0] f2_x_offset = x - f2_x_start;
    wire [9:0] f1_y_offset = y - f1_y_start;
    wire [9:0] c1_x_size = 10;
    wire [9:0] c1_y_size = 30;
    wire [9:0] c1_x_start = 110;
    wire [9:0] c2_x_start = 310;
    wire [8:0] c1_y_start = 115;
    wire [9:0] c1_x_offset = x - c1_x_start;
    wire [9:0] c2_x_offset = x - c2_x_start;
    wire [9:0] c1_y_offset = y - c1_y_start;
    reg draw;
    reg draw2;
    
    always @ (*) begin
    case(rand_num)
    0: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
    (e1_x_offset >= 0 && e1_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        1: begin 
   if ((b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        2: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e1_x_offset >= 0 && e1_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        3: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) |
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | 
   (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        4: begin 
   if ((b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | 
(c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        5: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | 
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        6: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) |
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e1_x_offset >= 0 && e1_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        7: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
 (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        8: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e1_x_offset >= 0 && e1_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
        9: begin 
   if ((a1_x_offset >= 0 && a1_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b1_x_offset >= 0 && b1_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g1_x_offset >= 0 && g1_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) |
   (d1_x_offset >= 0 && d1_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c1_x_offset >= 0 && c1_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f1_x_offset >= 0 && f1_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw = 1'b1;
   else
   draw = 1'b0;
    end
    default : draw = 0;
    endcase
    end
    
    always @ (*) begin
    case(rand_num_2)
    0: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
    (e2_x_offset >= 0 && e2_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        1: begin 
   if ((b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        2: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e2_x_offset >= 0 && e2_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        3: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) |
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | 
   (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        4: begin 
   if ((b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | 
(c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        5: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | 
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        6: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) |
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e2_x_offset >= 0 && e2_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        7: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
 (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        8: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) | (e2_x_offset >= 0 && e2_x_offset < e1_x_size && e1_y_offset >= 0 && e1_y_offset < e1_y_size) | 
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
        9: begin 
   if ((a2_x_offset >= 0 && a2_x_offset < a1_x_size && a1_y_offset >= 0 && a1_y_offset < a1_y_size) | (b2_x_offset >= 0 && b2_x_offset < b1_x_size && b1_y_offset >= 0 && b1_y_offset < b1_y_size) | 
   (g2_x_offset >= 0 && g2_x_offset < g1_x_size && g1_y_offset >= 0 && g1_y_offset < g1_y_size) |
   (d2_x_offset >= 0 && d2_x_offset < d1_x_size && d1_y_offset >= 0 && d1_y_offset < d1_y_size) | (c2_x_offset >= 0 && c2_x_offset < c1_x_size && c1_y_offset >= 0 && c1_y_offset < c1_y_size) |
   (f2_x_offset >= 0 && f2_x_offset < f1_x_size && f1_y_offset >= 0 && f1_y_offset < f1_y_size))
   draw2 = 1'b1;
   else
   draw2 = 1'b0;
    end
    default : draw = 0;
    endcase
    end
    
    reg equal;
    wire [9:0] equal_x1_start = 390;
    wire [9:0] equal_y1_start = 85;
    wire [9:0] equal_x2_start = 390;
    wire [9:0] equal_y2_start = 110;
    wire [9:0] equal_x_size = 40;
    wire [9:0] equal_y_size = 15;
    wire [9:0] x1_offset = x - equal_x1_start;
    wire [9:0] y1_offset = y - equal_y1_start;
    wire [9:0] x2_offset = x - equal_x2_start;
    wire [9:0] y2_offset = y - equal_y2_start;
    always @(*) begin
        if ((x1_offset >= 0 && x1_offset < equal_x_size && y1_offset >= 0 && y1_offset < equal_y_size) |
        (x2_offset >= 0 && x2_offset < equal_x_size && y2_offset >= 0 && y2_offset < equal_y_size)) 
            begin
            equal = 1'b1;
            end
        else begin
            equal = 1'b0;
    end
    end
    
   reg sign;
   wire [9:0] mode_x_start = 180;
   wire [9:0] plus_x_start = 194;
   wire [9:0] plus1_y_start = 85;
   wire [9:0] plus2_y_start = 120;
   wire [9:0] plus_x_size = 12;
   wire [9:0] plus_y_size = 20;
   wire [9:0] plus_x_offset = x - plus_x_start;
   wire [9:0] plus1_y_offset = y - plus1_y_start;
   wire [9:0] plus2_y_offset = y - plus2_y_start;
   wire [9:0] mode_y_start = 105;
   wire [9:0] x_size = 40;
   wire [9:0] y_size = 15;
   wire [9:0] x_mult_size = 20;
   wire [9:0] y_mult_size = 25;
   wire [9:0] mult_x_start = 180;
   wire [9:0] mult_y_start = 95;
   wire [9:0] mult_x_offset = x - mult_x_start;
   wire [9:0] mult_y_offset = y - mult_y_start;
   wire [9:0] offset_x = x - mode_x_start;
   wire [9:0] offset_y = y - mode_y_start;
   
   
    
     always @ (*) begin
    case(mode)
    0: begin
        if ((offset_x >= 0 && offset_x < x_size && offset_y >= 0 && offset_y < y_size) | 
            (plus_x_offset >= 0 && plus_x_offset < plus_x_size && plus1_y_offset >= 0 && plus1_y_offset < plus_y_size) | 
            (plus_x_offset >= 0 && plus_x_offset < plus_x_size && plus2_y_offset >= 0 && plus2_y_offset < plus_y_size))
            sign = 1'b1;
            else
            sign = 1'b0;
            end
    1: begin 
        if (offset_x >= 0 && offset_x < x_size && offset_y >= 0 && offset_y < y_size)
        sign = 1'b1;
        else
        sign = 1'b0;
           end
    2: begin 
        if (mult_x_offset >= 0 && mult_x_offset < x_mult_size && mult_y_offset >= 0 && mult_y_offset < y_mult_size)
        sign = 1'b1;
        else
        sign = 1'b0;
           end
    default : sign = 0;
    endcase
    end
    
    // CODE FOR THE 4 MULTIPLE CHOICE FRAMES
   reg frame;
   wire [9:0] frame1_x_start = 40;
   wire [9:0] frame2_x_start = 180;
   wire [9:0] frame3_x_start = 320;
   wire [9:0] frame4_x_start = 460;
   wire [9:0] frame1_x2_start = 130;
   wire [9:0] frame2_x2_start = 270;
   wire [9:0] frame3_x2_start = 410;
   wire [9:0] frame4_x2_start = 550;
   wire [9:0] frame1_y_start = 240;
   wire [9:0] frame1_y2_start = 370;
   wire [9:0] frame1_y_start2 = 250;
   wire [9:0] frame1_size = 100; // 80 pixels for the width of the number which is 50 pixels so 15 pixels on each side
   wire [9:0] frame1_size2 = 10;
   wire [9:0] frame1_y_size = 10;
   wire [9:0] frame1_y2_size = 120; // the number is vertically 90 bits so this way we have 15 pixels on top and bottom of each number
   wire [9:0] frame1_x_offset = x - frame1_x_start;
   wire [9:0] frame2_x_offset = x - frame2_x_start;
   wire [9:0] frame3_x_offset = x - frame3_x_start;
   wire [9:0] frame4_x_offset = x - frame4_x_start;
   wire [9:0] frame1_x2_offset = x - frame1_x2_start;
   wire [9:0] frame2_x2_offset = x - frame2_x2_start;
   wire [9:0] frame3_x2_offset = x - frame3_x2_start;
   wire [9:0] frame4_x2_offset = x - frame4_x2_start;
   wire [9:0] frame1_y_offset = y - frame1_y_start;
   wire [9:0] frame1_y2_offset = y - frame1_y2_start;
   wire [9:0] frame1_y2_offset2 = y - frame1_y_start2;
   
    always @(*) begin
        if ((frame1_x_offset >= 0 && frame1_x_offset < frame1_size && frame1_y_offset >= 0 && frame1_y_offset < frame1_y_size) |
        (frame1_x_offset >= 0 && frame1_x_offset < frame1_size && frame1_y2_offset >= 0 && frame1_y2_offset < frame1_y_size) | (frame2_x_offset >= 0 && frame2_x_offset < frame1_size && frame1_y_offset >= 0 && frame1_y_offset < frame1_y_size) |
         (frame3_x_offset >= 0 && frame3_x_offset < frame1_size && frame1_y2_offset >= 0 && frame1_y2_offset < frame1_y_size) | (frame4_x_offset >= 0 && frame4_x_offset < frame1_size && frame1_y_offset >= 0 && frame1_y_offset < frame1_y_size) | 
         (frame4_x_offset >= 0 && frame4_x_offset < frame1_size && frame1_y2_offset >= 0 && frame1_y2_offset < frame1_y_size) | (frame3_x_offset >= 0 && frame3_x_offset < frame1_size && frame1_y_offset >= 0 && frame1_y_offset < frame1_y_size) |
         (frame2_x_offset >= 0 && frame2_x_offset < frame1_size && frame1_y2_offset >= 0 && frame1_y2_offset < frame1_y_size) | (frame1_x_offset >= 0 && frame1_x_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) |
         (frame2_x2_offset >= 0 && frame2_x2_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | (frame1_x2_offset >= 0 && frame1_x2_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | 
         (frame3_x_offset >= 0 && frame3_x_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | (frame3_x2_offset >= 0 && frame3_x2_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | 
         (frame4_x_offset >= 0 && frame4_x_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | (frame4_x2_offset >= 0 && frame4_x2_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size) | 
         (frame2_x_offset >= 0 && frame2_x_offset < frame1_size2 && frame1_y2_offset2 >= 0 && frame1_y2_offset2 < frame1_y2_size))
            begin
            frame = 1'b1;
            end
        else begin
            frame = 1'b0;
    end
    end
    
    wire [9:0] mc1_a1_x_start = 75; //multiple choice 1
    wire [9:0] mc2_a1_x_start = 215; //multiple choice 2
    wire [9:0] mc3_a1_x_start = 355; // ---||---
    wire [9:0] mc4_a1_x_start = 495;
    wire [8:0] mc_a1_y_start = 265;
    wire [9:0] mc1_a1_x_offset = x - mc1_a1_x_start;
    wire [9:0] mc2_a1_x_offset = x - mc2_a1_x_start;
    wire [9:0] mc3_a1_x_offset = x - mc3_a1_x_start;
    wire [9:0] mc4_a1_x_offset = x - mc4_a1_x_start;
    wire [9:0] mc_a1_y_offset = y - mc_a1_y_start;
    wire [9:0] mc1_b1_x_start = 105;
    wire [9:0] mc2_b1_x_start = 245;
    wire [9:0] mc3_b1_x_start = 385;
    wire [9:0] mc4_b1_x_start = 525;
    wire [8:0] mc_b1_y_start = 275;
    wire [9:0] mc1_b1_x_offset = x - mc1_b1_x_start;
    wire [9:0] mc2_b1_x_offset = x - mc2_b1_x_start;
    wire [9:0] mc3_b1_x_offset = x - mc3_b1_x_start;
    wire [9:0] mc4_b1_x_offset = x - mc4_b1_x_start;
    wire [9:0] mc_b1_y_offset = y - mc_b1_y_start;
    wire [9:0] mc1_g1_x_start = 75;
    wire [9:0] mc2_g1_x_start = 215;
    wire [9:0] mc3_g1_x_start = 355;
    wire [9:0] mc4_g1_x_start = 495;
    wire [8:0] mc_g1_y_start = 305;
    wire [9:0] mc1_g1_x_offset = x - mc1_g1_x_start;
    wire [9:0] mc2_g1_x_offset = x - mc2_g1_x_start;
    wire [9:0] mc3_g1_x_offset = x - mc3_g1_x_start;
    wire [9:0] mc4_g1_x_offset = x - mc4_g1_x_start;
    wire [9:0] mc_g1_y_offset = y - mc_g1_y_start;
    wire [9:0] mc1_e1_x_start = 65;
    wire [9:0] mc2_e1_x_start = 205;
    wire [9:0] mc3_e1_x_start = 345;
    wire [9:0] mc4_e1_x_start = 485;
    wire [8:0] mc_e1_y_start = 315;
    wire [9:0] mc1_e1_x_offset = x - mc1_e1_x_start;
    wire [9:0] mc2_e1_x_offset = x - mc2_e1_x_start;
    wire [9:0] mc3_e1_x_offset = x - mc3_e1_x_start;
    wire [9:0] mc4_e1_x_offset = x - mc4_e1_x_start;
    wire [9:0] mc_e1_y_offset = y - mc_e1_y_start;
    wire [9:0] mc1_d1_x_start = 75;
    wire [9:0] mc2_d1_x_start = 215;
    wire [9:0] mc3_d1_x_start = 355;
    wire [9:0] mc4_d1_x_start = 495;
    wire [8:0] mc_d1_y_start = 345;
    wire [9:0] mc1_d1_x_offset = x - mc1_d1_x_start;
    wire [9:0] mc2_d1_x_offset = x - mc2_d1_x_start;
    wire [9:0] mc3_d1_x_offset = x - mc3_d1_x_start;
    wire [9:0] mc4_d1_x_offset = x - mc4_d1_x_start;
    wire [9:0] mc_d1_y_offset = y - mc_d1_y_start;
    wire [9:0] mc1_f1_x_start = 65;
    wire [9:0] mc2_f1_x_start = 205;
    wire [9:0] mc3_f1_x_start = 345;
    wire [9:0] mc4_f1_x_start = 485;
    wire [8:0] mc_f1_y_start = 275;
    wire [9:0] mc1_f1_x_offset = x - mc1_f1_x_start;
    wire [9:0] mc2_f1_x_offset = x - mc2_f1_x_start;
    wire [9:0] mc3_f1_x_offset = x - mc3_f1_x_start;
    wire [9:0] mc4_f1_x_offset = x - mc4_f1_x_start;
    wire [9:0] mc_f1_y_offset = y - mc_f1_y_start;
    wire [9:0] mc1_c1_x_start = 105;
    wire [9:0] mc2_c1_x_start = 245;
    wire [9:0] mc3_c1_x_start = 385;
    wire [9:0] mc4_c1_x_start = 525;
    wire [8:0] mc_c1_y_start = 315;
    wire [9:0] mc1_c1_x_offset = x - mc1_c1_x_start;
    wire [9:0] mc2_c1_x_offset = x - mc2_c1_x_start;
    wire [9:0] mc3_c1_x_offset = x - mc3_c1_x_start;
    wire [9:0] mc4_c1_x_offset = x - mc4_c1_x_start;
    wire [9:0] mc_c1_y_offset = y - mc_c1_y_start;
    reg draw_mc1;
    reg draw_mc2;
    reg draw_mc3;
    reg draw_mc4;
    
    wire [3:0] box1_num; 
    assign box1_num = option_1; 
    
    wire [3:0] box2_num;
   assign box2_num = option_2; 

    wire [3:0] box3_num;
    assign box3_num = option_3; 

    wire [3:0] box4_num;
    assign box4_num = option_4; 

// CASE STATEMENT FOR THE NUMBER IN MULTIPLE CHOICE BOX 4
    always @ (*) begin
    case(box1_num)
    0: begin
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
    (mc1_e1_x_offset >= 0 && mc1_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
    (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
    (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        1: begin 
   if ((mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        2: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc1_e1_x_offset >= 0 && mc1_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        3: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
   (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        4: begin 
   if ((mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
(mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        5: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        6: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) |
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc1_e1_x_offset >= 0 && mc1_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        7: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
 (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        8: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc1_e1_x_offset >= 0 && mc1_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
        9: begin 
   if ((mc1_a1_x_offset >= 0 && mc1_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc1_b1_x_offset >= 0 && mc1_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc1_g1_x_offset >= 0 && mc1_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc1_d1_x_offset >= 0 && mc1_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc1_c1_x_offset >= 0 && mc1_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc1_f1_x_offset >= 0 && mc1_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc1 = 1'b1;
   else
   draw_mc1 = 1'b0;
    end
    default : draw_mc1 = 0;
    endcase
    end
    // CASE STATEMENT FOR THE NUMBER IN MULTIPLE CHOICE BOX 2
     always @ (*) begin
    case(box2_num)
    0: begin
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
    (mc2_e1_x_offset >= 0 && mc2_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
    (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
    (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        1: begin 
   if ((mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        2: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc2_e1_x_offset >= 0 && mc2_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        3: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
   (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        4: begin 
   if ((mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
(mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        5: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
   (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        6: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) |
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc2_e1_x_offset >= 0 && mc2_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        7: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
 (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        8: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc2_e1_x_offset >= 0 && mc2_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
        9: begin 
   if ((mc2_a1_x_offset >= 0 && mc2_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc2_b1_x_offset >= 0 && mc2_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc2_g1_x_offset >= 0 && mc2_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc2_d1_x_offset >= 0 && mc2_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc2_c1_x_offset >= 0 && mc2_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc2_f1_x_offset >= 0 && mc2_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc2 = 1'b1;
   else
   draw_mc2 = 1'b0;
    end
    default : draw_mc2 = 0;
    endcase
    end
    // CASE STATEMENT FOR THE NUMBER IN MULTIPLE CHOICE BOX 3
     always @ (*) begin
    case(box3_num)
    0: begin
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
    (mc3_e1_x_offset >= 0 && mc3_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
    (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
    (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        1: begin 
   if ((mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        2: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc3_e1_x_offset >= 0 && mc3_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        3: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
   (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        4: begin 
   if ((mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
(mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        5: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        6: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) |
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc3_e1_x_offset >= 0 && mc3_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        7: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
 (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        8: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc3_e1_x_offset >= 0 && mc3_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
        9: begin 
   if ((mc3_a1_x_offset >= 0 && mc3_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc3_b1_x_offset >= 0 && mc3_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc3_g1_x_offset >= 0 && mc3_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc3_d1_x_offset >= 0 && mc3_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc3_c1_x_offset >= 0 && mc3_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc3_f1_x_offset >= 0 && mc3_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc3 = 1'b1;
   else
   draw_mc3 = 1'b0;
    end
    default : draw_mc3 = 0;
    endcase
    end
    // CASE STATEMENT FOR THE NUMBER IN MULTIPLE CHOICE BOX 4
     always @ (*) begin
    case(box4_num)
    0: begin
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
    (mc4_e1_x_offset >= 0 && mc4_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
    (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
    (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        1: begin 
   if ((mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        2: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc4_e1_x_offset >= 0 && mc4_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        3: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | 
   (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        4: begin 
   if ((mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
(mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        5: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | 
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        6: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) |
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc4_e1_x_offset >= 0 && mc4_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        7: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
 (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        8: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) | (mc4_e1_x_offset >= 0 && mc4_e1_x_offset < e1_x_size && mc_e1_y_offset >= 0 && mc_e1_y_offset < e1_y_size) | 
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
        9: begin 
   if ((mc4_a1_x_offset >= 0 && mc4_a1_x_offset < a1_x_size && mc_a1_y_offset >= 0 && mc_a1_y_offset < a1_y_size) | (mc4_b1_x_offset >= 0 && mc4_b1_x_offset < b1_x_size && mc_b1_y_offset >= 0 && mc_b1_y_offset < b1_y_size) | 
   (mc4_g1_x_offset >= 0 && mc4_g1_x_offset < g1_x_size && mc_g1_y_offset >= 0 && mc_g1_y_offset < g1_y_size) |
   (mc4_d1_x_offset >= 0 && mc4_d1_x_offset < d1_x_size && mc_d1_y_offset >= 0 && mc_d1_y_offset < d1_y_size) | (mc4_c1_x_offset >= 0 && mc4_c1_x_offset < c1_x_size && mc_c1_y_offset >= 0 && mc_c1_y_offset < c1_y_size) |
   (mc4_f1_x_offset >= 0 && mc4_f1_x_offset < f1_x_size && mc_f1_y_offset >= 0 && mc_f1_y_offset < f1_y_size))
   draw_mc4 = 1'b1;
   else
   draw_mc4 = 1'b0;
    end
    default : draw_mc4 = 0;
    endcase
    end
 
    always @ (*) begin
        if (draw | draw2 | sign | equal | draw_mc1 | draw_mc2 | draw_mc3 | draw_mc4 ) begin
            VGA_R = 4'b1111;
            VGA_G = 4'b1111;
            VGA_B = 4'b1111;
    end else if (frame) begin
            VGA_R = 4'b0000;
            VGA_G = 4'b0000;
            VGA_B = 4'b1111;
    end else begin
            VGA_R = 4'b0000;
            VGA_G = 4'b0000;
            VGA_B = 4'b0000;
            end
            end
            endmodule
