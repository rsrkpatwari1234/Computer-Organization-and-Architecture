`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: multipleOf3
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
 
////////////////////////////////////////////////////////////////////////////////
//GROUP NO. 13
// 5th semester - AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//           RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 4 -- Question 2
// FSM for checking if multiple of 3 when input is from LSB
///////////////////////////////////////////////////////////////////////////////////

// Mealy machine for checking if a stream of bits from LSB is divisible by 3 or not

// Module parameters::
// rst : reset the input
// clk : clock needed to drive the FSM
// inp : input binary bit
// op : output binary bit
// Q : present state of the mealy machine

module multiple_of_3(input rst, input clk, input inp, output reg op, output reg [2:0] Q);

    reg [2:0] ns;                       //next state variable
    reg [1:0] nop;                      //output on current input

    //6 states defined for the mealy machine
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101; 

    //output to check whether given input is divisible by 3 or not
    parameter O0 = 1'b0, O1 = 1'b1;

    always @(posedge clk)      //driving the m/c at positive edge of clock
        if(rst)                             //if reset = 1 then set start state and output
            begin
                Q <= S0;                    //start state : 00
                op <= O1;                   //output : 0
            end
        else
            begin
                Q <= ns;                    //present state : next state
                op <= nop;                  //present output : next output
            end

    //sequential FSM based upon the transition table:
    // -----------------------------------
    // Input |      0      |      1      |
    // -----------------------------------
    //   PS  |  NS  |  Out |  NS  |  Out |
    // -----------------------------------
    //   000 |  011 |  001 |  100 |  000 |
    //   001 |  100 |  000 |  101 |  000 |
    //   010 |  101 |  000 |  011 |  001 |
    //   011 |  000 |  001 |  010 |  000 |
    //   100 |  001 |  000 |  000 |  001 |
    //   101 |  010 |  000 |  001 |  000 |
    // -----------------------------------

    always @(Q, op)                         //driving the m/c when output/state changes
    begin
        case(Q)
            S0: if(inp)
                begin
                    ns = S4; 
                    nop = O0; 
                end
                    
                else
                begin
                    ns = S3; 
                    nop = O1; 
                end
            S1: if(inp)
                begin
                    ns = S5; 
                    nop = O0;  
                end
                    
                else
                begin
                    ns = S4; 
                    nop = O0; 
                end
            S2: if(inp)
                begin
                    ns = S3; 
                    nop = O1; 
                end
                
                else
                begin
                    ns = S5; 
                    nop = O0;
                end
            S3: if(inp)
                begin
                    ns = S2; 
                    nop = O0; 
                end
                
                else
                begin
                    ns = S0; 
                    nop = O1; 
                end
            S4: if(inp)
                begin
                    ns = S0; 
                    nop = O1; 
                end
                
                else
                begin
                    ns = S1; 
                    nop = O0;
                end
            S5: if(inp)
                begin
                    ns = S1; 
                    nop = O0; 
                end
                
                else
                begin
                    ns = S2; 
                    nop = O0; 
                end
            default:
                begin
                ns = S0;
                nop = O1; 
                end
        endcase    
    end
endmodule