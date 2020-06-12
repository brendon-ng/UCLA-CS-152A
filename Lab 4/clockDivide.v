`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:56 02/25/2020 
// Design Name: 
// Module Name:    clockDivide 
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


module clockDivide (rst, clk, slowClk, slowPulse, debounceClk);
	input clk;
	input rst;
	output slowClk;
	output slowPulse;
	output debounceClk;
	
	parameter timer = 200000000;
	
	assign slowPulse = (counter % timer == 0);
	
	reg slowClk_r;
	reg debounceClk_r;
	assign slowClk = slowClk_r;
	assign debounceClk = debounceClk_r;
	//assign debounceClk = clk;
	
	reg [31:0] counter;
	reg[31:0] debounceCounter;
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			counter = 0;
			slowClk_r = 0;
			debounceClk_r = 0;
			debounceCounter = 0;
		end
		else if (counter % 500 == 0) begin
			slowClk_r = ~slowClk_r;
			counter = counter + 1;
			debounceCounter = debounceCounter+1;
		end
		else if (debounceCounter >= timer/12000000) begin
			debounceClk_r = ~debounceClk_r;
			debounceCounter=0;
			counter= counter+ 1;
		end
		else if (counter > timer) begin
			counter = 1;
		end
		else begin
			counter = counter + 1;
			debounceCounter = debounceCounter+1;
		end
	end
endmodule
