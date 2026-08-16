`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 01:00:17 PM
// Design Name:
// Module Name: mix_col
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


module mix_col(
    input  [31:0] column_in,  // Input column (4 bytes)
    output [31:0] column_out   // Output after MixColumns
);

    // Galois Field multiplication function
    function [7:0] gmul(input [7:0] a, input [7:0] b);
        int i;
        logic [7:0] p;  // product
        logic [7:0] hi_bit_set;
        p = 8'b00000000;
        for (i = 0; i < 8; i = i + 1) begin
            if (b[0]) p = p ^ a;  // if the LSB of b is set, XOR the current a
            hi_bit_set = a[7];    // store the high bit of a
            a = a << 1;            // multiply a by 2
            if (hi_bit_set) a = a ^ 8'h1b;  // reduce modulo x^8 + x^4 + x^3 + x + 1
            b = b >> 1;            // divide b by 2
        end
        gmul = p;
    endfunction

    // Combinational logic for MixColumns
    assign column_out[31:24] = gmul(column_in[31:24], 8'h02) ^
                                gmul(column_in[23:16], 8'h03) ^
                                gmul(column_in[15:8], 8'h01) ^
                                gmul(column_in[7:0], 8'h01);

    assign column_out[23:16] = gmul(column_in[31:24], 8'h01) ^
                                gmul(column_in[23:16], 8'h02) ^
                                gmul(column_in[15:8], 8'h03) ^
                                gmul(column_in[7:0], 8'h01);

    assign column_out[15:8]  = gmul(column_in[31:24], 8'h01) ^
                                gmul(column_in[23:16], 8'h01) ^
                                gmul(column_in[15:8], 8'h02) ^
                                gmul(column_in[7:0], 8'h03);

    assign column_out[7:0]   = gmul(column_in[31:24], 8'h03) ^
                                gmul(column_in[23:16], 8'h01) ^
                                gmul(column_in[15:8], 8'h01) ^
                                gmul(column_in[7:0], 8'h02);

endmodule

