`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:02:06 03/03/2020
// Design Name:   debounce
// Module Name:   C:/Users/152/Desktop/lab4/debounce_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debounce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debounce_tb;

	// Inputs
	reg clk;
	reg debounceClk;
	reg rst;
	reg btnE;
	reg btnN;
	reg btnH;
	reg btnStart;

	// Outputs
	wire easy_b;
	wire med_b;
	wire hard_b;
	wire start_b;

	// Instantiate the Unit Under Test (UUT)
	debounce uut (
		.clk(clk), 
		.debounceClk(debounceClk), 
		.rst(rst), 
		.btnE(btnE), 
		.btnN(btnN), 
		.btnH(btnH), 
		.btnStart(btnStart), 
		.easy_b(easy_b), 
		.med_b(med_b), 
		.hard_b(hard_b), 
		.start_b(start_b)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		debounceClk = 0;
		rst = 0;
		btnE = 0;
		btnN = 0;
		btnH = 0;
		btnStart = 0;

		// Wait 100 ns for global reset to finish
		#100;
        btnE = 1;
		#20000;
		btnE=0;
		// Add stimulus here
	end
		always begin 
			#5 clk = ~clk;
		end
		always begin
			#40 debounceClk = ~debounceClk;
		end
	
      
endmodule

