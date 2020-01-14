`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:53:11 01/14/2020 
// Design Name: 
// Module Name:    lab1 
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
module lab1(D, S, E, F);
	input wire[11:0] D;
	output reg S;
	output reg[2:0] E;
	output reg[3:0] F;

	reg[11:0] unsignedMag;
	reg fifthBit;
	
	always @(*) begin
	//get sign bit
		S = D[11];
		//convert to signed magnitude
		if (S == 0) begin
			unsignedMag = {1'b0, D[10:0]};
		end
		else begin
			unsignedMag = {1'b0, ~D[10:0]}+1;
		end
		
		//count leading zeroes
		if (unsignedMag[11] == 0) begin
			if (unsignedMag[10] == 0)
				if (unsignedMag[9] == 0)
					if (unsignedMag[8] == 0)
						if (unsignedMag[7] == 0)
							if (unsignedMag[6] == 0)
								if (unsignedMag[5] == 0)
									if (unsignedMag[4] == 0) begin
										E = 0;
										F = unsignedMag[3:0];
										fifthBit = 0;
									end	
									else begin
										E = 1;
										F = unsignedMag[4:1];
										fifthBit = unsignedMag[0];
									end
								else begin
									E = 2;
									F = unsignedMag[5:2];
									fifthBit = unsignedMag[1];
								end
							else begin
								E = 3;
								F = unsignedMag[6:3];
								fifthBit = unsignedMag[2];
							end
						else begin
							E = 4;
							F = unsignedMag[7:4];
							fifthBit = unsignedMag[3];
						end
					else begin
						E = 5;
						F = unsignedMag[8:5];
						fifthBit = unsignedMag[4];
					end
				else begin
					E = 6;
					F = unsignedMag[9:6];
					fifthBit = unsignedMag[5];
				end
			else begin
				E = 7;
				F = unsignedMag[10:7];
				fifthBit = unsignedMag[6];
			end
			//rounding
			if (fifthBit == 1'b1) begin
				if (F == 4'b1111) begin
					if (E != 3'b111) begin
						E = E+1;
						F = 0;
					end
				end
			else
				F = F+1;
			end
		end
		else begin //return max
			E = 3'b111;
			F = 4'b1111;
		end
	
	
	//get significand
	//F = unsignedMag[12-E:8-E];
	
		
	//end of always block below
	end
endmodule
