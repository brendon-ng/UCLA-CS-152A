`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:09:09 03/10/2020
// Design Name:   random
// Module Name:   C:/Users/152/Desktop/whackamole/rand_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: random
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rand_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] num1;
	wire [2:0] num2;
	wire [2:0] num3;

	// Instantiate the Unit Under Test (UUT)
	random uut (
		.clk(clk), 
		.rst(rst), 
		.num1(num1), 
		.num2(num2), 
		.num3(num3)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 0;
		// Add stimulus here
		
	end
	
	always begin #5 clk = ~clk; end
      
endmodule

