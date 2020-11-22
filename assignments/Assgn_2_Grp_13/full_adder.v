`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 23:01:00
// Design Name: 
// Module Name: full_adder
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
 
// Full adder implementation for single bit inputs a and b
// Returning sum and cout 
module full_adder(output sum, output cout, input a, input b, input cin);
 
    assign sum = a^b^cin;                    //sum = xor of a,b and cin
    assign cout = (a&b) | (a&cin) | (cin&b); //cout = (a and b) or (a and cin) or (cin and b) 
 
endmodule                                    //end of module