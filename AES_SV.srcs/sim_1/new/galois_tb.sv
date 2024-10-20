`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/19/2024 11:22:17 AM
// Design Name:
// Module Name: galois_tb
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


module galois_tb(

    );

    logic [7:0] a,b;
	logic [7:0] r  ;

    galois t1 (a,b,r);

    initial begin

        a=8'h02;
        b=8'he0; //db
        #10;
        a=8'h02;
        b=8'hb4; //d6 73
        #10;
        a=8'h03;
        b=8'hb4; //83 c7
        #10;
        a=8'h01;
        b=8'h52;
        #10;
        a=8'h01;
        b=8'hae;
        #10;
        a=8'h03;
        b=8'hae; //e9
        #10;
        a=8'h01;
        b=8'hae; //95 ae
        #10;
        a=8'h03;
        b=8'he0; // d0 3b
        #10;
        a=8'h03;
        b=8'h1e; // 22
        #10;
        a=8'h03;
        b=8'hd4; // 67
        #10;
        $finish;
    end

endmodule
