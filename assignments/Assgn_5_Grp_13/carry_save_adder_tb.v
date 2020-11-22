`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 18:07:27
// Design Name: 
// Module Name: carry_save_adder_tb
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
 
// ASSIGNMENT 5 -- Question 4
// Test bench of Carry-Save Adder for adding 9 16-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
 
module carry_save_adder_testbench;
 
    //9 16-bit binary inputs
    reg [15:0] A0,A1,A2,A3,A4,A5,A6,A7,A8;
 
    //storing output carry and sum
    wire cout;
    wire [19:0] sum;
 
    //calling the carry save adder block for computing sum of 9 16-bit binary numbers
    carry_save_adder_block_9_nums CSA(.sum(sum), .cout(cout), .a0(A0), .a1(A1), .a2(A2), .a3(A3), .a4(A4), .a5(A5), .a6(A6), .a7(A7), .a8(A8));
 
    initial
        begin
 
            $display("\n====== 16-BIT ADDER OUTPUT ========== \n");
 
            $monitor("A0 = %b,A1 = %b,A2 = %b,A3 = %b,A4 = %b,A5 = %b,A6 = %b,A7 = %b,A8 = %b,out_carry = %b,Sum = %b",A0,A1,A2,A3,A4,A5,A6,A7,A8,cout,sum);
 
            //applying various test cases to check correctness of program
            A0=16'b1100000000000001;
            A1=16'b1100000000000001;
            A2=16'b1100000000000001;
            A3=16'b1100001000000000;
            A4=16'b1100001000000001;
            A5=16'b1100001000000001;
            A6=16'b1100001000000001;
            A7=16'b1100001000000001;
            A8=16'b1100001000000001;
 
        end
endmodule