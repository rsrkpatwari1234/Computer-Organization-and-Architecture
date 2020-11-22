`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 17:58:31
// Design Name: 
// Module Name: carry_save_adder
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
// Carry-Save Adder for adding 9 16-bit binary numbers
///////////////////////////////////////////////////////////////////////////////////
 
//Carry save adder block to add 3 20-bit numbers and return a 20-bit carry containing only 
//carry values and another 20-bit sum containing sum values after ignoring carry for each bit
//INPUT:
//inp1,inp2,inp3 : 20-bit binary numbers
//OUTPUT :
//carry : 20-bit first sum
//sum : 20-bit second sum
module carry_save_adder_block_3_nums(output [19:0] carry, output [19:0] sum, input [19:0] inp1, input [19:0] inp2, input [19:0] inp3);
 
    //initialising carry at LSB as 0 and sum at MSB as 0
    assign carry[0] = 1'b0;
    assign sum[19] = 1'b0;
 
    //calling 19 full adder blocks for adding each bit for the 3-inputs 
    //sum and carry bits are obtained as output
    full_adder f1(.sum(sum[0]), .cout(carry[1]), .a(inp1[0]), .b(inp2[0]), .cin(inp3[0]));
    full_adder f2(.sum(sum[1]), .cout(carry[2]), .a(inp1[1]), .b(inp2[1]), .cin(inp3[1]));
    full_adder f3(.sum(sum[2]), .cout(carry[3]), .a(inp1[2]), .b(inp2[2]), .cin(inp3[2]));
    full_adder f4(.sum(sum[3]), .cout(carry[4]), .a(inp1[3]), .b(inp2[3]), .cin(inp3[3]));
    full_adder f5(.sum(sum[4]), .cout(carry[5]), .a(inp1[4]), .b(inp2[4]), .cin(inp3[4]));
    full_adder f6(.sum(sum[5]), .cout(carry[6]), .a(inp1[5]), .b(inp2[5]), .cin(inp3[5]));
    full_adder f7(.sum(sum[6]), .cout(carry[7]), .a(inp1[6]), .b(inp2[6]), .cin(inp3[6]));
    full_adder f8(.sum(sum[7]), .cout(carry[8]), .a(inp1[7]), .b(inp2[7]), .cin(inp3[7]));
    full_adder f9(.sum(sum[8]), .cout(carry[9]), .a(inp1[8]), .b(inp2[8]), .cin(inp3[8]));
    full_adder f10(.sum(sum[9]), .cout(carry[10]), .a(inp1[9]), .b(inp2[9]), .cin(inp3[9]));
    full_adder f11(.sum(sum[10]), .cout(carry[11]), .a(inp1[10]), .b(inp2[10]), .cin(inp3[10]));
    full_adder f12(.sum(sum[11]), .cout(carry[12]), .a(inp1[11]), .b(inp2[11]), .cin(inp3[11]));
    full_adder f13(.sum(sum[12]), .cout(carry[13]), .a(inp1[12]), .b(inp2[12]), .cin(inp3[12]));
    full_adder f14(.sum(sum[13]), .cout(carry[14]), .a(inp1[13]), .b(inp2[13]), .cin(inp3[13]));
    full_adder f15(.sum(sum[14]), .cout(carry[15]), .a(inp1[14]), .b(inp2[14]), .cin(inp3[14]));
    full_adder f16(.sum(sum[15]), .cout(carry[16]), .a(inp1[15]), .b(inp2[15]), .cin(inp3[15]));
    full_adder f17(.sum(sum[16]), .cout(carry[17]), .a(inp1[16]), .b(inp2[16]), .cin(inp3[16]));
    full_adder f18(.sum(sum[17]), .cout(carry[18]), .a(inp1[17]), .b(inp2[17]), .cin(inp3[17]));
    full_adder f19(.sum(sum[18]), .cout(carry[19]), .a(inp1[18]), .b(inp2[18]), .cin(inp3[18]));
 
endmodule
 
// 4-bit carry lookahead unit implemented using preprocessed variables P and G
// such that output carry can be computed as C(i+1) = G(i) + (P(i).C(i))
// where G(i) = a(i).b(i) and P(i) = a(i)^b(i)
// sum can be calculated as S(i) = C(i)+P(i)
module carry_lookahead_adder_4(output [3:0] sum,output p,output g,input [3:0] a,input [3:0] b,input cin);
 
    wire [3:0] P,G;            //calculating p and g for corresponding bits
    wire [4:0] C;              //calculating the internal carry
 
    genvar i;
    assign C[0] = cin;
    generate for(i=0;i<4;i=i+1)                   //using for loop
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
 
endmodule
 
//20-bit carry lookahead unit implemented using 5 4-bit cla uniits 
module carry_lookahead_adder_20(output [19:0] S, output out, input [19:0] A, input[19:0] B, input C0);
 
    wire [4:0] pg,gg;
    wire [5:0] C;
 
    assign C[0] = C0;                                 //initial carry in
 
    //calling 5 cla units for adding 4-bit blocks
    carry_lookahead_adder_4 g1(.sum(S[3:0]), .p(pg[0]), .g(gg[0]), .a(A[3:0]), .b(B[3:0]), .cin(C[0]));
    assign C[1] = gg[0]|(pg[0]&C[0]);
 
    carry_lookahead_adder_4 g2(.sum(S[7:4]), .p(pg[1]), .g(gg[1]), .a(A[7:4]), .b(B[7:4]), .cin(C[1]));
    assign C[2] = gg[1]|(pg[1]&C[1]);
 
    carry_lookahead_adder_4 g3(.sum(S[11:8]), .p(pg[2]), .g(gg[2]), .a(A[11:8]), .b(B[11:8]), .cin(C[2]));
    assign C[3] = gg[2]|(pg[2]&C[2]);
 
    carry_lookahead_adder_4 g4(.sum(S[15:12]), .p(pg[3]), .g(gg[3]), .a(A[15:12]), .b(B[15:12]), .cin(C[3]));
    assign C[4] = gg[3]|(pg[3]&C[3]);
 
    carry_lookahead_adder_4 g5(.sum(S[19:16]), .p(pg[4]), .g(gg[4]), .a(A[19:16]), .b(B[19:16]), .cin(C[4]));
    assign C[5] = gg[4]|(pg[4]&C[4]);
 
    assign out = C[5];                              //final carry out
 
endmodule
 
//Carry save adder for adding 9 16-bit numbers
//INPUT :
// ai : 16-bit numbers for 0<=i<9
//OUTPUT :
// sum : sum obtained after adding 9 16-bit binary numbers
// cout : final carry out obtained
module carry_save_adder_block_9_nums(output [19:0] sum, output cout, input [15:0] a0, input [15:0] a1, input [15:0] a2, input [15:0] a3, input [15:0] a4, input [15:0] a5, input [15:0] a6, input [15:0] a7, input [15:0] a8);
 
   wire [19:0] carry1,sum1;
   wire [19:0] carry2,sum2;
   wire [19:0] carry3,sum3;
   wire [19:0] carry4,sum4;
   wire [19:0] carry5,sum5;
   wire [19:0] carry6,sum6;
   wire [19:0] carry7,sum7;
 
   wire [19:0] x0,x1,x2,x3,x4,x5,x6,x7,x8;
 
   //7 3-bit carry save units are used for computing sum of 9 binary numbers 
   //1 20-bit carry lookahead unit is finally used for computing sum of final carry and sum 
   // blocks
   assign x0[15:0] = a0[15:0];
   assign x0[19:16] = 4'b0000;
   assign x1[15:0] = a1[15:0];
   assign x1[19:16] = 4'b0000;
   assign x2[15:0] = a2[15:0];
   assign x2[19:16] = 4'b0000;
   carry_save_adder_block_3_nums CSA1(.carry(carry1), .sum(sum1), .inp1(x0), .inp2(x1), .inp3(x2));
 
   assign x3[15:0] = a3[15:0];
   assign x3[19:16] = 4'b0000;
   assign x4[15:0] = a4[15:0];
   assign x4[19:16] = 4'b0000;
   assign x5[15:0] = a5[15:0];
   assign x5[19:16] = 4'b0000;
   carry_save_adder_block_3_nums CSA2(.carry(carry2), .sum(sum2), .inp1(x3), .inp2(x4), .inp3(x5));
 
   assign x6[15:0] = a6[15:0];
   assign x6[19:16] = 4'b0000;
   assign x7[15:0] = a7[15:0];
   assign x7[19:16] = 4'b0000;
   assign x8[15:0] = a8[15:0];
   assign x8[19:16] = 4'b0000;
   carry_save_adder_block_3_nums CSA3(.carry(carry3), .sum(sum3), .inp1(x6), .inp2(x7), .inp3(x8));
 
   carry_save_adder_block_3_nums CSA4(.carry(carry4), .sum(sum4), .inp1(carry1), .inp2(sum1), .inp3(carry2));
 
   carry_save_adder_block_3_nums CSA5(.carry(carry5), .sum(sum5), .inp1(sum2), .inp2(carry3), .inp3(sum3));
 
   carry_save_adder_block_3_nums CSA6(.carry(carry6), .sum(sum6), .inp1(carry4), .inp2(sum4), .inp3(carry5));
 
   carry_save_adder_block_3_nums CSA7(.carry(carry7), .sum(sum7), .inp1(carry6), .inp2(sum6), .inp3(sum5));
 
   carry_lookahead_adder_20 LCA(.S(sum), .out(cout), .A(carry7), .B(sum7), .C0(1'b0));
 
endmodule