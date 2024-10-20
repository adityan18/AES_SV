`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 11:53:02 AM
// Design Name:
// Module Name: encrypt
// Project Name:
// Target Devices:P
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


module encrypt(
    input clk,
    input en,
    input [127:0] plain_text_in,
    input [127:0] key,

    output [3:0] round,
    output [127:0] cipher_text_out,
    output encrypt_done_flag
    );

    enum bit { ENCRYPT, IDLE } encrypt_state;

    logic [127:0] cipher_text_reg;
    logic [3:0] round_reg;

    logic [127:0] in_word; /* In to Sub Byte */
    logic [127:0] out_word; /* Out form Sub Byte */

    logic [31:0] mix_col_out [0:3];

    sub_word sw1 (.in_word(in_word[127-:32]), .out_word(out_word[127-:32]), .enc_or_dec(1'b1));
    sub_word sw2 (.in_word(in_word[95-:32]), .out_word(out_word[95-:32]), .enc_or_dec(1'b1));
    sub_word sw3 (.in_word(in_word[63-:32]), .out_word(out_word[63-:32]), .enc_or_dec(1'b1));
    sub_word sw4 (.in_word(in_word[31-:32]), .out_word(out_word[31-:32]), .enc_or_dec(1'b1));

    mix_col mc1 (.column_in({out_word[127:120], out_word[95:88], out_word[63:56], out_word[31:24]}), .column_out(mix_col_out[0]));
    mix_col mc2 (.column_in({out_word[119:112], out_word[87:80], out_word[55:48], out_word[23:16]}), .column_out(mix_col_out[1]));
    mix_col mc3 (.column_in({out_word[111:104], out_word[79:72], out_word[47:40], out_word[15:8]}), .column_out(mix_col_out[2]));
    mix_col mc4 (.column_in({out_word[103:96],  out_word[71:64], out_word[39:32], out_word[7:0]}), .column_out(mix_col_out[3]));

    assign cipher_text_out = cipher_text_reg;
    assign round = round_reg;
    assign encrypt_done_flag = (encrypt_state == IDLE) ? 1'b1 : 1'b0;

    always_ff @( posedge clk ) begin : ENC_BLOCK
        if(en) begin
            case (encrypt_state)
                ENCRYPT: begin
                    case (round_reg)
                        0: begin
                            /* Add Round Key */
                            cipher_text_reg = plain_text_in ^ key;

                            /* Sub Bytes */
                            in_word = { cipher_text_reg[127-:32],
                                        {cipher_text_reg[87-:24], cipher_text_reg[95-:8]},
                                        {cipher_text_reg[47-:16], cipher_text_reg[63-:16]},
                                        {cipher_text_reg[7-:8], cipher_text_reg[31-:24]}
                                    };
                        end
                        10: begin
                            cipher_text_reg = out_word ^ key;
                            encrypt_state = IDLE;
                        end
                        default: begin
                            cipher_text_reg[127-:32] = {mix_col_out[0][31-:8], mix_col_out[1][31-:8], mix_col_out[2][31-:8], mix_col_out[3][31-:8]};
                            cipher_text_reg[95-:32] = {mix_col_out[0][23-:8], mix_col_out[1][23-:8], mix_col_out[2][23-:8], mix_col_out[3][23-:8]};
                            cipher_text_reg[63-:32] = {mix_col_out[0][15-:8], mix_col_out[1][15-:8], mix_col_out[2][15-:8], mix_col_out[3][15-:8]};
                            cipher_text_reg[31-:32] = {mix_col_out[0][7-:8], mix_col_out[1][7-:8], mix_col_out[2][7-:8], mix_col_out[3][7-:8]};

                            cipher_text_reg = cipher_text_reg ^ key;

                            in_word = { cipher_text_reg[127-:32],
                                        {cipher_text_reg[87-:24], cipher_text_reg[95-:8]},
                                        {cipher_text_reg[47-:16], cipher_text_reg[63-:16]},
                                        {cipher_text_reg[7-:8], cipher_text_reg[31-:24]}
                            };
                        end
                    endcase

                    round_reg += 1;
                end
                IDLE: begin
                    cipher_text_reg = cipher_text_reg;
                end
                default: begin
                    cipher_text_reg = cipher_text_reg;
                end
            endcase
        end
        else begin
            round_reg = 0;
            cipher_text_reg = 0;
            in_word = 0;
            encrypt_state  = ENCRYPT;
        end
    end





endmodule
