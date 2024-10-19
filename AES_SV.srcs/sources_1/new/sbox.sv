`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/16/2024 08:04:21 PM
// Design Name:
// Module Name: sbox
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


module sbox(
    input [7:0] in_byte, /* Input Word */
    output logic [7:0] sub_byte /* Subsitute Word */
    );

    wire [7:0] SBOX_LUT [0:255];

    assign SBOX_LUT[8'h00] = 8'h63;
    assign SBOX_LUT[8'h01] = 8'h7c;
    assign SBOX_LUT[8'h02] = 8'h77;
    assign SBOX_LUT[8'h03] = 8'h7b;
    assign SBOX_LUT[8'h04] = 8'hf2;
    assign SBOX_LUT[8'h05] = 8'h6b;
    assign SBOX_LUT[8'h06] = 8'h6f;
    assign SBOX_LUT[8'h07] = 8'hc5;
    assign SBOX_LUT[8'h08] = 8'h30;
    assign SBOX_LUT[8'h09] = 8'h01;
    assign SBOX_LUT[8'h0a] = 8'h67;
    assign SBOX_LUT[8'h0b] = 8'h2b;
    assign SBOX_LUT[8'h0c] = 8'hfe;
    assign SBOX_LUT[8'h0d] = 8'hd7;
    assign SBOX_LUT[8'h0e] = 8'hab;
    assign SBOX_LUT[8'h0f] = 8'h76;
    assign SBOX_LUT[8'h10] = 8'hca;
    assign SBOX_LUT[8'h11] = 8'h82;
    assign SBOX_LUT[8'h12] = 8'hc9;
    assign SBOX_LUT[8'h13] = 8'h7d;
    assign SBOX_LUT[8'h14] = 8'hfa;
    assign SBOX_LUT[8'h15] = 8'h59;
    assign SBOX_LUT[8'h16] = 8'h47;
    assign SBOX_LUT[8'h17] = 8'hf0;
    assign SBOX_LUT[8'h18] = 8'had;
    assign SBOX_LUT[8'h19] = 8'hd4;
    assign SBOX_LUT[8'h1a] = 8'ha2;
    assign SBOX_LUT[8'h1b] = 8'haf;
    assign SBOX_LUT[8'h1c] = 8'h9c;
    assign SBOX_LUT[8'h1d] = 8'ha4;
    assign SBOX_LUT[8'h1e] = 8'h72;
    assign SBOX_LUT[8'h1f] = 8'hc0;
    assign SBOX_LUT[8'h20] = 8'hb7;
    assign SBOX_LUT[8'h21] = 8'hfd;
    assign SBOX_LUT[8'h22] = 8'h93;
    assign SBOX_LUT[8'h23] = 8'h26;
    assign SBOX_LUT[8'h24] = 8'h36;
    assign SBOX_LUT[8'h25] = 8'h3f;
    assign SBOX_LUT[8'h26] = 8'hf7;
    assign SBOX_LUT[8'h27] = 8'hcc;
    assign SBOX_LUT[8'h28] = 8'h34;
    assign SBOX_LUT[8'h29] = 8'ha5;
    assign SBOX_LUT[8'h2a] = 8'he5;
    assign SBOX_LUT[8'h2b] = 8'hf1;
    assign SBOX_LUT[8'h2c] = 8'h71;
    assign SBOX_LUT[8'h2d] = 8'hd8;
    assign SBOX_LUT[8'h2e] = 8'h31;
    assign SBOX_LUT[8'h2f] = 8'h15;
    assign SBOX_LUT[8'h30] = 8'h04;
    assign SBOX_LUT[8'h31] = 8'hc7;
    assign SBOX_LUT[8'h32] = 8'h23;
    assign SBOX_LUT[8'h33] = 8'hc3;
    assign SBOX_LUT[8'h34] = 8'h18;
    assign SBOX_LUT[8'h35] = 8'h96;
    assign SBOX_LUT[8'h36] = 8'h05;
    assign SBOX_LUT[8'h37] = 8'h9a;
    assign SBOX_LUT[8'h38] = 8'h07;
    assign SBOX_LUT[8'h39] = 8'h12;
    assign SBOX_LUT[8'h3a] = 8'h80;
    assign SBOX_LUT[8'h3b] = 8'he2;
    assign SBOX_LUT[8'h3c] = 8'heb;
    assign SBOX_LUT[8'h3d] = 8'h27;
    assign SBOX_LUT[8'h3e] = 8'hb2;
    assign SBOX_LUT[8'h3f] = 8'h75;
    assign SBOX_LUT[8'h40] = 8'h09;
    assign SBOX_LUT[8'h41] = 8'h83;
    assign SBOX_LUT[8'h42] = 8'h2c;
    assign SBOX_LUT[8'h43] = 8'h1a;
    assign SBOX_LUT[8'h44] = 8'h1b;
    assign SBOX_LUT[8'h45] = 8'h6e;
    assign SBOX_LUT[8'h46] = 8'h5a;
    assign SBOX_LUT[8'h47] = 8'ha0;
    assign SBOX_LUT[8'h48] = 8'h52;
    assign SBOX_LUT[8'h49] = 8'h3b;
    assign SBOX_LUT[8'h4a] = 8'hd6;
    assign SBOX_LUT[8'h4b] = 8'hb3;
    assign SBOX_LUT[8'h4c] = 8'h29;
    assign SBOX_LUT[8'h4d] = 8'he3;
    assign SBOX_LUT[8'h4e] = 8'h2f;
    assign SBOX_LUT[8'h4f] = 8'h84;
    assign SBOX_LUT[8'h50] = 8'h53;
    assign SBOX_LUT[8'h51] = 8'hd1;
    assign SBOX_LUT[8'h52] = 8'h00;
    assign SBOX_LUT[8'h53] = 8'hed;
    assign SBOX_LUT[8'h54] = 8'h20;
    assign SBOX_LUT[8'h55] = 8'hfc;
    assign SBOX_LUT[8'h56] = 8'hb1;
    assign SBOX_LUT[8'h57] = 8'h5b;
    assign SBOX_LUT[8'h58] = 8'h6a;
    assign SBOX_LUT[8'h59] = 8'hcb;
    assign SBOX_LUT[8'h5a] = 8'hbe;
    assign SBOX_LUT[8'h5b] = 8'h39;
    assign SBOX_LUT[8'h5c] = 8'h4a;
    assign SBOX_LUT[8'h5d] = 8'h4c;
    assign SBOX_LUT[8'h5e] = 8'h58;
    assign SBOX_LUT[8'h5f] = 8'hcf;
    assign SBOX_LUT[8'h60] = 8'hd0;
    assign SBOX_LUT[8'h61] = 8'hef;
    assign SBOX_LUT[8'h62] = 8'haa;
    assign SBOX_LUT[8'h63] = 8'hfb;
    assign SBOX_LUT[8'h64] = 8'h43;
    assign SBOX_LUT[8'h65] = 8'h4d;
    assign SBOX_LUT[8'h66] = 8'h33;
    assign SBOX_LUT[8'h67] = 8'h85;
    assign SBOX_LUT[8'h68] = 8'h45;
    assign SBOX_LUT[8'h69] = 8'hf9;
    assign SBOX_LUT[8'h6a] = 8'h02;
    assign SBOX_LUT[8'h6b] = 8'h7f;
    assign SBOX_LUT[8'h6c] = 8'h50;
    assign SBOX_LUT[8'h6d] = 8'h3c;
    assign SBOX_LUT[8'h6e] = 8'h9f;
    assign SBOX_LUT[8'h6f] = 8'ha8;
    assign SBOX_LUT[8'h70] = 8'h51;
    assign SBOX_LUT[8'h71] = 8'ha3;
    assign SBOX_LUT[8'h72] = 8'h40;
    assign SBOX_LUT[8'h73] = 8'h8f;
    assign SBOX_LUT[8'h74] = 8'h92;
    assign SBOX_LUT[8'h75] = 8'h9d;
    assign SBOX_LUT[8'h76] = 8'h38;
    assign SBOX_LUT[8'h77] = 8'hf5;
    assign SBOX_LUT[8'h78] = 8'hbc;
    assign SBOX_LUT[8'h79] = 8'hb6;
    assign SBOX_LUT[8'h7a] = 8'hda;
    assign SBOX_LUT[8'h7b] = 8'h21;
    assign SBOX_LUT[8'h7c] = 8'h10;
    assign SBOX_LUT[8'h7d] = 8'hff;
    assign SBOX_LUT[8'h7e] = 8'hf3;
    assign SBOX_LUT[8'h7f] = 8'hd2;
    assign SBOX_LUT[8'h80] = 8'hcd;
    assign SBOX_LUT[8'h81] = 8'h0c;
    assign SBOX_LUT[8'h82] = 8'h13;
    assign SBOX_LUT[8'h83] = 8'hec;
    assign SBOX_LUT[8'h84] = 8'h5f;
    assign SBOX_LUT[8'h85] = 8'h97;
    assign SBOX_LUT[8'h86] = 8'h44;
    assign SBOX_LUT[8'h87] = 8'h17;
    assign SBOX_LUT[8'h88] = 8'hc4;
    assign SBOX_LUT[8'h89] = 8'ha7;
    assign SBOX_LUT[8'h8a] = 8'h7e;
    assign SBOX_LUT[8'h8b] = 8'h3d;
    assign SBOX_LUT[8'h8c] = 8'h64;
    assign SBOX_LUT[8'h8d] = 8'h5d;
    assign SBOX_LUT[8'h8e] = 8'h19;
    assign SBOX_LUT[8'h8f] = 8'h73;
    assign SBOX_LUT[8'h90] = 8'h60;
    assign SBOX_LUT[8'h91] = 8'h81;
    assign SBOX_LUT[8'h92] = 8'h4f;
    assign SBOX_LUT[8'h93] = 8'hdc;
    assign SBOX_LUT[8'h94] = 8'h22;
    assign SBOX_LUT[8'h95] = 8'h2a;
    assign SBOX_LUT[8'h96] = 8'h90;
    assign SBOX_LUT[8'h97] = 8'h88;
    assign SBOX_LUT[8'h98] = 8'h46;
    assign SBOX_LUT[8'h99] = 8'hee;
    assign SBOX_LUT[8'h9a] = 8'hb8;
    assign SBOX_LUT[8'h9b] = 8'h14;
    assign SBOX_LUT[8'h9c] = 8'hde;
    assign SBOX_LUT[8'h9d] = 8'h5e;
    assign SBOX_LUT[8'h9e] = 8'h0b;
    assign SBOX_LUT[8'h9f] = 8'hdb;
    assign SBOX_LUT[8'ha0] = 8'he0;
    assign SBOX_LUT[8'ha1] = 8'h32;
    assign SBOX_LUT[8'ha2] = 8'h3a;
    assign SBOX_LUT[8'ha3] = 8'h0a;
    assign SBOX_LUT[8'ha4] = 8'h49;
    assign SBOX_LUT[8'ha5] = 8'h06;
    assign SBOX_LUT[8'ha6] = 8'h24;
    assign SBOX_LUT[8'ha7] = 8'h5c;
    assign SBOX_LUT[8'ha8] = 8'hc2;
    assign SBOX_LUT[8'ha9] = 8'hd3;
    assign SBOX_LUT[8'haa] = 8'hac;
    assign SBOX_LUT[8'hab] = 8'h62;
    assign SBOX_LUT[8'hac] = 8'h91;
    assign SBOX_LUT[8'had] = 8'h95;
    assign SBOX_LUT[8'hae] = 8'he4;
    assign SBOX_LUT[8'haf] = 8'h79;
    assign SBOX_LUT[8'hb0] = 8'he7;
    assign SBOX_LUT[8'hb1] = 8'hc8;
    assign SBOX_LUT[8'hb2] = 8'h37;
    assign SBOX_LUT[8'hb3] = 8'h6d;
    assign SBOX_LUT[8'hb4] = 8'h8d;
    assign SBOX_LUT[8'hb5] = 8'hd5;
    assign SBOX_LUT[8'hb6] = 8'h4e;
    assign SBOX_LUT[8'hb7] = 8'ha9;
    assign SBOX_LUT[8'hb8] = 8'h6c;
    assign SBOX_LUT[8'hb9] = 8'h56;
    assign SBOX_LUT[8'hba] = 8'hf4;
    assign SBOX_LUT[8'hbb] = 8'hea;
    assign SBOX_LUT[8'hbc] = 8'h65;
    assign SBOX_LUT[8'hbd] = 8'h7a;
    assign SBOX_LUT[8'hbe] = 8'hae;
    assign SBOX_LUT[8'hbf] = 8'h08;
    assign SBOX_LUT[8'hc0] = 8'hba;
    assign SBOX_LUT[8'hc1] = 8'h78;
    assign SBOX_LUT[8'hc2] = 8'h25;
    assign SBOX_LUT[8'hc3] = 8'h2e;
    assign SBOX_LUT[8'hc4] = 8'h1c;
    assign SBOX_LUT[8'hc5] = 8'ha6;
    assign SBOX_LUT[8'hc6] = 8'hb4;
    assign SBOX_LUT[8'hc7] = 8'hc6;
    assign SBOX_LUT[8'hc8] = 8'he8;
    assign SBOX_LUT[8'hc9] = 8'hdd;
    assign SBOX_LUT[8'hca] = 8'h74;
    assign SBOX_LUT[8'hcb] = 8'h1f;
    assign SBOX_LUT[8'hcc] = 8'h4b;
    assign SBOX_LUT[8'hcd] = 8'hbd;
    assign SBOX_LUT[8'hce] = 8'h8b;
    assign SBOX_LUT[8'hcf] = 8'h8a;
    assign SBOX_LUT[8'hd0] = 8'h70;
    assign SBOX_LUT[8'hd1] = 8'h3e;
    assign SBOX_LUT[8'hd2] = 8'hb5;
    assign SBOX_LUT[8'hd3] = 8'h66;
    assign SBOX_LUT[8'hd4] = 8'h48;
    assign SBOX_LUT[8'hd5] = 8'h03;
    assign SBOX_LUT[8'hd6] = 8'hf6;
    assign SBOX_LUT[8'hd7] = 8'h0e;
    assign SBOX_LUT[8'hd8] = 8'h61;
    assign SBOX_LUT[8'hd9] = 8'h35;
    assign SBOX_LUT[8'hda] = 8'h57;
    assign SBOX_LUT[8'hdb] = 8'hb9;
    assign SBOX_LUT[8'hdc] = 8'h86;
    assign SBOX_LUT[8'hdd] = 8'hc1;
    assign SBOX_LUT[8'hde] = 8'h1d;
    assign SBOX_LUT[8'hdf] = 8'h9e;
    assign SBOX_LUT[8'he0] = 8'he1;
    assign SBOX_LUT[8'he1] = 8'hf8;
    assign SBOX_LUT[8'he2] = 8'h98;
    assign SBOX_LUT[8'he3] = 8'h11;
    assign SBOX_LUT[8'he4] = 8'h69;
    assign SBOX_LUT[8'he5] = 8'hd9;
    assign SBOX_LUT[8'he6] = 8'h8e;
    assign SBOX_LUT[8'he7] = 8'h94;
    assign SBOX_LUT[8'he8] = 8'h9b;
    assign SBOX_LUT[8'he9] = 8'h1e;
    assign SBOX_LUT[8'hea] = 8'h87;
    assign SBOX_LUT[8'heb] = 8'he9;
    assign SBOX_LUT[8'hec] = 8'hce;
    assign SBOX_LUT[8'hed] = 8'h55;
    assign SBOX_LUT[8'hee] = 8'h28;
    assign SBOX_LUT[8'hef] = 8'hdf;
    assign SBOX_LUT[8'hf0] = 8'h8c;
    assign SBOX_LUT[8'hf1] = 8'ha1;
    assign SBOX_LUT[8'hf2] = 8'h89;
    assign SBOX_LUT[8'hf3] = 8'h0d;
    assign SBOX_LUT[8'hf4] = 8'hbf;
    assign SBOX_LUT[8'hf5] = 8'he6;
    assign SBOX_LUT[8'hf6] = 8'h42;
    assign SBOX_LUT[8'hf7] = 8'h68;
    assign SBOX_LUT[8'hf8] = 8'h41;
    assign SBOX_LUT[8'hf9] = 8'h99;
    assign SBOX_LUT[8'hfa] = 8'h2d;
    assign SBOX_LUT[8'hfb] = 8'h0f;
    assign SBOX_LUT[8'hfc] = 8'hb0;
    assign SBOX_LUT[8'hfd] = 8'h54;
    assign SBOX_LUT[8'hfe] = 8'hbb;
    assign SBOX_LUT[8'hff] = 8'h16;

    assign sub_byte = SBOX_LUT[in_byte];

endmodule
