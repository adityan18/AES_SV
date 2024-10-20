`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/20/2024 10:29:08 AM
// Design Name:
// Module Name: decrypt
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


module decrypt(
    input clk,
    input en,
    input [127:0] cipher_text_in,
    input [127:0] key,

    output [3:0] round,
    output [127:0] plain_text_out,
    output decrypt_done_flag
    );

    enum bit { DECRYPT, IDLE } decrypt_state;

    logic [127:0] plain_text_reg;
    logic [3:0] round_reg;

    logic [127:0] in_word;
    logic [127:0] out_word;

    logic [31:0] inv_mix_col_out [0:3];


    inv_mix_col imc1 (.column_in({out_word[127:120] ^ key[127:120], out_word[95:88] ^ key[95:88], out_word[63:56] ^ key[63:56], out_word[31:24] ^ key[31:24]}), .column_out(inv_mix_col_out[0]));
    inv_mix_col imc2 (.column_in({out_word[119:112] ^ key[119:112], out_word[87:80] ^ key[87:80], out_word[55:48] ^ key[55:48], out_word[23:16] ^ key[23:16]}), .column_out(inv_mix_col_out[1]));
    inv_mix_col imc3 (.column_in({out_word[111:104] ^ key[111:104], out_word[79:72] ^ key[79:72], out_word[47:40] ^ key[47:40], out_word[15:8] ^ key[15:8]}), .column_out(inv_mix_col_out[2]));
    inv_mix_col imc4 (.column_in({out_word[103:96] ^ key[103:96],  out_word[71:64] ^ key[71:64], out_word[39:32] ^ key[39:32], out_word[7:0] ^ key[7:0]}), .column_out(inv_mix_col_out[3]));

    sub_word sw1 (.in_word(in_word[127-:32]), .out_word(out_word[127-:32]), .enc_or_dec(1'b0));
    sub_word sw2 (.in_word(in_word[95-:32]), .out_word(out_word[95-:32]), .enc_or_dec(1'b0));
    sub_word sw3 (.in_word(in_word[63-:32]), .out_word(out_word[63-:32]), .enc_or_dec(1'b0));
    sub_word sw4 (.in_word(in_word[31-:32]), .out_word(out_word[31-:32]), .enc_or_dec(1'b0));


    assign plain_text_out = plain_text_reg;
    assign round = round_reg;
    assign decrypt_done_flag = (decrypt_state == IDLE) ? 1 : 0;

    always_ff @( posedge clk ) begin : DEC_BLOCK
        if (en) begin
            case (decrypt_state)
                DECRYPT: begin
                    case (round_reg)
                        10: begin
                            /* Add Round Key */
                            plain_text_reg = cipher_text_in ^ key;

                            in_word = {
                                plain_text_reg[127-:32],
                                {plain_text_reg[71-:8], plain_text_reg[95-:24]},
                                {plain_text_reg[47-:16], plain_text_reg[63-:16]},
                                {plain_text_reg[23-:24], plain_text_reg[31-:8]}
                            };
                        end
                        0: begin
                            plain_text_reg = out_word ^ key;
                            decrypt_state = IDLE;
                        end
                        default: begin
                            plain_text_reg[127-:32] = {inv_mix_col_out[0][31-:8], inv_mix_col_out[1][31-:8], inv_mix_col_out[2][31-:8], inv_mix_col_out[3][31-:8]};
                            plain_text_reg[95-:32] = {inv_mix_col_out[0][23-:8], inv_mix_col_out[1][23-:8], inv_mix_col_out[2][23-:8], inv_mix_col_out[3][23-:8]};
                            plain_text_reg[63-:32] = {inv_mix_col_out[0][15-:8], inv_mix_col_out[1][15-:8], inv_mix_col_out[2][15-:8], inv_mix_col_out[3][15-:8]};
                            plain_text_reg[31-:32] = {inv_mix_col_out[0][7-:8], inv_mix_col_out[1][7-:8], inv_mix_col_out[2][7-:8], inv_mix_col_out[3][7-:8]};

                            in_word = {
                                plain_text_reg[127-:32],
                                {plain_text_reg[71-:8], plain_text_reg[95-:24]},
                                {plain_text_reg[47-:16], plain_text_reg[63-:16]},
                                {plain_text_reg[23-:24], plain_text_reg[31-:8]}
                            };
                        end
                    endcase
                end
                IDLE: begin
                    plain_text_reg = plain_text_reg;
                end
                default: begin
                    plain_text_reg = plain_text_reg;
                end
            endcase
            round_reg -= 1;
        end
        else begin
            plain_text_reg = 0;
            in_word = 0;
            round_reg = 10;
            decrypt_state  = DECRYPT;
        end
    end



endmodule
