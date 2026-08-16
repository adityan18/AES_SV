`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 11:17:35 AM
// Design Name:
// Module Name: galois
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

module galois(
    input [7:0] a,
    input [7:0] b,
    output [7:0] p
    );

    logic [7:0] p_reg = 0;
    logic [7:0] temp_a;
    logic [7:0] temp_b;
    int i;

    assign p = p_reg;

    always_comb begin
        temp_a = a;
        temp_b = b;
        p_reg = 0;

        // Perform Galois multiplication in GF(2^8)
        for (i = 0; i < 8; i = i + 1) begin
            if (temp_b[0] == 1'b1)
                p_reg = p_reg ^ temp_a; // XOR with the result

            // Shift temp_a to left by 1 and reduce if necessary
            if (temp_a[7] == 1'b1)
                temp_a = (temp_a << 1) ^ 8'h1b; // Reduce using the AES polynomial 0x11B
            else
                temp_a = temp_a << 1;

            temp_b = temp_b >> 1; // Shift b to the right
        end
    end
endmodule
