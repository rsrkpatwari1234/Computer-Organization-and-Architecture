//`timescale 1ns / 1ps
`include "gcd_calculator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: gcd_calculator_tb
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
//5th semester - AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//           RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 4 -- Question 3
// Test bench for computing GCD of 2 8-bit signed binary numbers
///////////////////////////////////////////////////////////////////////////////////

//Module for calling complement convertor module
module gcd_calculator_tb;
	
	//A : 8-bit signed binary number
	//B : 8-bit signed binary number
	reg signed [7:0] A,B;

	//rst : reset 
    //clk : clock
	reg clk,reset;

	//computing and storing 8-bit gcd value
	wire signed [7:0] gcd;

	//checking the equality and less than conditions
	wire eq,lt;

	//calling the module for computing GCD of A and B
	gcd_calculator G(.A(A), .B(B), .clk(clk), .reset(reset), .gcd(gcd), .eqflg(eq), .ltflg(lt));

	initial                                    
        begin
			clk=1'b0;                    //initial value of clock                
			#2 reset=1'b1;               //initial value of reset        
			#7 reset=1'b0;				 //final value of reset
        end

    always #5 
  		clk=~clk;  				//complementing value of clock at every 5 units of time

	initial
	    begin
	    	
	    	$display("\n=========== GCD COMPUTATION ==================== \n");

	    	//monitoring the change in input and output
            $monitor($time," clock=%b,r=%b,A=%b,B=%b,GCD=%b,eq=%b,lt=%b",clk,reset,A,B,gcd,eq,lt);

            //applying various test cases to check correctness of program
            //end value of GCD shows the final value
			$display($time,": GCD of 5 and 16");
            A=8'b00000101;B=8'b00010000;
			#100
			$display($time,": GCD of 5 and 20");
			A=8'b00000101;B=8'b00010100;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#93 
			$display($time,": GCD of 24 and 16");
			A=8'b00011000;B=8'b00010000;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#91 
			$display($time,": GCD of 15 and 20");
			A=8'b00001111;B=8'b00010100;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#91 
			$display($time,": GCD of 121 and 110");
			A=8'b01111001;B=8'b01101110;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#91 
			$display($time,": GCD of 120 and 72");
			A=8'b01111000;B=8'b01001000;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#91
			$display($time,": GCD of 17 and 23");
			A=8'b00010001;B=8'b00010111;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#91
			$display($time,": GCD of 111 and 99");
			A=8'b01101111;B=8'b01100011;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#150
			$display($time,": GCD of 111 and 111");
			A=8'b01101111;B=8'b01101111;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#50 
			$display($time,": GCD of 127 and 8");
			A=8'b01111111;B=8'b01101111;
            #2 reset=1'b1;
			#7 reset=1'b0;
			#150 $finish;
	    end
endmodule