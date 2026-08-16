`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/18/2024 09:40:23 PM
// Design Name:
// Module Name: aes_128_top
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


module aes_128_top(
    input clk,
    input [1:0] aes_ctrl,

    input [31:0] key_in_0,
    input [31:0] key_in_1,
    input [31:0] key_in_2,
    input [31:0] key_in_3,

    input [31:0] text_in_0,
    input [31:0] text_in_1,
    input [31:0] text_in_2,
    input [31:0] text_in_3,

    output [31:0] text_out_0,
    output [31:0] text_out_1,
    output [31:0] text_out_2,
    output [31:0] text_out_3,

    output [1:0] event_flags
    );

    top dut(.clk(clk), .en(aes_ctrl[0]), .enc_or_dec(aes_ctrl[1]), .key_in({key_in_0, key_in_1, key_in_2, key_in_3}), .text_in({text_in_0, text_in_1, text_in_2, text_in_3}), .text_out({text_out_0, text_out_1, text_out_2, text_out_3}), .event_flag(event_flags));

endmodule
