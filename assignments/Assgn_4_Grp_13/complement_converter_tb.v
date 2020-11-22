`timescale 1ns / 1ps
`include "complement_converter.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: multipleOf3_tb
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

// ASSIGNMENT 4 -- Question 1
// Test bench of FSM for Two's complement converter from LSB
///////////////////////////////////////////////////////////////////////////////////

//Module for calling complement convertor module
module complement_converter_tb();

    //rst : reset 
    //clk : clock
    //inp : input bit
    reg rst, clk, inp;          

    //Q : next state function    
    wire [1:0] Q;

    //op : output bit
    wire [1:0] op; 

    //calling the module for computing 2's complement 
    complement_converter C(.rst(rst), .clk(clk), .inp(inp), .op(op), .Q(Q));
	
    initial                                    
        begin
			clk=1'b0;                //initial value of clock                          
			#2 rst=1'b1;             //initial value of reset
			#7 rst=1'b0;             //final value of reset
        end

    always #5 
  		clk=~clk;                   //complementing value of clock at every 5 units of time

    initial 
        begin

            $display("\n=========== TWO's COMPLEMENT FSM OUTPUT ==================== \n");

	        //monitoring the change in input and output
            $monitor($time,"clock = %b ;reset = %b ;input = %b ;output = %b ;State = %b", clk, rst, inp, op, Q); 

            //applying various test cases to check correctness of program
            #15  inp = 1'b1;
            #10  inp = 1'b0;
            #10  inp = 1'b1;
            #10  inp = 1'b0;
            #10  inp = 1'b1;
            #10  inp = 1'b0;
            #20 $finish;    
        end
endmodule 