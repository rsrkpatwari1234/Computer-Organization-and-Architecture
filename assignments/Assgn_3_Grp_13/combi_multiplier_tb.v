`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 18:28:20
// Design Name: 
// Module Name: combi_multiplier_tb
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
// Test bench for Combinational 6-bit unsigned binary array multiplier
///////////////////////////////////////////////////////////////////////////////////
 
//declaring the test bench module name for the 6-bit unsigned binary multiplier
module combi_multiplier_tb;
 
    //6-bit unsigned binary values in A and B 
	reg [5:0] A,B;
	//storing 12 bit product value after multiplication of A and B
	wire [11:0] product;
 
	//calling the function module with input A and B and obtaining the final output in 'product'
	unsigned_array_mult G(.product(product), .a(A), .b(B));
 
	//declaring the initial block
	initial
		begin	
		    //optional we may obtain a vcd file of data
			$dumpfile("multiplier.vcd");
			$dumpvars(0,combi_multiplier_tb);
 
			//monitoring the changes in input and output with time 
			$monitor($time,"A = %b , B = %b , Product = %b",A,B,product);
 
			//Applying different test cases to check the correctness of the program 
			#5 A = 6'b100001;B = 6'b100001;
			#5 A = 6'b011111;B = 6'b100001; 
			#5 A = 6'b111111;B = 6'b100001;
			#5 A = 6'b000000;B = 6'b100001;
			#5 A = 6'b101001;B = 6'b101101;
			#5 A = 6'b111111;B = 6'b111111;
			#5 A = 6'b101101;B = 6'b000111;
			#5 A = 6'b011111;B = 6'b001101;
			#5 A = 6'b010101;B = 6'b101111;
			#5 A = 6'b101101;B = 6'b111001;
			#5 A = 6'b111001;B = 6'b110001;
		end
endmodule