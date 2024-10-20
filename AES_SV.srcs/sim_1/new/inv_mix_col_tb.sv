`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/20/2024 08:10:51 AM
// Design Name:
// Module Name: inv_mix_col_tb
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


module inv_mix_col_tb(

    );

    logic [31:0] in, out;

    inv_mix_col dut (in, out);

    initial begin
        in = 32'h473794ed; #10;
        assert (out == 32'h876e46a6) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'h40d4e4a5; #10;
        assert (out == 32'hf24ce78c) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'h43703a46; #10;
        assert (out == 32'h4d904ad8) else $error("%s: %d", `__FILE__, `__LINE__);
        in = 32'h4c9f42bc; #10;
        assert (out == 32'h97ecc395) else $error("%s: %d", `__FILE__, `__LINE__);
        $finish;
    end

endmodule
