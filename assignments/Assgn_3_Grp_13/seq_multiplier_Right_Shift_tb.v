`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2020 00:42:50
// Design Name: 
// Module Name: seq_multiplier_Right_Shift_tb
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
 
// ASSIGNMENT 3 -- Question 3
// Test bench for Sequential 6-bit unsigned binary array multiplier using right shift version
///////////////////////////////////////////////////////////////////////////////////
 
//Test bench function for checking correctness of array multiplier
module unsigned_seq_mult_RS_tb;
	reg [5:0] A,B;                 //6-bit unsigned array input
	reg clk,reset;                 //declaring the clock and reset
 
	wire Run;                      //finding the run 
	wire [11:0] product;           //storing 12 bit output value
 
    //calling the module with 6-bit input and obtaining product as output
	unsigned_seq_mult_RS G(.Clock(clk), .Reset(reset), .A(A), .B(B), .Product(product), .Run(Run));
 
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
 
	        //optionally storing data in file
	    	$dumpfile("multiplier_RS.vcd");
        	$dumpvars(0,unsigned_seq_mult_RS_tb);
 
        	//monitoring the change in input and output
            $monitor($time," clock = %b,r=%b,A = %b,B = %b,Product = %b,Run = %b",clk,reset,A,B,product,Run);
 
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