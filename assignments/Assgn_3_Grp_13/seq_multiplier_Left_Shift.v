`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2020 00:43:47
// Design Name: 
// Module Name: seq_multiplier_Left_Shift
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
 
// ASSIGNMENT 3 -- Question 2
// Sequential 6-bit unsigned binary array multiplier using left shift version
///////////////////////////////////////////////////////////////////////////////////
 
//Bidirectional shift register that shifts the value of Q by 1 bit 
//When load = 1 --> new data is loaded into register
//When load = 0 --> Enable = 1 --> data is shifted by 1 bit to right or left
module shiftreg(R, load, enable, shiftL, clk, Q);
	parameter n = 12;                          //12-bit binary numbers
	input [n-1:0] R;                           //12-bit input
	input load, enable, shiftL, clk;           //declaring load,enable,shift,clock
	output reg [n-1:0] Q;                      //obatining 12-bit result
	integer k;                                 //used as loop variable
	always @(posedge clk)                
		if (load) begin                            //initial loading of input into register
			Q <= R; 
		end
		else if (enable) begin                     //flag to indicate a right shift of bits
			if(shiftL) begin
				for (k = n-1; k > 0; k = k-1)       //shifting left by 1 bit
					Q[k] <= Q[k-1];       
				Q[0] <= 0;
			end                 
            else begin 
				for (k = 0; k < n-1; k = k+1)       //shifting right by 1 bit
					Q[k] <= Q[k+1];       
				Q[n-1] <= 0;     
            end
		end
endmodule
 
//Array multiplier for 6-bit designed using left shift property 
module unsigned_seq_mult_LS(load, clk, rst, a, b, product, Qa, Qb);
    input clk, rst, load;                   //reset to load values in register
	                                        //clock indicating positive signal
    input [5:0] a, b;                       //6-bit input variables
    output reg [11:0] product = 12'b0;      //12-bit product is obtained
    reg [7:0] count;                        //keeping count of # of bits covered
    output wire [11:0] Qa, Qb;              //storing shifted values of a and b
 
    //calling the shift register for the inputs a and b
    shiftreg A(a, rst, 1'b1, 1'b0, clk, Qa);
    shiftreg B(b, rst, 1'b1, 1'b1, clk, Qb);
 
    //calculating the partial sum after every step using left shift and storing in product
	always @(posedge clk)
		if (rst) begin
			product = 12'b0;
 
		end
		else begin
			if (Qa[0]) begin         //if lsb of B is 1 , partial sum addition is required
				product <= (product + Qb);
			end
			else begin               //if lsb of B is 0 , no partial sum addition is required
				product <= product;
			end
		end
    // Control the shifting process
	// maintaining count of input bits covered
	always @(posedge clk)
		if (rst) count = 7;             
		else if (run) count = count - 1;  
	assign run = |count;  
 
endmodule