`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/16/2024 08:11:24 PM
// Design Name:
// Module Name: sub_word
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


module sub_word(
    input [31:0] in_word, /* Input Word */
    input enc_or_dec, /* Encryption or Decryption */
    output [31:0] out_word /* Output Sub Word */
    );

    sbox s1(.in_byte(in_word[31-: 8]), .sub_byte(out_word[31 -: 8]), .enc_or_dec(enc_or_dec));
    sbox s2(.in_byte(in_word[23-: 8]), .sub_byte(out_word[23 -: 8]), .enc_or_dec(enc_or_dec));
    sbox s3(.in_byte(in_word[15-: 8]), .sub_byte(out_word[15 -: 8]), .enc_or_dec(enc_or_dec));
    sbox s4(.in_byte(in_word[7 : 0]), .sub_byte(out_word[7 : 0]), .enc_or_dec(enc_or_dec));
endmodule
