`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 06:23:16 PM
// Design Name:
// Module Name: mix_col_tb
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


module mix_col_tb(

    );
    logic [31:0] in, out;

    mix_col dut (in, out);

    initial begin
        in = 32'hd4bf5d30; #10;
        assert (out == 32'h046681e5) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'he0b452ae; #10;
        assert (out == 32'he0cb199a) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'hb84111f1; #10;
        assert (out == 32'h48f8d37a) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'h1e2798e5; #10;
        assert (out == 32'h2806264c) else $error("%s: %d", `__FILE__, `__LINE__);
        $finish;
    end
endmodule
