`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:32:48 01/14/2020
// Design Name:   lab1
// Module Name:   C:/Users/152/Desktop/lab1/lab1_TB.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lab1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab1_TB;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	lab1 uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		
		#100;
        /*
		// Add stimulus here
		D = 1;
		#100
		
		D = 2;
		#100
		D=-40;
		#100
		D = 56;
		#200
		//rounding
		D = 12'b000000101100;
		#100;
		D = 12'b000000101101;
		#100;
		D = 12'b000000101111;
		#100;
		D = 12'b000000101110;
		#100;	
		D=0;	
*/		

		D = 0;
		#100
		D = 1;
		#100
		D = -1;
		#100
		D = 3201;
		#100
		D = 100;
		#100
		D = 12'b000000101100;
		#100
		D = D + 1;
		#100
		D = 12'b000000101110;
		#100
		D = D + 1;
		#100
		D = 12'b000000111111;
		#100
		D = 247;
		#100
		D = 248;
		#100
		D = 12'b100000000000;
		#100
		D = -2048;
		#100
		D = 2047;
		#100;
		
	end
/*
	always begin
		#100 D=D+1;
		if (D == 12'b011111111111) $finish;
	end
*/
	//pick cases for rounding, 0, 1, max, min, overflow, negative, positive, run through -2048-2047
	//explain why these are edge cases
endmodule

