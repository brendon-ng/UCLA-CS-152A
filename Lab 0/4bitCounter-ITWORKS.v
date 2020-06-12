`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:54 01/09/2020 
// Design Name: 
// Module Name:    counter4bit 
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
module counter4bit(a0,a1,a2,a3, modern,rst,clk1);
    input rst, clk1;
    output reg a0;
    output reg a1;
    output reg a2;
    output reg a3;
	output reg[3:0] modern;
	
    always @(posedge clk1) begin
		if(rst) begin
			modern = 0;
			a3 = 0;
			a2 = 0;
			a1 = 0;
			a0 = 1'b0;
		end
		else begin
			a3 =((a0 & a1 & a2) ^ a3);
			a2 = ((a0 & a1) ^ a2);
			a1 = (a1 ^ a0);
			a0 = (~a0);
			modern = modern+1;
		end
    end
endmodule
