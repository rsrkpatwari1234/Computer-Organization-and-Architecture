`timescale 1ns / 1ps
`include "multipleOf3.v"
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
//AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//            RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 4 -- Question 2
// TestBench for FSM for multiple of 3 detection
///////////////////////////////////////////////////////////////////////////////////

//Module for calling multiple of 3 module
module multiple_of_3_tb();

    //rst : reset 
    //clk : clock
    //inp : input bit
    reg rst, clk, inp;

    //Q : next state function 
    wire [2:0] Q;

    //op : output bit
    wire op;  

    //calling the module for checking if given input is multiple of 3
    multiple_of_3 M(.rst(rst), .clk(clk), .inp(inp), .op(op), .Q(Q));
	
    initial                                    
        begin
			clk=1'b0;                //initial value of clock                          
            #2 rst=1'b1;             //initial value of reset
            #7 rst=1'b0;             //final value of reset
        end

    always #5 
  		clk=~clk;                    //complementing value of clock at every 5 units of time 

    initial 
        begin
            
            $display("\n=========== MULTIPLE OF 3 CHECKING OUTPUT ==================== \n");

            //monitoring the change in input and output
            $monitor($time," rst=%b, inp=%b, op=%b", rst, inp, op); 

            //applying various test cases to check correctness of program
            #4  inp=1;
            #10 inp=0;
            #10 inp=0;
            #10 inp=1;
            #10 inp=0;
            #10 $finish;    
        end
endmodule 