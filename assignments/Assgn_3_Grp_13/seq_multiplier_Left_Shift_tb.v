`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2020 00:45:00
// Design Name: 
// Module Name: seq_multiplier_Left_Shift_tb
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
 
// ASSIGNMENT 3 -- Question 2
// Test bench for Sequential 6-bit unsigned binary array multiplier using left shift version
///////////////////////////////////////////////////////////////////////////////////
 
//Test bench function for checking correctness of array multiplier
module unsigned_seq_mult_LS_tb;
	reg [5:0] A, B;                         //6-bit unsigned array input
	reg clk, reset, load=1'b0;              //declaring the clock,load and reset
 
	wire [11:0] product, Qa, Qb;           //storing he 12 bit product
 
	unsigned_seq_mult_LS G(.load(load), .clk(clk), .rst(reset), .a(A), .b(B), .product(product), .Qa(Qa), .Qb(Qb));
 
    //initialising the clock and reset values
	initial                                    
        begin
			clk=1'b0;                             
			#2 reset=1'b1;                         
			#7 reset=1'b0;
        end
 
    always #5 
  		clk=~clk; //reversing the value of clock after every time_value of 5
 
	initial
	    begin
 
	       //monitoring the change in input and output
            $monitor($time," clock=%b r=%b A=%b B=%b Product=%b",clk,reset,A,B,product);
 
          //applying various test cases to check correctness of program
            #4 A = 6'b100001; B = 6'b100001; // 010001000001
			#78 reset=1'b1;
            #2 A = 6'b011111; B = 6'b100001; // 001111111111
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b111111; B = 6'b100001; // 100000011111
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b000000; B = 6'b100001; // 000000000000
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b101001; B = 6'b101101; // 011100110101
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b111111; B = 6'b111111; // 111110000001
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b101101; B = 6'b000111; // 000100111011
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b011111; B = 6'b001101; // 000110010011
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b010101; B = 6'b101111; // 001111011011
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b101101; B = 6'b111001; // 101000000101
             #5 reset=1'b0;
            #73 reset=1'b1;
            #2 A = 6'b111001; B = 6'b110001; // 101011101001
             #5 reset=1'b0;
            #73 $finish;
	    end
endmodule