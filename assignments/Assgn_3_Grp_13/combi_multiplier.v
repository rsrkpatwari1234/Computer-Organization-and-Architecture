`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 18:26:28
// Design Name: 
// Module Name: combi_multiplier
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
 
/////////////////////////////////////////////////////////////////////////////////
//GROUP NO. 13
//AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//            RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 3 -- Question 1
// Combinational 6-bit unsigned binary array multiplier
///////////////////////////////////////////////////////////////////////////////////
 
//designing a 1-bit full adder with 2 inputs a and b and cin as carry in
//returns 2 outputs : sum and cout(carry out)
module full_adder(output sum, output cout, input a, input b, input cin);
 
	assign sum = a^b^cin;                      //XOR of a,b and carry in gives the sum
	assign cout = (a&b) | (a&cin) | (cin&b);   //OR of AND of a,b and cin gives the carry out
 
endmodule                                       //end of full adder function
 
//designing a 1-bit half adder with 2 inputs a and b
//returns 2 outputs : sum and cout(carry out)
module half_adder(output sum, output cout, input a, input b);
 
	assign sum = a^b;                          //XOR of a and b gives the sum
	assign cout = (a&b);                       //AND of a and b gives the carry out
 
endmodule
 
//designing a 6-bit 2 input array multiplier
//return a 12 bit value obtained after multiplying and b
module unsigned_array_mult(output [11:0]
product, input [5:0] a, input [5:0] b);
 
	//declaring 6 sum variables for each of the 6 steps involved in multiplication process
	//each sumi contain 4 values that represent sum from 4 full adders in each row
	wire [3:0] sum1,sum2,sum3,sum4,sum5,sum6;
 
	//declaring 6 carry variables for each of the 6 steps in multiplication process
	//each carryi contain 5 values that represent the carry values of 4 full adders and 1 half adder
	wire [4:0] carry1,carry2,carry3,carry4,carry5,carry6;
 
	//calculating p0
	and p0(product[0],a[0],b[0]);
 
	//calculating p1 using 1 half adder and 4 full adders
 
	half_adder h_1(.sum(product[1]), .cout(carry1[0]), .a(a[1]&b[0]), .b(a[0]&b[1]));
	full_adder f1_1(.sum(sum1[0]), .cout(carry1[1]), .a(a[2]&b[0]), .b(a[1]&b[1]), .cin(carry1[0]));
	full_adder f2_1(.sum(sum1[1]), .cout(carry1[2]), .a(a[3]&b[0]), .b(a[2]&b[1]), .cin(carry1[1]));
	full_adder f3_1(.sum(sum1[2]), .cout(carry1[3]), .a(a[4]&b[0]), .b(a[3]&b[1]), .cin(carry1[2]));
	full_adder f4_1(.sum(sum1[3]), .cout(carry1[4]), .a(a[5]&b[0]), .b(a[4]&b[1]), .cin(carry1[3]));
 
	//calculating p2 using 1 half adder and 4 full adders
 
	half_adder h_2(.sum(product[2]), .cout(carry2[0]), .a(sum1[0]), .b(a[0]&b[2]));
	full_adder f1_2(.sum(sum2[0]), .cout(carry2[1]), .a(sum1[1]), .b(a[1]&b[2]), .cin(carry2[0]));
	full_adder f2_2(.sum(sum2[1]), .cout(carry2[2]), .a(sum1[2]), .b(a[2]&b[2]), .cin(carry2[1]));
	full_adder f3_2(.sum(sum2[2]), .cout(carry2[3]), .a(sum1[3]), .b(a[3]&b[2]), .cin(carry2[2]));
	full_adder f4_2(.sum(sum2[3]), .cout(carry2[4]), .a(carry1[4]), .b(a[5]&b[1]), .cin(carry2[3]));
 
	//calculating p3 using 1 half adder and 4 full adders
 
	half_adder h_3(.sum(product[3]), .cout(carry3[0]), .a(sum2[0]), .b(a[0]&b[3]));
	full_adder f1_3(.sum(sum3[0]), .cout(carry3[1]), .a(sum2[1]), .b(a[1]&b[3]), .cin(carry3[0]));
	full_adder f2_3(.sum(sum3[1]), .cout(carry3[2]), .a(sum2[2]), .b(a[2]&b[3]), .cin(carry3[1]));
	full_adder f3_3(.sum(sum3[2]), .cout(carry3[3]), .a(sum2[3]), .b(a[4]&b[2]), .cin(carry3[2]));
	full_adder f4_3(.sum(sum3[3]), .cout(carry3[4]), .a(carry2[4]), .b(a[5]&b[2]), .cin(carry3[3]));
 
	//calculating p4 using 1 half adder and 4 full adders
 
	half_adder h_4(.sum(product[4]), .cout(carry4[0]), .a(sum3[0]), .b(a[0]&b[4]));
	full_adder f1_4(.sum(sum4[0]), .cout(carry4[1]), .a(sum3[1]), .b(a[1]&b[4]), .cin(carry4[0]));
	full_adder f2_4(.sum(sum4[1]), .cout(carry4[2]), .a(sum3[2]), .b(a[3]&b[3]), .cin(carry4[1]));
	full_adder f3_4(.sum(sum4[2]), .cout(carry4[3]), .a(sum3[3]), .b(a[4]&b[3]), .cin(carry4[2]));
	full_adder f4_4(.sum(sum4[3]), .cout(carry4[4]), .a(carry3[4]), .b(a[5]&b[3]), .cin(carry4[3]));
 
	//calculating p5 using 1 half adder and 4 full adders
 
	half_adder h_5(.sum(product[5]), .cout(carry5[0]), .a(sum4[0]), .b(a[0]&b[5]));
	full_adder f1_5(.sum(sum5[0]), .cout(carry5[1]), .a(sum4[1]), .b(a[2]&b[4]), .cin(carry5[0]));
	full_adder f2_5(.sum(sum5[1]), .cout(carry5[2]), .a(sum4[2]), .b(a[3]&b[4]), .cin(carry5[1]));
	full_adder f3_5(.sum(sum5[2]), .cout(carry5[3]), .a(sum4[3]), .b(a[4]&b[4]), .cin(carry5[2]));
	full_adder f4_5(.sum(sum5[3]), .cout(carry5[4]), .a(carry4[4]), .b(a[5]&b[4]), .cin(carry5[3]));
 
 
	//calculating p6 using 1 half adder and 4 full adders
 
	half_adder h_6(.sum(product[6]), .cout(carry6[0]), .a(sum5[0]), .b(a[1]&b[5]));
	full_adder f1_6(.sum(sum6[0]), .cout(carry6[1]), .a(sum5[1]), .b(a[2]&b[5]), .cin(carry6[0]));
	full_adder f2_6(.sum(sum6[1]), .cout(carry6[2]), .a(sum5[2]), .b(a[3]&b[5]), .cin(carry6[1]));
	full_adder f3_6(.sum(sum6[2]), .cout(carry6[3]), .a(sum5[3]), .b(a[4]&b[5]), .cin(carry6[2]));
	full_adder f4_6(.sum(sum6[3]), .cout(carry6[4]), .a(carry5[4]), .b(a[5]&b[5]), .cin(carry6[3]));
 
 
	//calculating remaining products
	assign product[7] = sum6[0];
	assign product[8] = sum6[1];
	assign product[9] = sum6[2];
	assign product[10] = sum6[3];
	assign product[11] = carry6[4];
 
    //finally 12 bit product value is obtained in the variable "product"
endmodule