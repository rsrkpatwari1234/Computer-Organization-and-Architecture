`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:55:07
// Design Name: 
// Module Name: serial_adder_test_bench
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
 
//serial adder for 8-bit inputs
module serial_adder_test_bench;
	reg [7:0] A,B,r,y;
	reg cin;
	reg clk,reset;
 
	wire cout;
	wire [7:0] sum;
	wire Run;
 
    //calling the serial adder module for obtaining sum of 2 8-bit numbers
	serial_adder f(.A(A),.B(B),.Reset(reset),.Clock(clk),.cin(cin),.Sum(sum),.cout(cout),.Run(Run));
 
	initial                                    
        begin
			clk=1'b0;                             
			#2 reset=1'b1;                         
			cin=1'b0;                        //setting initial input state as 0
			#7 reset=1'b0;
        end
 
    always #5 
  		clk=~clk;                           //reversing the value of clock after every time_value of 5
 
	integer i,j,a,b;                        //using as loop variables
 
	initial
	    begin
 
	    	//monitoring the change in values of the variables
            $monitor($time,"clock = %b,r=%b,A = %b,B = %b,out_carry = %b,Sum = %b,Run=%b",clk,reset,A,B,cout,sum,Run);
 
 
            //taking 10 different possible test cases 
            #4 A=8'b00000010;B=8'b00001001;
            #89 A=8'b11000000;B=8'b10001001;
            #174 A=8'b10001100;B=8'b00001001;
            #259 A=8'b10000011;B=8'b10000001;
            #344 A=8'b00111111;B=8'b10000000;
            #429 A=8'b01100100;B=8'b01111001;
            #514 A=8'b00110001;B=8'b01101001;
            #599 A=8'b11000100;B=8'b00001001;
            #684 A=8'b11101010;B=8'b10001111;
            #769 A=8'b11111111;B=8'b11111111;
 
            #855 $finish;           //finishing the excution
	    end
endmodule