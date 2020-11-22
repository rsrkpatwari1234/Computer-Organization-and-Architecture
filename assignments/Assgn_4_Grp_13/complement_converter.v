`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: 2's Complement convertor
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
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//           RADHIKA PATWARI (18CS10062)

// ASSIGNMENT 4 -- Question 1
// FSM for Two's complement converter from LSB
///////////////////////////////////////////////////////////////////////////////////

// Mealy machine for converting a stream of bits from LSB into its corresponding 
// 2's complement and outputting the output bits

// Module parameters::
// rst : reset the input
// clk : clock needed to drive the FSM
// inp : input binary bit
// op : output binary bit
// Q : present state of the mealy machine


module complement_converter(input rst, input clk, input inp, output reg [1:0] op, output reg [1:0] Q);
    
    reg [1:0] ns;                           //next state variable
    reg [1:0] nop;                          //output on current input
    parameter S0=2'b00, S1=2'b01;           //2 states defined for the mealy machine
    parameter O0 = 2'b00, O1 = 2'b01;       //2 outputs : 0 and 1

    always @(posedge clk, posedge rst)      //driving the m/c at positive edge of clock
        if(rst)                             //if reset = 1 then set start state and output
            begin
                Q <= S0;                    //start state : 00
                op <= O0;                   //output : 0
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
    //   00  |  00  |  00  |  01  |  01  |
    //   01  |  01  |  01  |  01  |  00  |
    // -----------------------------------

    always @(Q, inp)                        //driving the m/c when input/state changes
    begin
        case(Q)
            S0: if(inp)                     
                    begin 
                        ns = S1; 
                        nop = O1; 
                    end
                    
                else
                    begin
                        ns = S0; 
                        nop = O0; 
                    end
            S1: if(inp)
                    begin
                        ns = S1; 
                        nop = O0; 
                    end
                    
                else
                    begin
                        ns = S1; 
                        nop = O1; 
                    end
            default:
                begin
                    ns = S0;
                    nop = O0;
                end
        endcase    
    end
endmodule       