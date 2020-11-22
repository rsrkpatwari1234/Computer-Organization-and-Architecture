`timescale 1ns / 1ps
// `include "ALU4bit.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 18:08:24
// Design Name: 
// Module Name: ALU4bit_tb
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
 
// ASSIGNMENT 5 -- Question 1
// Test bench of Arithmetic logic unit for performing operations on 2 4-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
module ALU_4bit_tb();
 
    //2 4-bit binary inputs and state
    reg [3:0] A, B, S;
    //setting mode of operation
    reg M;
    //storing final output
    wire [3:0] F;
    //storing final output carry
    wire cout, P, G;
    //initialising carry in as 0
    reg cin = 1'b1;
 
    //calling the alu unit for performing various operations on 4-bit binary inputs
    ALU_4bit A1(.A(A), .B(B), .S(S), .M(M), .cin(cin), .F(F), .P(P), .G(G), .cout(cout));
 
    initial begin
 
        $display("\n====== 4-BIT ALU OUTPUT ========== \n");
        $monitor($time, " A=%b, B=%b, cinbar=%b, S=%b, M=%b, Fbar=%b, coutbar=%b", A, B, cin, S, M, F, cout);
 
        //applying various test cases to check correctness of program
        M = 1'b0;
        S = 4'b0011;
        A = 4'b0011;
        B = 4'b1011;
        #5
        S = 4'b0111;
        #5
        A = 4'b1011;
        B = 4'b1011;
        #5
        M = 1'b1;
        S = 4'b1111;
        A = 4'b1001;
        B = 4'b0011;
        #5     
        M = 1'b1;
        S = 4'b0011;
        A = 4'b1001;
        B = 4'b0011;
        #5        
        M = 1'b0;
        S = 4'b0111; 
        A = 4'b0011;
        B = 4'b1011;
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
        A = 4'b1011;
        B = 4'b1011;
        #5
        M = 1'b1;
        S = 4'b1011; 
        A = 4'b1001;
        B = 4'b0011;
        #5
        $finish;
    end
endmodule