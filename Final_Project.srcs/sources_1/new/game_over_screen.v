`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 12:55:18 PM
// Design Name: 
// Module Name: game_over_screen
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


module game_over_screen(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         //add inputs to display
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,        // vertical sync output
    output reg [3:0] VGA_R,    // 4-bit VGA red output
    output reg [3:0] VGA_G,    // 4-bit VGA green output
    output reg [3:0] VGA_B     // 4-bit VGA blue output

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
    reg draw;
    wire [9:0] x_size = 240;
    wire [9:0] y_size = 30;
    wire [9:0] y2_size = 60;
    wire [9:0] x2_size = 25;
    wire [9:0] x2_start = 170;
    wire [9:0] y2_start = 290;
    wire [9:0] x3_start = 385;
    wire [9:0] y3_start = 290;
    wire [9:0] x_start = 170;
    wire [9:0] y_start = 260;
    wire [9:0] x_offset = x - x_start;
    wire [9:0] y_offset = y - y_start;
    wire [9:0] x2_offset = x - x2_start;
    wire [9:0] x3_offset = x - x3_start;
    wire [9:0] y2_offset = y - y2_start;
    
    wire [9:0] x4_size = 25;
    wire [9:0] y4_size = 65;
    wire [9:0] y4_start = 130;
    wire [9:0] x4_start = 230;
    wire [9:0] x5_start = 320;
    wire [9:0] x4_offset = x - x4_start;
    wire [9:0] x5_offset = x - x5_start;
    wire [9:0] y4_offset = y - y4_start;
    
    always @(*) begin
        if ((x_offset >= 0 && x_offset < x_size && y_offset >= 0 && y_offset < y_size) | (x2_offset >= 0 && x2_offset < x2_size && y2_offset >= 0 && y2_offset < y2_size) | 
        (x3_offset >= 0 && x3_offset < x2_size && y2_offset >= 0 && y2_offset < y2_size) | (x4_offset >= 0 && x4_offset < x4_size && y4_offset >= 0 && y4_offset < y4_size) | 
        (x5_offset >= 0 && x5_offset < x4_size && y4_offset >= 0 && y4_offset < y4_size))
            begin
            draw = 1'b1;
            end
        else begin
            draw = 1'b0;
    end
    end
    
    always @ (*) begin
        if (draw) begin
            VGA_R = 4'b1111;
            VGA_G = 4'b0000;
            VGA_B = 4'b0000;
    end
    else begin
            VGA_R = 4'b0000;
            VGA_G = 4'b0000;
            VGA_B = 4'b0000;
            end
            end
            
endmodule
