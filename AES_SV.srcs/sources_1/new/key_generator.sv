`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/16/2024 06:40:16 PM
// Design Name:
// Module Name: key_generator
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


module key_generator(
    input clk, /* Clock */
    input en, /* Enable */
    input [127:0] key,  /* Key Word Input */
    input [3:0] in_round, /* Input Round for Getting Key */

    output key_gen_done, /* Key Generation Complete Signal */
    output [127:0] key_out /* Round Key */
    );

    logic [7:0]full_key[0:3][0: 43]; /* Key for all 10 rounds */

    logic [31:0] in_word;
    logic [31:0] out_word;

    logic [127:0] key_out_reg;

    logic key_gen_done_flag;

    logic [3:0] round = 0;
    logic [5:0] index = 3;

    /* RCON Pre Computed */
    wire [7:0] rcon [0:9];   /* Rcon values for each round */

    /* INSTANTIATIONS */
    sub_word sw (.in_word(in_word), .out_word(out_word));

    /* ASSIGNMENTS */
    assign key_gen_done = (key_gen_done_flag == 1) ? 1'b1 : 1'b0;

    assign rcon[0] = 8'h01;
    assign rcon[1] = 8'h02;
    assign rcon[2] = 8'h04;
    assign rcon[3] = 8'h08;
    assign rcon[4] = 8'h10;
    assign rcon[5] = 8'h20;
    assign rcon[6] = 8'h40;
    assign rcon[7] = 8'h80;
    assign rcon[8] = 8'h1b;
    assign rcon[9] = 8'h36;

    assign in_word = {full_key[1][index], full_key[2][index], full_key[3][index], full_key[0][index]};

    assign key_out = key_out_reg;

    always_ff @( posedge clk ) begin : KEY_GEN_SM
        if(en) begin
            if(key_gen_done_flag != 1) begin
                round = round + 1;

                full_key[0][index + 1] = full_key[0][index - 3] ^ out_word[31-:8] ^ rcon[round - 1];
                full_key[1][index + 1] = full_key[1][index - 3] ^ out_word[23-:8] ^ 8'h0;
                full_key[2][index + 1] = full_key[2][index - 3] ^ out_word[15-:8] ^ 8'h0;
                full_key[3][index + 1] = full_key[3][index - 3] ^ out_word[7-:8] ^ 8'h0;

                full_key[0][index + 2] = full_key[0][index - 2] ^ full_key[0][index + 1];
                full_key[1][index + 2] = full_key[1][index - 2] ^ full_key[1][index + 1];
                full_key[2][index + 2] = full_key[2][index - 2] ^ full_key[2][index + 1];
                full_key[3][index + 2] = full_key[3][index - 2] ^ full_key[3][index + 1];

                full_key[0][index + 3] = full_key[0][index - 1] ^ full_key[0][index + 2];
                full_key[1][index + 3] = full_key[1][index - 1] ^ full_key[1][index + 2];
                full_key[2][index + 3] = full_key[2][index - 1] ^ full_key[2][index + 2];
                full_key[3][index + 3] = full_key[3][index - 1] ^ full_key[3][index + 2];

                full_key[0][index + 4] = full_key[0][index] ^ full_key[0][index + 3];
                full_key[1][index + 4] = full_key[1][index] ^ full_key[1][index + 3];
                full_key[2][index + 4] = full_key[2][index] ^ full_key[2][index + 3];
                full_key[3][index + 4] = full_key[3][index] ^ full_key[3][index + 3];

                index = index + 4;
                key_gen_done_flag = (round == 10) ? 1 : 0;
            end
        end
        else begin
            key_gen_done_flag = 0;
            full_key[0][0] = key[127:120];
            full_key[0][1] = key[119:112];
            full_key[0][2] = key[111:104];
            full_key[0][3] = key[103:96];
            full_key[1][0] = key[95:88];
            full_key[1][1] = key[87:80];
            full_key[1][2] = key[79:72];
            full_key[1][3] = key[71:64];
            full_key[2][0] = key[63:56];
            full_key[2][1] = key[55:48];
            full_key[2][2] = key[47:40];
            full_key[2][3] = key[39:32];
            full_key[3][0] = key[31:24];
            full_key[3][1] = key[23:16];
            full_key[3][2] = key[15:8];
            full_key[3][3] = key[7:0];
        end
    end

    always_comb begin : KEY_OUT
        if(key_gen_done_flag == 1) begin
            key_out_reg = (in_round >= 8'h0 && in_round <= 8'ha) ? {full_key[0][(in_round) * 4],  full_key[0][(in_round) * 4 + 1],  full_key[0][(in_round) * 4 + 2],  full_key[0][(in_round) * 4 + 3],
                                                                    full_key[1][(in_round) * 4],  full_key[1][(in_round) * 4 + 1],  full_key[1][(in_round) * 4 + 2],  full_key[1][(in_round) * 4 + 3],
                                                                    full_key[2][(in_round) * 4],  full_key[2][(in_round) * 4 + 1],  full_key[2][(in_round) * 4 + 2],  full_key[2][(in_round) * 4 + 3],
                                                                    full_key[3][(in_round) * 4],  full_key[3][(in_round) * 4 + 1],  full_key[3][(in_round) * 4 + 2],  full_key[3][(in_round) * 4 + 3]} : 128'h0;
        end
        else begin
            key_out_reg = 128'h0;
        end
    end

endmodule