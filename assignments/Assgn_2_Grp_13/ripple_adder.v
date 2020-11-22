`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:45:22
// Design Name: 
// Module Name: ripple_adder
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
 
// STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//            RADHIKA PATWARI (18CS10062)
 
// ASSIGNMENT 1
 
// Complexity of adder depends upon the # of bits of input
// 2-bits ripple carry adder of 2 numbers implemented using full adder modules
// returning 2-bits sum and out carry
module ripple_adder_2(output [1:0] sum, output cout, input [1:0] a, input [1:0] b, input cin);
 
    wire c;   
    full_adder f1(.sum(sum[0]), .cout(c), .a(a[0]), .b(b[0]), .cin(cin));
    full_adder f2(.sum(sum[1]), .cout(cout), .a(a[1]), .b(b[1]), .cin(c));
 
endmodule
 
// 4-bits ripple adder of 2 numbers implemented using 2 2-input ripple carry adders
// returning 4-bits sum and out carry 
module ripple_adder_4(output [3:0] sum, output cout, input [3:0] a, input [3:0] b, input cin);
 
    wire c;   
    ripple_adder_2 f1(.sum(sum[1:0]), .cout(c), .a(a[1:0]), .b(b[1:0]), .cin(cin));
    ripple_adder_2 f2(.sum(sum[3:2]), .cout(cout), .a(a[3:2]), .b(b[3:2]), .cin(c));
 
endmodule
 
// 8-bits ripple adder of 2 numbers implemented using 2 4-input ripple carry adders
// returning 8-bits sum and out carry 
module ripple_adder_8(output [7:0] sum, output cout, input [7:0] a, input [7:0] b, input cin);
 
    wire c;   
    ripple_adder_4 f1(.sum(sum[3:0]), .cout(c), .a(a[3:0]), .b(b[3:0]), .cin(cin));
    ripple_adder_4 f2(.sum(sum[7:4]), .cout(cout), .a(a[7:4]), .b(b[7:4]), .cin(c));
 
endmodule