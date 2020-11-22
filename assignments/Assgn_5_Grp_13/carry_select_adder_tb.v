`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 18:07:58
// Design Name: 
// Module Name: carry_select_adder_tb
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
// Test Bench of Carry-Select Adder for adding 2 16-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
 
module carry_select_adder_testbench;
 
    //2 16-bit binary inputs
    reg [15:0] A,B;
 
    //carry intput
    reg cin;
 
    //out carry
    wire cout;
    //16-bit output sum
    wire [15:0] sum;
 
    //calling carry select module for computing sum of 2 16-bit binary numbers
    carry_select_adder G1(.sum(sum), .cout(cout), .a(A), .b(B), .cin(cin));
 
    initial
        begin
 
            $display("\n====== 16-BIT ADDER OUTPUT ========== \n");
 
            $monitor("A = %b,B = %b,carry_in = %b,out_carry = %b,Sum = %b",A,B,cin,cout,sum);
 
            //applying various test cases to check correctness of program
 
            #4
            cin = 1'b0;
            A=16'b0000000000000011;B=16'b0000000000000011;
 
            #4
            cin = 1'b0;
            A=16'b1111100000000011;B=16'b0000111000000011;
 
            #4
            cin = 1'b0;
            A=16'b1111111111111111;B=16'b0000111000000011;
        end
endmodule