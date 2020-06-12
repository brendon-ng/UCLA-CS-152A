/*
 * Module: Testbench for multiplexed combinational gates
 * 
 * Filename: combinational_gates_muxed_TB.v
 * Version: 1.0
 *
 * Author: Cejo Konuparamban Lonappan
 *
 * Description: The testbench code for verifying the multiplexed outputs of
 * eight comnibational gates. 
 */

`timescale 1ns / 1ps

module four_bit_counter_tb; // No inputs for a testbench!

// Inputs in the module to be tested will be port mapped to register variables
wire a0, a1, a2, a3;

// Outputs in the module to be tested will be port mapped to wire variables
reg clk, rst;

// Instantiation of the design module to be verified by the testbench
// Use named portmapping to map inputs to regsiter variables and outputs to
// wires
four_bit_counter FBC(.clk(clk), .rst(rst), .a0(a0), .a1(a1), .a2(a2), .a3(a3));



// IMPORTANT: Initialize all inputs. Otherwise the default value of register
// will be don't care (x).
initial
begin
	rst = 1'b1;
	clk = 1'b0;
end

// Use an always block to generate all the test cases
always begin
	rst = 1'b0;
	#5 clk <= ~clk;
end

// Code to terminate simulation after all the test cases have been covered.
initial
	#160 $finish; // After 160 timeunits, terminate simulation.

endmodule
