`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:51:15
// Design Name: 
// Module Name: serial_adder
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
 
// n-bit left to right shift register , here n = 8 , for 8-bit values
// R : input bits
// load : signal to load values into the temporary register
// Enable : shifting all bits from left to right by 1 bit at positive clock edge
// w : value to be filled at the MSB while shifting the bits to right
// Clock : signal the timing to synchronise the circuit
// Q : the new shifted value obtained after 1-bit shift
module shiftrne (R, Load, Enable, w, Clock, Q);
	parameter n = 8;
	input [n-1:0] R;
	input Load, Enable, w, Clock;
	output reg [n-1:0] Q;
	integer k;                               //used as loop variable
	always @(posedge Clock)                  //works only at positive edge of clock
		if (Load)                            //initial loading of input into register
			Q <= R; 
		else if (Enable)                     //flag to indicate a right shift of bits
			begin
				for (k = 0; k < n-1; k = k+1)//loop for shifting values to right
					Q[k] <= Q[k+1];       
				Q[n-1] <= w;                 //storing final value at MSB of shifted value
			end
endmodule
 
// 8-bit serial adder for adding 2 8-bit inputs from LSB at every positive edge of clock
// using 3 left to right shift registers such that values are added from LSB of input
// and stored at MSB of output
module serial_adder(A, B, Reset, Clock, cin, Sum, cout,Run);
	input [7:0] A, B;                         //A,B : 8-bit input values
	input Reset, Clock;                       //Reset:flag for loading data
	input cin;                                //initial input carry to the adder
	output wire [7:0] Sum;                    //Final out sum of 8-bits
	output reg cout;                          //Final output carry
	reg [7:0] Count;                          //maintaining count of 8 bits
	reg s, y, Y;                       
	wire [7:0] QA, QB;                         //storing shifted input values 
	output wire Run;                           //signal to shift register to shift sum values
	parameter G = 1'b0, H = 1'b1;              //2 states of in_carry 0 and 1
 
	shiftrne shift_A (A, Reset, 1'b1, 1'b0, Clock, QA); //shifting input A
	shiftrne shift_B (B, Reset, 1'b1, 1'b0, Clock, QB); //shifting input B
	shiftrne shift_Sum (8'b0, Reset, Run, s, Clock, Sum);    //shifting sum value
 
	// Adder FSM implemented based on mealy machine
	// Output and next state combinational circuit
	always @(QA, QB, y)
		case (y)
			G: begin
				s = QA[0]^QB[0];
				if (QA[0] & QB[0]) Y = H;
				else Y = G;
				cout = y;
				end
			H: begin
				s = QA[0]~^QB[0];
				if ( ~QA[0] & ~QB[0]) Y = G;
				else Y = H;
				cout = y;
				end
			default: begin
				Y = G;
				cout = y;
				end
		endcase
 
	// Sequential block
	always @(posedge Clock)
		if (Reset)
			y <= G;                   //loading start state as 0 as no input implies 0 carry out
		else y <= Y;                  //updating state at every pos edge of clock
 
	// Control the shifting process
	always @(posedge Clock)
		if (Reset) Count = 9;             //starting count at 9 and ending at 1
		else if (Run) Count = Count - 1;  //ensuring final 8-bit sum is stored in sum 
	assign Run = |Count;                  //signalling the register to make a 1-bit shift
 
endmodule