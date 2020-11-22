`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 17:59:54
// Design Name: 
// Module Name: ALU4bit
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
// Arithmetic logic unit for performing operations on 2 4-bit binary values
///////////////////////////////////////////////////////////////////////////////////
 
 
// 4-bit carry lookahead unit implemented using preprocessed variables P and G
// such that output carry can be computed as C(i+1) = G(i) + (P(i).C(i))
// where G(i) = a(i).b(i) and P(i) = a(i)^b(i)
// sum can be calculated as S(i) = C(i)+P(i)
module carry_lookahead_4(output [3:0] sum, output cout, output p, output g, input [3:0] a, input [3:0] b, input cin);
 
    wire [3:0] P,G;                  //calculating p and g for 4 corresponding bits
    wire [4:0] C;                    //calculating the internal carry
 
    genvar i;                          //using as loop variable
    assign C[0] = cin;                 //initial carry
    generate for(i=0; i<4; i=i+1)      //for loop over the 4-bits of the input a and b
        begin
            and g1(G[i],a[i],b[i]);              //and gate
            xor g2(P[i],a[i],b[i]);              //xor gate
            xor g3(sum[i],C[i],P[i]);            //xor gate
            assign C[i+1] = G[i]|(P[i]&C[i]);    //calculating the out carry
        end
    endgenerate
 
    //Storing value of P for the 4-bit carry lookahead unit
    assign p = P[0] & P[1] & P[2] & P[3];
 
    //Storing value of G for the 4-bit carry lookahead unit
    assign g = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) |(G[0] & P[3] & P[2] & P[1]);
 
    // Calculating output carry
    assign cout = g | (p & cin);
 
endmodule                            
 
 
//Arithmetic logic unit for performing operations on 2 4-bit binary numbers
//INPUT :
//A,B : 4-bit binary inputs
//S : operation to be performed
//M : mode of operation
//cin : carry in
//OUTPUT :
//F : final output
//cout : complement final carry out
module ALU_4bit(input [3:0] A, input [3:0] B, input [3:0] S, input M, input cin, output reg [3:0] F, output reg cout, output P, output G);
 
    //defining various operations as binary codes
    parameter s0=4'b0, s1=4'b1, s2=4'b10, s3=4'b11, s4=4'b100, s5=4'b101, s6=4'b110, s7=4'b111, s8=4'b1000, 
                s9=4'b1001, s10=4'b1010, s11=4'b1011, s12=4'b1100, s13=4'b1101, s14=4'b1110, s15=4'b1111;
 
    reg [3:0] T1, T2, T;           //temporary inputs 
    wire [3:0] OP;
    wire P, G, Cout;
 
    //peforming adding operation on T1 and T2
    carry_lookahead_4 CLA(OP, Cout, P, G, T1, T2, ~cin);
 
    //defining infinite loop
    always @(*) begin
        if(M == 1) begin                //working upon various mode of operations
            // F = (~A & B & {4{~S[0]}}) | (~A & ~B & {4{~S[1]}}) | (A & ~B & {4{S[2]}}) |(A & B & {4{S[3]}});
            cout = 1'b1;
            case (S)
                s0: begin
                    T = ~A;
                end
                s1: begin
                    T = ~A | ~B;
                end
                s2: begin
                    T = ~A & B;
                end
                s3: begin
                    T = 4'b0;
                end
                s4: begin
                    F = ~(A & B);
                end
                s5: begin
                    T = ~B;
                end
                s6: begin
                    T = A ^ B;
                end
                s7: begin
                    T = A & ~B;
                end
                s8: begin
                    T = ~A | B;
                end
                s9: begin
                    T = ~A ^ ~B;
                end
                s10: begin
                    T = B;
                end
                s11: begin
                    T = A & B;
                end
                s12: begin 
                    T = 1;
                end
                s13: begin
                    T = A | ~B;
                end
                s14: begin
                    T = A | B;
                end
                s15: begin
                    T = A;
                end
            endcase
            F = ~T;
        end
        else begin 
            case(S) 
                s0: begin
                    T1 = A;
                    T2 = 4'b0; 
                end
                s1: begin
                    T1 = A | B;
                    T2 = 4'b0; 
                end
                s2: begin
                    T1 = A | (-B);
                    T2 = 4'b0; 
                end
                s3: begin
                    T1 = 4'b1111;
                    T2 = 4'b0;
                end
                s4: begin
                    T1 = A;
                    T2 = A & (~B);
                end
                s5: begin
                    T1 = A | B;
                    T2 = A & (-B);
                end
                s6: begin
                    T1 = A - 4'b1;
                    T2 = -B;
                end
                s7: begin 
                    T1 = A & B;
                    T2 = 4'b1111;
                end
                s8: begin
                    T1 = A;
                    T2 = A & B;
                end
                s9: begin
                    T1 = A;
                    T2 = B;
                end
                s10: begin
                    T1 = A | (-B);
                    T2 = A & B;
                end
                s11: begin
                    T1 = A & B; 
                    T2 = 4'b1111;
                end
                s12: begin
                    T1 = A; 
                    T2 = A;
                end
                s13: begin
                    T1 = A | B;
                    T2 = A;
                end
                s14: begin
                    T1 = A | (-B); 
                    T2 = A;
                end
                s15: begin
                    T1 = A; 
                    T2 = 4'b1111;
                end
                default: F = 4'b0;
            endcase
            F = ~OP;
            cout = ~Cout; 
        end
    end
endmodule