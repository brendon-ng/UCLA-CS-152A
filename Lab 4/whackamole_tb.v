`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:19:37 02/20/2020
// Design Name:   whackamole
// Module Name:   C:/Users/152/Desktop/lab4/whackamole_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: whackamole
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module whackamole_tb;

	// Inputs
	reg [7:0] sw;
	reg btnE;
	reg btnN;
	reg btnH;
	reg rst;
	reg btnStart;
	reg clk;

	// Outputs
	wire [7:0] Led;
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	whackamole uut (
		.sw(sw), 
		.btnE(btnE), 
		.btnN(btnN), 
		.btnH(btnH), 
		.rst(rst), 
		.btnStart(btnStart), 
		.clk(clk), 
		.Led(Led), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		sw = 0;
		btnE = 0;
		btnN = 0;
		btnH = 0;
		rst = 1;
		btnStart = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 0;
		// Add stimulus here

	end
	always begin
		#5 clk = ~clk;
	end
	
      
endmodule

