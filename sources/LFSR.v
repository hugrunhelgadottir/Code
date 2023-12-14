`timescale 1ns / 1ps

module LFSR(
    input clock,
    input reset,
    input generate_input,
    output reg [11:0] random_num
    );
    reg [11:0] random;
    reg [11:0] random_done;
    reg [3:0] count;
    reg has_changed;

    wire feedback = random[11] ^ random[5] ^ random[3] ^ random[0];
    always @(posedge clock) begin
        if (reset) begin
            random <= 12'b111111111111; // An LFSR cannot have an all 0 clock
            count <= 0;
            has_changed = 0;
        end else begin
        random <= {random[10:0], feedback};
        count <= count + 1;
            if (count == 12) begin
                count <= 0;
                random_done <= random;
            end
        end
        if (generate_input == 1) begin
        if (has_changed == 0) begin
            has_changed <= 1;
            random_num <= random_done;
            end
        end else begin
            has_changed <= 0;
            random_num <= random_num;
        end
    end
endmodule
