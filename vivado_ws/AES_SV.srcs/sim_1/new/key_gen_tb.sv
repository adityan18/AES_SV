`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/29/2022 10:23:24 PM
// Design Name:
// Module Name: keyGeneration_tb
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


module keyGeneration_tb(

    );

    logic clk, en;
    logic [127:0] key;
    logic keyReady;
    logic [3:0]round;
    logic [127:0]key_out;

    key_generator dut(clk, en, key, round, keyReady, key_out);

    initial begin
        clk = 0;
        forever begin
            #1; clk = ~clk;
        end
    end

    initial begin
        en = 0;

        key = {8'h2b, 8'h28, 8'hab, 8'h09,
        8'h7e, 8'hae, 8'hf7, 8'hcf,
        8'h15, 8'hd2, 8'h15, 8'h4f,
        8'h16, 8'ha6, 8'h88, 8'h3c};
        # 5
        en = 1;
        # 10;
        round = 5;
        #15;
        for (int i = 0; i< 11 ; i ++) begin
            round = i;
            #2;
        end

        #10;
        en = 0;
        key = {8'h2b, 8'h28, 8'hab, 8'h09,
        8'h7e, 8'hae, 8'hf7, 8'hcf,
        8'h15, 8'hd2, 8'h15, 8'h4f,
        8'h16, 8'ha6, 8'h88, 8'h3c};
        # 5
        en = 1;
        # 10;
        round = 5;
        #15;
        for (int i = 0; i< 11 ; i ++) begin
            round = i;
            #2;
        end
        $finish;
    end

endmodule
