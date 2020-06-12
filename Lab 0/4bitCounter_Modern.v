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
module counter4bit(a,rst,clk);
    input rst, clk;
    output reg [3:0] a;

    always @(posedge clk) begin
        if (rst)
            a <= 4'b0000;
        else
            a <= a + 1'b1;
endmodule