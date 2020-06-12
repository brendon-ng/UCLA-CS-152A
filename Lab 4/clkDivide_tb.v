`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:05:23 03/03/2020
// Design Name:   clockDivide
// Module Name:   C:/Users/152/Desktop/lab4/clkDivide_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clockDivide
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clkDivide_tb;

	// Inputs
	reg rst;
	reg clk;

	// Outputs
	wire slowClk;
	wire slowPulse;
	wire debounceClk;

	// Instantiate the Unit Under Test (UUT)
	clockDivide uut (
		.rst(rst), 
		.clk(clk), 
		.slowClk(slowClk), 
		.slowPulse(slowPulse), 
		.debounceClk(debounceClk)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

