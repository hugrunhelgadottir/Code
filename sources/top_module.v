`timescale 1ns / 1ps


module top_module(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         //add inputs to display
    //input wire generate_input,
    input [2:0] rand_num,
    input [2:0] rand_num_2,
    input wire [1:0] mode,
    output wire VGA_HS_O,      // horizontal sync output
    output wire VGA_VS_O,      // vertical sync output
    output reg [3:0] VGA_R,    // 4-bit VGA red output
    output reg [3:0] VGA_G,    // 4-bit VGA green output
    output reg [3:0] VGA_B   // 4-bit VGA blue output
    //output reg [2:0] rand_num_out
    //output reg [2:0] rand_num2_out
    );

   wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video //FOR VGA
   
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
    
   // wire [2:0] rand_num;
   // wire [2:0] rand_num_2;
   
   // LFSR RNG (.clock(CLK), .reset(RST_BTN), .generate_input(generate_input), .random_num({rand_num,rand_num_2}));
    
    wire [9:0] a1_x_size = 30;
    wire [9:0] a1_y_size = 10;
    wire [9:0] a1_x_start = 80;
    wire [9:0] a2_x_start = 280;
    wire [8:0] a1_y_start = 225;
    wire [9:0] a1_x_offset = x - a1_x_start;
    wire [9:0] a2_x_offset = x - a2_x_start;
    wire [9:0] a1_y_offset = y - a1_y_start;
    wire [9:0] b1_x_size = 10;
    wire [9:0] b1_y_size = 30;
    wire [9:0] b1_x_start = 110;
    wire [9:0] b2_x_start = 310;
    wire [8:0] b1_y_start = 235;
    wire [9:0] b1_x_offset = x - b1_x_start;
    wire [9:0] b2_x_offset = x - b2_x_start;
    wire [9:0] b1_y_offset = y - b1_y_start;
    wire [9:0] g1_x_size = 30;
    wire [9:0] g1_y_size = 10;
    wire [9:0] g1_x_start = 80;
    wire [9:0] g2_x_start = 280;
    wire [8:0] g1_y_start = 265;
    wire [9:0] g1_x_offset = x - g1_x_start;
    wire [9:0] g2_x_offset = x - g2_x_start;
    wire [9:0] g1_y_offset = y - g1_y_start;
    wire [9:0] e1_x_size = 10;
    wire [9:0] e1_y_size = 30;
    wire [9:0] e1_x_start = 70;
    wire [9:0] e2_x_start = 270;
    wire [8:0] e1_y_start = 275;
    wire [9:0] e1_x_offset = x - e1_x_start;
    wire [9:0] e2_x_offset = x - e2_x_start;
    wire [9:0] e1_y_offset = y - e1_y_start;
    wire [9:0] d1_x_size = 30;
    wire [9:0] d1_y_size = 10;
    wire [9:0] d1_x_start = 80;
    wire [9:0] d2_x_start = 280;
    wire [8:0] d1_y_start = 305;
    wire [9:0] d1_x_offset = x - d1_x_start;
    wire [9:0] d2_x_offset = x - d2_x_start;
    wire [9:0] d1_y_offset = y - d1_y_start;
    wire [9:0] f1_x_size = 10;
    wire [9:0] f1_y_size = 30;
    wire [9:0] f1_x_start = 70;
    wire [9:0] f2_x_start = 270;
    wire [8:0] f1_y_start = 235;
    wire [9:0] f1_x_offset = x - f1_x_start;
    wire [9:0] f2_x_offset = x - f2_x_start;
    wire [9:0] f1_y_offset = y - f1_y_start;
    wire [9:0] c1_x_size = 10;
    wire [9:0] c1_y_size = 30;
    wire [9:0] c1_x_start = 110;
    wire [9:0] c2_x_start = 310;
    wire [8:0] c1_y_start = 275;
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
    default : draw2 = 0;
    endcase
    end
    
    reg ans_square;
    wire [9:0] square_size = 100;
    wire [9:0] square_x_start = 500;
    wire [9:0] square_y_start = 225;
    wire [9:0] x_offset = x - square_x_start;
    wire [9:0] y_offset = y - square_y_start;
    always @(*) begin
        if (x_offset >= 0 && x_offset < square_size && y_offset >= 0 && y_offset < square_size) 
            begin
            ans_square = 1'b1;
            end
        else begin
            ans_square = 1'b0;
        end
    end
    
    reg equal;
    wire [9:0] equal_x1_start = 390;
    wire [9:0] equal_y1_start = 245;
    wire [9:0] equal_x2_start = 390;
    wire [9:0] equal_y2_start = 270;
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
   wire [9:0] plus1_y_start = 245;
   wire [9:0] plus2_y_start = 280;
   wire [9:0] plus_x_size = 12;
   wire [9:0] plus_y_size = 20;
   wire [9:0] plus_x_offset = x - plus_x_start;
   wire [9:0] plus1_y_offset = y - plus1_y_start;
   wire [9:0] plus2_y_offset = y - plus2_y_start;
   wire [9:0] mode_y_start = 265;
   wire [9:0] x_size = 40;
   wire [9:0] y_size = 15;
   wire [9:0] x_mult_size = 20;
   wire [9:0] y_mult_size = 25;
   wire [9:0] mult_x_start = 180;
   wire [9:0] mult_y_start = 255;
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
        if (mult_x_offset >= 0 && mult_x_offset < x_mult_size && mult_y_offset >= 0 && mult_y_offset < x_mult_size)
        sign = 1'b1;
        else
        sign = 1'b0;
           end
    default : sign = 0;
    endcase
    end
 
    
      
    always @ (*) begin
        if (draw | draw2 | ans_square | sign | equal) begin
            VGA_R = 4'b1111;
            VGA_G = 4'b1111;
            VGA_B = 4'b1111;
    end
    else begin
            VGA_R = 4'b0000;
            VGA_G = 4'b0000;
            VGA_B = 4'b0000;
            end
            end
endmodule
    
