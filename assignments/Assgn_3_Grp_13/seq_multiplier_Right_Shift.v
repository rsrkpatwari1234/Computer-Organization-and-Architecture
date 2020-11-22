`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2020 00:40:23
// Design Name: 
// Module Name: seq_multiplier_Right_Shift
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
//AUTUMN 2020 
//STUDENTS : ATHARVA ROSHAN NAIK (18CS10067)
//            RADHIKA PATWARI (18CS10062)
 
// ASSIGNMENT 3 -- Question 3
// Sequential 6-bit unsigned binary array multiplier using right shift version
///////////////////////////////////////////////////////////////////////////////////
 
//Right shift register that shifts the value of Q by 1 bit 
//When load = 1 --> new data is loaded into register
//When load = 0 --> Enable = 1 --> data is shifted by 1 bit to right
module shiftval (R, Load, Enable, w, Clock, Q);
	parameter n = 6;                       //6-bit binary numbers
	input [n-1:0] R;                       //6-bit input variable
	input Load, Enable, w, Clock;          //declaration of load,enable,clock and new msb bit
	output reg [n-1:0] Q;                  //6-bit binary output obtained after shifting 1-bit right
	integer k;                             //used as loop variable
	always @(posedge Clock)                //executing the statements on pos edge of clock
		if (Load)                          //loading data into register
			Q <= R;      
		else if (Enable)                  //Enable indicate if a right shift need to be made
			begin    
				for (k = 0; k < n-1; k = k+1)   //shifting right by 1 bit
					Q[k] <= Q[k+1];
				Q[n-1] <= w;
			end
endmodule
 
//modified shift register such that first the input value is added to old value of register
//then a right shift of 1-bit is done to obtain new value of register
module shiftpro (R, Load, Enable, w, Clock, Q);
	parameter n = 12;                  //output after multiplication can be of atmost 12 bits
	input [n-1:0] R;                   //declaring the 12 bit input register
	input Load, Enable, w, Clock;      //declaring load,enable.clock and msb bit
	output reg [n-1:0] Q;              //declaring the 12 bit output
	integer k;                         //loop variable
 
	always @(posedge Clock)            //executing the statements on pos edge of clock
		if (Load)                     //loading data into register
			Q = R;
		else if (Enable)               //Enable indicate if a right shift need to be made
			begin
				for (k = 0; k < n-1; k = k+1)  //shifting right by 1 bit
					Q[k] = Q[k+1];
				Q[n-1] = w;
				Q = Q + R;              //adding the new value to the register
			end
endmodule
 
 
//Array multiplier for 6-bit designed using right shift property 
module unsigned_seq_mult_RS (Clock, Reset, A, B, Product, Run);
 
	input [5:0] A, B;                      //6-bit input variables
	input Reset, Clock;                    //reset to load values in register
	                                       //clock indicating positive signal
	output wire [11:0] Product;            //12-bit product is obtained
 
	wire [5:0] QB;                         //storing B using 1-bit right shift
	reg [3:0] Count;                       //keeping count of # of bits covered
	reg [11:0] Partpro = 12'b0;            //storing partial sum after each step of multiplication
	output wire Run;                       //indicate if all 6 bits of input have been completed
	parameter G = 1'b0, H = 1'b1;          //bit values 0 and 1
 
	integer k, i;                          //loop variables
 
    //using right shift register to shift B 1 step to right after each step of multiplication
	shiftval shift_B (B, Reset, 1'b1, 1'b0, Clock, QB);
 
	//using modified right shift register to add partial sum to obtained output
	shiftpro shift_Pro (Partpro, Reset, Run, 1'b0, Clock, Product);
 
    //checking if a addition is required
	always @(Run or QB)
		case (QB[0])
			G: begin             //if lsb of B is 0 , no partial sum addition is required
				Partpro = 12'b0;
				end
			H: begin             //if lsb of B is 1 , partial sum addition is required
				Partpro[4:0] = 0;
				Partpro[10:5] = A[5:0];
				Partpro[11] = 0;
				end
		endcase
 
	// Control the shifting process
	// maintaining count of input bits covered
	always @(posedge Clock)
		if (Reset)
			Count = 7;
		else if (Run)
			Count = Count - 1;
	assign Run = |Count;
 
endmodule