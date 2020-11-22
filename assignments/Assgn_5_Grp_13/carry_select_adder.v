`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 17:59:00
// Design Name: 
// Module Name: carry_select_adder
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
/////////////////////////////////////////////////////////////////////////////////
//GROUP NO. 13
// 5th semester - AUTUMN 2020 
//STUDENTS : RADHIKA PATWARI (18CS10062)
//           ATHARVA ROSHAN NAIK (18CS10067)
 
// ASSIGNMENT 5 -- Question 3
// Carry-Select Adder for adding 2 16-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
//Ripple carry adder for adding 2 two-bit binary numbers using full adders
//OUTPUT:
//sum : 2 bit sum
//cout : 1-bit carry out
//INPUT:
//a,b : 2-bit binary numbers
//cin : carry in
module ripple_adder_2(output [1:0] sum, output cout, input [1:0] a, input [1:0] b, input cin);
 
    wire c;   
    //calling full adder module for each bit addition
    full_adder f1(.sum(sum[0]), .cout(c), .a(a[0]), .b(b[0]), .cin(cin));
    full_adder f2(.sum(sum[1]), .cout(cout), .a(a[1]), .b(b[1]), .cin(c));
 
endmodule
 
//Ripple carry adder for adding 2 two-bit binary numbers using full adders
//OUTPUT:
//sum : 4 bit sum
//cout : 1-bit carry out
//INPUT:
//a,b : 4-bit binary numbers
//cin : carry in
module ripple_adder_4(output [3:0] sum, output cout, input [3:0] a, input [3:0] b, input cin);
 
    wire c;   
     //calling full adder module for each 2-bit addition
    ripple_adder_2 f1(.sum(sum[1:0]), .cout(c), .a(a[1:0]), .b(b[1:0]), .cin(cin));
    ripple_adder_2 f2(.sum(sum[3:2]), .cout(cout), .a(a[3:2]), .b(b[3:2]), .cin(c));
 
endmodule
 
//Carry select adder for adding 2 16-bit binary numbers
module carry_select_adder(output [15:0] sum, output cout, input [15:0] a, input [15:0] b, input cin);
 
    //using 2 ripple carry adder blocks for every 4-bit block and 2 carrys - 0/1
    wire [3:0] rca2_sum, rca3_sum;                  //4-7 bit block 
    wire [3:0] rca4_sum, rca5_sum;                  //8-11 bit block
    wire [3:0] rca6_sum, rca7_sum;                  //12-15 bit block
 
    wire carry_out1, carry_out2, carry_out3;        //final carry out for every 4-bit block
 
    //calculating 2 carry out for each rca of every 4-bit block for respective carry ins - 0/1
    wire rca2_carry, rca3_carry;                    
    wire rca4_carry, rca5_carry; 
    wire rca6_carry, rca7_carry;
 
    //calling the rca blocks and sum temporarily before feeding into multiplexer
    //0-3 bit block
    ripple_adder_4 rca1(.sum(sum[3:0]), .cout(carry_out1), .a(a[3:0]), .b(b[3:0]), .cin(cin));
 
    //4-7 bit block
    //for 0 carryin
    ripple_adder_4 rca2(.sum(rca2_sum[3:0]), .cout(rca2_carry), .a(a[7:4]), .b(b[7:4]), .cin(1'b0));
    //for 1 carryin
    ripple_adder_4 rca3(.sum(rca3_sum[3:0]), .cout(rca3_carry), .a(a[7:4]), .b(b[7:4]), .cin(1'b1));
 
    //8-11 bit block
    //for 0 carryin
    ripple_adder_4 rca4(.sum(rca4_sum[3:0]), .cout(rca4_carry), .a(a[11:8]), .b(b[11:8]), .cin(1'b0));
    //for 1 carryin
    ripple_adder_4 rca5(.sum(rca5_sum[3:0]), .cout(rca5_carry), .a(a[11:8]), .b(b[11:8]), .cin(1'b1));
 
    //12-15 bit block
    //for 0 carry in
    ripple_adder_4 rca6(.sum(rca6_sum[3:0]), .cout(rca6_carry), .a(a[15:12]), .b(b[15:12]), .cin(1'b0));
    //for 1 carry in
    ripple_adder_4 rca7(.sum(rca7_sum[3:0]), .cout(rca7_carry), .a(a[15:12]), .b(b[15:12]), .cin(1'b1));
 
    //using a 1-bit multiplexer for calculating the 12 bit sum and final 1-bit carry out
    //sum[4]
    assign sum[4] = (rca2_sum[0] & ~carry_out1)|(rca3_sum[0] & carry_out1);
    //sum[5]
    assign sum[5] = (rca2_sum[1] & ~carry_out1)|(rca3_sum[1] & carry_out1);
    //sum[6]
    assign sum[6] = (rca2_sum[2] & ~carry_out1)|(rca3_sum[2] & carry_out1);
    //sum[7]
    assign sum[7] = (rca2_sum[3] & ~carry_out1)|(rca3_sum[3] & carry_out1);
    //carry_out2
    assign carry_out2 = (rca2_carry & ~carry_out1)|(rca3_carry & carry_out1);
 
    //sum[8]
    assign sum[8] = (rca4_sum[0] & ~carry_out2)|(rca5_sum[0] & carry_out2);
    //sum[9]
    assign sum[9] = (rca4_sum[1] & ~carry_out2)|(rca5_sum[1] & carry_out2);
    //sum[10]
    assign sum[10] = (rca4_sum[2] & ~carry_out2)|(rca5_sum[2] & carry_out2);
    //sum[11]
    assign sum[11] = (rca4_sum[3] & ~carry_out2)|(rca5_sum[3] & carry_out2);
    //carry_out3
     assign carry_out3 = (rca4_carry & ~carry_out2)|(rca5_carry & carry_out2);
 
    //sum[12]
    assign sum[12] = (rca6_sum[0] & ~carry_out3)|(rca7_sum[0] & carry_out3);
    //sum[13]
    assign sum[13] = (rca6_sum[1] & ~carry_out3)|(rca7_sum[1] & carry_out3);
    //sum[14]
    assign sum[14] = (rca6_sum[2] & ~carry_out3)|(rca7_sum[2] & carry_out3);
    //sum[15]
    assign sum[15] = (rca6_sum[3] & ~carry_out3)|(rca7_sum[3] & carry_out3);
    //carry_out_final
    assign cout = (rca6_carry & ~carry_out3)|(rca7_carry & carry_out3);
 
endmodule