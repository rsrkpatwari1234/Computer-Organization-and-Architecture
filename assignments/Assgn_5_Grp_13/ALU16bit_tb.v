`timescale 1ns / 1ps
// `include "ALU16bit.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 18:09:02
// Design Name: 
// Module Name: ALU16bit_tb
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
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//           RADHIKA PATWARI (18CS10062)
 
// ASSIGNMENT 5 -- Question 2
// Test bench of Arithmetic logic unit for performing operations on 2 16-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
module ALU_16bit_tb();
 
     //2 16-bit binary inputs
    reg [15:0] A, B; 
     //4-bit binary state
    reg [3:0] S; 
    //carry in and mode of operation
    reg cin, M;
    //carry out
    wire cout;
    //storing final 16-bit output
    wire [15:0] F;
 
    //calling 16-bit alu unit for performing arithmetic and logic operations on 2 16-bit inputs
    ALU_16bit A1(.A(A), .B(B), .S(S), .M(M), .cin(cin), .F(F), .cout(cout));
 
    initial begin
        $display("\n====== 16-BIT ALU OUTPUT ========== \n");
        $monitor($time, " A=%b, B=%b, S=%b, M=%b, cinbar=%b, Fbar=%b, coutbar=%b", A, B, S, M, cin, F, cout);
 
        //initialising carry in
        cin = 1'b1;   
 
         //applying various test cases to check correctness of program
        M = 1'b0;
        S = 16'b0011;
        A = 16'b0011;
        B = 16'b1011;
        #5
        S = 4'b0111;
        #5
        A = 16'b1011;
        B = 16'b1011;
        #5
        M = 1'b1;
        S = 4'b1011;
        A = 16'b1001;
        B = 16'b0011;
        #5        
        M = 1'b0;
        S = 4'b0111; 
        A = 16'b0011;
        B = 16'b1011;
        #5
        S = 4'b0000; 
        #5
        S = 4'b0001; 
        #5
        S = 4'b0010; 
        #5
        S = 4'b0011; 
        #5
        S = 4'b0100; 
        #5
        S = 4'b0111; 
        A = 16'b1011;
        B = 16'b1011;
        #5
        M = 1'b1;
        S = 4'b1011; 
        A = 16'b1001;
        B = 16'b0011;
        #5
        $finish;
    end
 
endmodule