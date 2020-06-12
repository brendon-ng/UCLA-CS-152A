`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:02 02/20/2020 
// Design Name: 
// Module Name:    random 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module random(clk, rst, num1, num2, num3);
	input clk;
	input rst;
	output [2:0] num1;
	output [2:0] num2;
	output [2:0] num3;
	
	reg [31:0] out1;
	reg [31:0] out2;
	reg [31:0] out3;

	wire feedback1;
	assign feedback1 = ~(out1[3] ^ out2[2] ^ out3[17] ^ out1[out2[2:0]]);
	wire feedback2;
	assign feedback2 = (out3[15] ^ out2[25] ^ out1[8] ^ out3[out1[5:3]]);
	
	assign num1[2:0] = out1[31:0] % 8;
	assign num2[2:0] = out2[31:0] % 8;
	assign num3[2:0] = out3[31:0] % 8;
	
	always @ (posedge clk or posedge rst) begin
		if(rst) begin
			out1 = 0;
			out2 = 0;
			out3 = 0;
		end
		else begin
			out1 = {out1[29:0], feedback1, feedback2};
			out2 = {out2[29:0], feedback2, feedback1};
			out3 = {out3[17:0], feedback1, feedback2, out3[31:18]};
		end
	end

endmodule
