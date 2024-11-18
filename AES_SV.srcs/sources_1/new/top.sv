`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 12:19:59 PM
// Design Name:
// Module Name: top
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


module top(
    input clk,
    input en,
    input enc_or_dec,
    input [127:0] key_in,
    input [127:0] text_in,

    output [127:0] text_out,
    output [1:0] event_flag
    );

    logic en_key_gen;
    logic en_enc;
    logic en_dec;

    logic [127:0] text_out_enc;
    logic [127:0] text_out_dec;

    logic [3:0] round_in;
    logic [3:0] round_in_enc;
    logic [3:0] round_in_dec;
    logic [127:0] key_out;

    logic key_gen_done;

    key_generator key_gen (.clk(clk), .en(en_key_gen), .key_in(key_in), .in_round(round_in), .key_gen_done(key_gen_done), .key_out(key_out));

    encrypt enc (.clk(clk), .en(en_enc), .plain_text_in(text_in), .key(key_out), .round(round_in_enc), .cipher_text_out(text_out_enc), .encrypt_done_flag(event_flag[0]));

    decrypt dec (.clk(clk), .en(en_dec), .cipher_text_in(text_in), .key(key_out), .round(round_in_dec), .plain_text_out(text_out_dec), .decrypt_done_flag(event_flag[1]));

    assign round_in = (enc_or_dec) ? round_in_enc : round_in_dec; /* Choose which round_in signal to take based on enc or dec */
    assign text_out = (enc_or_dec) ? text_out_enc : text_out_dec; /* Choose which text_out signal to take based on enc or dec */

    assign en_key_gen = en; /* Enable Key Generation When module is enabled */
    assign en_enc = key_gen_done ? (enc_or_dec ? 1'b1 : 1'b0) : 1'b0;
    assign en_dec = key_gen_done ? (enc_or_dec ? 1'b0 : 1'b1) : 1'b0;

endmodule
