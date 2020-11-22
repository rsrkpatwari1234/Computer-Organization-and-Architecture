`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: gcd_calculator
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
// 5th semester  - AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//           RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 4 -- Question 3
// GCD calculator for 8 bits
///////////////////////////////////////////////////////////////////////////////////

// Computing gcd of 2 numbers based upon the algorithm : 
// while (x!=y)
// {
//      if(x < y)
//          y = y - x;
//      else
//          x = x - y;
// }
// gcd = x;

// Module parameters::
// A : 8 bit signed binary input
// B : 8 bit signed binary input
// clk : clock needed to drive the FSM
// rst : reset the input
// gcd : calculating and storing 8-bit gcd value
// eqflg : if (X == Y) then eqflg = 1 else eqflg = 0
// ltflg : if (X < Y) then ltflg = 1 else ltflg = 0

module gcd_calculator(input signed [7:0] A, input signed [7:0] B, input clk, input reset, output reg signed [7:0] gcd,output reg eqflg,output reg ltflg);
    
    // X : to store A temporarily and perform gcd computation
    // Y : to store B temporarily and perform gcd computation
    // X_new : to store updated value of X
    // Y_new : to store updated value of Y
    reg signed [7:0] X,Y,X_new,Y_new;

    always @(posedge clk)               //driving the control path at positive edge of clock
        if(reset)                       //initialising the value of X and Y
            begin
                X <= A;
                Y <= B;
                gcd <= 8'bx;
            end
        else if(eqflg == 0)
            begin                       //Updating the value of X and Y 
                X <= X_new;
                Y <= Y_new;
                gcd <= X;               //storing the value of gcd
            end

    always @(X, Y)                   //driving the control path at positive edge of clock
    begin
        eqflg = (X==Y);             //checking equality of signed X and Y
        ltflg = (X < Y);            //checking if X<Y
        if(eqflg)                   //update gcd and finish computation if X==Y
            gcd = X;
        else if(ltflg)              //Update Y as (Y-X) if Y>X
        begin
            X_new = X;
            Y_new = Y - X;
        end
        else                        //Update X as (X-Y) if X>Y
        begin
            X_new = X - Y;
            Y_new = Y;
        end
    end

endmodule 