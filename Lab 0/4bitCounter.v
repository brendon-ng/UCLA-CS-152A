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
module counter4bit(a0,a1,a2,a3,rst,clk);
    input rst, clk;
    output reg a0;
    output reg a1;
    output reg a2;
    output reg a3;

    always @(posedge clk) begin
        if(rst) begin
        a0 <= 1'b0;
        a1 <= 1'b0;
        a2 <= 1'b0;
        a3 <= 1'b0;
    end
    else begin
        a3 <= (a0 & a1 & a2) ^ a3;
        a2 <= (a0 & a1) ^ a2;
        a1 <= a1 ^ a0;
        a0 <= ~a0;
    end
    end
endmodule