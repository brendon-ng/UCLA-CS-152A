/*
 * Module: Multiplexed combinational gates
 * 
 * Filename: combinational_gates_muxed.v
 * Version: 1.0
 *
 * Author: Cejo Konuparamban Lonappan
 *
 * Description: RTL for implementing eight combinational gates with the 
 * outputs of the gates multiplexed using an 8:1 Multiplexer. The gates
 * implemented are NAND, AND, NOR, OR, XOR, XNOR, NOT, and a non-inverting
 * buffer. 
 */

module clk_divider(clk, rst, led);
	input clk, rst;
	output led;
	
	reg led;
	reg [26:0] counter;
	
	always@(posedge rst or posedge clk) begin
		if (rst) begin
			led <= 0;
			counter <= 0;
		end
		else
			if (counter >= 50000000) begin
				counter <= 0;
				led <= ~led;
			end
			else begin
				counter <= counter + 1;
			end
	end
	
endmodule
