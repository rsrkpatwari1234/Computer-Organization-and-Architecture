`timescale 1ns / 1ps
// `include "ALU4bit.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 18:00:15
// Design Name: 
// Module Name: ALU16bit
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
// 5th semester - AUTUMN 2020 
//STUDENTS : RADHIKA PATWARI (18CS10062)
//           ATHARVA ROSHAN NAIK (18CS10067)
 
// ASSIGNMENT 5 -- Question 2
// Arithmetic logic unit for performing operations on 2 16-bit binary values
///////////////////////////////////////////////////////////////////////////////////
 
//INPUT : 
// A,B : 16-bit binary numbers
// S : arithmetic operation to be performed
// M : mode of operation
// cin : carry input
//F : final output
//cout : final carry out
module ALU_16bit(input [15:0] A, input [15:0] B, input [3:0] S, input M, input cin, output [15:0] F, output cout);
 
    wire [3:0] C;
 
    //calling alu for each 4-bit block
    ALU_4bit A1(.A(A[3:0]), .B(B[3:0]), .S(S), .M(M), .cin(cin), .F(F[3:0]), .cout(C[0]));
    ALU_4bit A2(.A(A[7:4]), .B(B[7:4]), .S(S), .M(M), .cin(C[0]), .F(F[7:4]), .cout(C[1]));
    ALU_4bit A3(.A(A[11:8]), .B(B[11:8]), .S(S), .M(M), .cin(C[1]), .F(F[11:8]), .cout(C[2]));
    ALU_4bit A4(.A(A[15:12]), .B(B[15:12]), .S(S), .M(M), .cin(C[2]), .F(F[15:12]), .cout(cout));
 
endmodule