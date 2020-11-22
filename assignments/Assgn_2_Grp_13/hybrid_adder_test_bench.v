
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:55:37
// Design Name: 
// Module Name: hybrid_adder_test_bench
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
 
// Hybrid adder for 8-bit inputs
module hybrid_adder_test_bench;
 
	reg [7:0] A,B,r,y;
	reg cin;
	wire cout;
	wire [7:0] sum;
 
    //calling the hybrid adder for 8-bit binary inputs
	hybrid_adder_8 f(.sum(sum), .cout(cout), .a(A), .b(B), .cin(cin));
 
	localparam t = 10;
	integer i,j,a,b;       //loop variables
 
	initial
	    begin
 
	     	cin = 1'b0;    //taking initial carry as 0
 
	     	//monitoring the change in variables
            $monitor($time,"A = %b , B = %b , out_carry = %b ,Sum = %b",A,B,cout,sum);
 
            //taking  all possible combinations of 2  8-bit numbers
            b = 1;
           	for(i=0;i<8;i=i+1)
            begin
                r[0] = (b%2 == 0)? 1:0;
                r[1] = (b%4 == 0 || b%4 == 3)? 1:0;
                r[2] = (b%8 == 0 || b%8 == 7 || b%8 == 6 || b%8 == 5)? 1:0;
                r[3] = (b%16 == 0 || b%16 == 15 || b%16 == 14 || b%16 == 13 || b%16 == 12 || b%16 == 11 || b%16 == 10 || b%16 == 9)? 1:0;
                a = 1;
                A[3:0] = r[3:0];
 
                for(j=0;j<8;j=j+1)
	                begin
	                #2
	                    y[0] = (a%2 == 0)? 1:0;
	                    y[1] = (a%4 == 0 || a%4 == 3)? 1:0;
	                    y[2] = (a%8 == 0 || a%8 == 7 || a%8 == 6 || a%8 == 5)? 1:0;
	                    y[3] = (a%16 == 0 || a%16 == 15 || a%16 == 14 || a%16 == 13 || a%16 == 12 || a%16 == 11 || a%16 == 10 || a%16 == 9)? 1:0;
	                    a = a+1;
	                    B[3:0] = y[3:0];
	                end
                b = b+1;
 
            end
 
            b = 1;
           	for(i=0;i<16;i=i+1)
            begin
                r[4] = (b%2 == 0)? 1:0;
                r[5] = (b%4 == 0 || b%4 == 3)? 1:0;
                r[6] = (b%8 == 0 || b%8 == 7 || b%8 == 6 || b%8 == 5)? 1:0;
                r[7] = (b%16 == 0 || b%16 == 15 || b%16 == 14 || b%16 == 13 || b%16 == 12 || b%16 == 11 || b%16 == 10 || b%16 == 9)? 1:0;
                a = 1;
                A[7:4] = r[7:4];
                for(j=0;j<16;j=j+1)
	                begin
	                #2
	                    y[4] = (a%2 == 0)? 1:0;
	                    y[5] = (a%4 == 0 || a%4 == 3)? 1:0;
	                    y[6] = (a%8 == 0 || a%8 == 7 || a%8 == 6 || a%8 == 5)? 1:0;
	                    y[7] = (a%16 == 0 || a%16 == 15 || a%16 == 14 || a%16 == 13 || a%16 == 12 || a%16 == 11 || a%16 == 10 || a%16 == 9)? 1:0;
	                    a = a+1;
	                    B[7:4] = y[7:4];
	                end
                b = b+1;
            end
 
	    end
endmodule