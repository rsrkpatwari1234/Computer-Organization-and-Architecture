`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:52:53
// Design Name: 
// Module Name: hybrid_binary_adder
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
 
// STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//            RADHIKA PATWARI (18CS10062)
 
// ASSIGNMENT 1
 
// 4-bit carry lookahead unit implemented using preprocessed variables P and G
// such that output carry can be computed as C(i+1) = G(i) + (P(i).C(i))
// where G(i) = a(i).b(i) and P(i) = a(i)^b(i)
// sum can be calculated as S(i) = C(i)+P(i)
module carry_lookahead_4(output [3:0] sum,output p,output g,input [3:0] a,input [3:0] b,input cin);
 
    wire [3:0] P,G;                  //calculating p and g for 4 corresponding bits
    wire [4:0] C;                    //calculating the internal carry
 
    genvar i;                        //using as loop variable
    assign C[0] = cin;               //initial carry
    generate for(i=0;i<4;i=i+1)      //for loop over the 4-bits of the input a and b
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
 
// 8-bit carry look ahead adder implemented using 4-bit carry lookahead units
// returning a 8-bit sum and out carry
module hybrid_adder_8(output [7:0] sum,output cout,input [7:0] a,input [7:0] b,input cin);
 
    wire p1, g1, p2, g2, c;
 
    // 4-bit carry lookahead adder resulting in 4-bit sum and corresponding out carry
    carry_lookahead_4 f1(.sum(sum[3:0]), .p(p1), .g(g1), .a(a[3:0]), .b(b[3:0]), .cin(cin));
 
    //calculating cin for the next 4-bit carry lookahead adder
    assign c = g1 | (p1 & cin);
 
    // 4-bit carry lookahead adder resulting in 4-bit sum and corresponding out carry
    carry_lookahead_4 f2(.sum(sum[7:4]), .p(p2), .g(g2), .a(a[7:4]), .b(b[7:4]), .cin(c));
 
    // final output carry obtained after summing 2 8-bit inputs
    assign cout = g2 | (p2 & c);
 
endmodule 