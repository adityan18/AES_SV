`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/18/2024 09:51:38 PM
// Design Name:
// Module Name: aes_128_top_tb
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


module aes_128_top_tb(

    );

    logic clk;

    logic [127:0] key1 = 128'h2b28ab097eaef7cf15d2154f16a6883c;
    logic [127:0] plain1 = 128'h328831e0435a3137f6309807a88da234;
    logic [127:0] cipher1 = 128'h3902dc1925dc116a8409850b1dfb9732;

    logic [127:0] key2 = 128'h2b28ab097eaeF7cf15d2154f16a6883c;
    logic [127:0] plain2 = 128'h4c6d73646f20756f72696d6c6570206f;
    logic [127:0] cipher2 = 128'hbfc4c771d72cd65b5c4dfaaefff80edb;

    logic en;
    logic enc_or_dec;
    logic [1:0]event_flag;

    logic [127:0] key_in;
    logic [127:0] text_in;
    logic [127:0] text_out;

    logic [31:0]key_in_0, key_in_1, key_in_2, key_in_3;
    logic [31:0]text_in_0, text_in_1, text_in_2, text_in_3;
    logic [31:0]text_out_0, text_out_1, text_out_2, text_out_3;

    assign {key_in_0, key_in_1 ,key_in_2, key_in_3} = key_in;
    assign {text_in_0, text_in_1, text_in_2, text_in_3} = text_in;
    assign  text_out = {text_out_0, text_out_1, text_out_2, text_out_3};

    aes_128_top dut (clk, {enc_or_dec, en},
             key_in_0, key_in_1 ,key_in_2, key_in_3,
             text_in_0, text_in_1, text_in_2, text_in_3,
             text_out_0, text_out_1, text_out_2, text_out_3,
             event_flag);

    /* Genreate Clock */
    initial begin
        clk = 0;
        forever begin
            #0.5; clk = ~clk; /* One Clock Cycle  = 1ns */
        end
    end

    initial begin
        /* Encryption 1 */
        en = 0;
        enc_or_dec = 1;
        key_in = key1;
        text_in = plain1;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Encryption Completion */
        assert (text_out == cipher1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Decryption 1 */
        en = 0;
        enc_or_dec = 0;
        key_in = key1;
        text_in = cipher1;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Decryption Completion */
        assert (text_out == plain1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Encryption 2 */
        en = 0;
        enc_or_dec = 1;
        key_in = key2;
        text_in = plain2;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Encryption Completion */
        assert (text_out == cipher2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Decryption 2 */
        en = 0;
        enc_or_dec = 0;
        key_in = key2;
        text_in = cipher2;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Decryption Completion */
        assert (text_out == plain2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Encryption 2 */
        en = 0;
        enc_or_dec = 1;
        key_in = key2;
        text_in = plain2;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Encryption Completion */
        assert (text_out == cipher2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Encryption 1 */
        en = 0;
        enc_or_dec = 1;
        key_in = key1;
        text_in = plain1;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Encryption Completion */
        assert (text_out == cipher1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Decryption 2 */
        en = 0;
        enc_or_dec = 0;
        key_in = key2;
        text_in = cipher2;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Decryption Completion */
        assert (text_out == plain2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        /* Decryption 1 */
        en = 0;
        enc_or_dec = 0;
        key_in = key1;
        text_in = cipher1;
        #2; en = 1; /* Idle Wait */
        #10; /* Wait for Key Gen Completion */
        #12; /* Wait for Decryption Completion */
        assert (text_out == plain1) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        assert (event_flag == 2'd2) else $error("%s: %d: %d", `__FILE__, `__LINE__, $time);
        #5; /* Idle Wait */

        $finish;
    end

endmodule
