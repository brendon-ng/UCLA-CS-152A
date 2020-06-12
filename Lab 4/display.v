`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:12:44 02/25/2020 
// Design Name: 
// Module Name:    display 
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
module display(rst, clk, score, level, gameState, stchange, hiscore1, hiscore2, hiscore3, seg, an, go);
	input rst, clk;
	input [20:0] score;
    input [1:0] level;
    input go;
    input [1:0] gameState;
	input stchange;
	input [20:0] hiscore1, hiscore2, hiscore3;
	output [7:0] seg;
	output [3:0] an;
	reg flashClk;
	
	reg [3:0] an1;
	reg [7:0] led_data;
	
	wire a,b,c,d,e,f,g,h;
	
	assign an = an1;
	assign {a,b,c,d,e,f,g,h} = led_data;
	assign seg[7:0] = {h,g,f,e,d,c,b,a};
	
	wire [5:0] num1, num2, num3, num0;
	reg [5:0] scorenum0, scorenum1, scorenum2, scorenum3;
	reg [5:0] gonum0, gonum1, gonum2, gonum3;
	assign num0 = gonum0 + scorenum0;
	assign num1 = gonum1 + scorenum1;
    assign num2 = gonum2 + scorenum2;
	assign num3 = gonum3 + scorenum3;
	
	reg[2:0] state;
	
	parameter st0 = 0;
	parameter st1 = 1;
	parameter st2 = 2; 
	parameter st3 = 3; 

	parameter beginning = 0;
	parameter playing  = 1;
	parameter ended = 2;
	parameter ready = 3;

	parameter F = 10;
	parameter A = 11;
	parameter I = 12;
	parameter L = 13;
	parameter Sp = 14;
	parameter S = 15;
	parameter C = 16;
	parameter O = 17;
	parameter R = 18;
	parameter E = 19;
	parameter H = 20;
	parameter V = 21;


    always@(posedge clk or posedge rst)begin
    	if(rst) begin
    		scorenum0 = 0;
    		scorenum1 = 0;
    		scorenum2 = 0;
    		scorenum3 = 0;
    		gonum0 = 0;
    		gonum1 = 0;
    		gonum2 = 0;
    		gonum3 = 0;
    	end
    	else if(gameState == playing) begin
    		scorenum0 = score % 10;
    		scorenum1 = (score /10) % 10;
    		scorenum2 = level;
    		scorenum3 = L;
    		gonum0 = 0;
    		gonum1 = 0;
    		gonum2 = 0;
    		gonum3 = 0;
    	end
    	else if(gameState == ended) begin
    		scorenum0 = 0;
    		scorenum1 = 0;
    		scorenum2 = 0;
    		scorenum3 = 0;
    		gonum0 = tickernum0;
    		gonum1 = tickernum1;
    		gonum2 = tickernum2;
    		gonum3 = tickernum3;
    	end
    	else if(gameState == ready) begin
			scorenum0 = 0;
    		scorenum1 = 0;
    		scorenum2 = 0;
    		scorenum3 = 0;
    		gonum0 = tickernum0;
    		gonum1 = tickernum1;
    		gonum2 = tickernum2;
    		gonum3 = tickernum3;
    	end
		else if(gameState == beginning) begin
			scorenum0 = 0;
    		scorenum1 = 0;
    		scorenum2 = 0;
    		scorenum3 = 0;
    		gonum0 = tickernum0;
    		gonum1 = tickernum1;
    		gonum2 = tickernum2;
    		gonum3 = tickernum3;
		end
    end

	reg [5:0] tickernum1, tickernum2, tickernum3, tickernum0;
    reg[9:0] tickerSt;
	parameter beginstart = 29;
	parameter readystart = 45;
    always @(posedge flashClk or posedge rst or posedge stchange) begin
    	if(rst) begin
    		tickerSt = 0;
    	end
    	else if(tickerSt == 0 || stchange == 1) begin
    		if(gameState == ended) tickerSt = 1;
			else if(gameState == beginning) tickerSt = beginstart;
			else if(gameState == ready) tickerSt = readystart;
			else tickerSt = 0;
    	end
    	else if(tickerSt == 1 || tickerSt == 2 || tickerSt == 3) begin
    		tickernum3 = F;
    		tickernum2 = A;
    		tickernum1 = I;
    		tickernum0 = L;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 4 || tickerSt == 5) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 6) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = S;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 7) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = C;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 8) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = O;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 9) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = R;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 10) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 11) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 12) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = (score /10) % 10;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 13) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = score % 10;
    		tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 14 || tickerSt == 15 || tickerSt==16) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
			if(level == 1 && score >= hiscore1) tickerSt = 18;
			else if(level == 2 && score >= hiscore2) tickerSt = 18;
			else if(level == 3 && score >= hiscore3) tickerSt = 18;
			else tickerSt = tickerSt + 1;
    	end
    	else if(tickerSt == 17) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
			tickerSt = 0;
    	end
		else if(tickerSt == 18) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = H;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 19) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = I;
    		tickerSt = tickerSt + 2;
    	end
		else if(tickerSt == 20) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 21) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = S;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 22) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = C;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 23) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = O;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 24) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = R;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 25) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 26 || tickerSt == 27) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt + 1;
    	end
		else if(tickerSt == 28) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = 0;
    	end
		else if(tickerSt == beginstart) begin
    		tickernum3 = C;
    		tickernum2 = H;
    		tickernum1 = O;
    		tickernum0 = O;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+1) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = S;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+2) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+3) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+4) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = L;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+5) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+6) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = V;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+7) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+8) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = L;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+9) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == beginstart+10) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = 0;
    	end
		else if(tickerSt == readystart+0) begin
    		tickernum3 = L;
    		tickernum2 = E;
    		tickernum1 = V;
    		tickernum0 = E;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+1) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = L;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+2) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+3) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = level;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+4) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+5) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = H;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+6) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = I;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+7) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = S;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+8) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = C;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+9) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = O;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+10) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = R;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+11) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = E;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+12) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+13) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		if(level == 1) begin
				tickernum0 = (hiscore1 /10) % 10;
			end
			else if(level == 2) begin
				tickernum0 = (hiscore2 /10) % 10;
			end
			else if(level == 3) begin
				tickernum0 = (hiscore3 /10) % 10;
			end
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+14) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		if(level == 1) begin
				tickernum0 = hiscore1 % 10;
			end
			else if(level == 2) begin
				tickernum0 = hiscore2 % 10;
			end
			else if(level == 3) begin
				tickernum0 = hiscore3 % 10;
			end
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+15 || tickerSt == readystart+16) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = tickerSt+1;
    	end
		else if(tickerSt == readystart+17) begin
    		tickernum3 = tickernum2;
    		tickernum2 = tickernum1;
    		tickernum1 = tickernum0;
    		tickernum0 = Sp;
    		tickerSt = 0;
    	end

    end

    
	reg displayClk;

	
	always @(posedge displayClk or posedge rst) begin
		if(rst) begin
			an1 = 4'b0000;
			state  = 0;
		end
		else begin
			case(state)
			st0: begin
				led_data = digToLed(num0);
				an1 = 4'b1110;
				state = state+1;
			end
			st1: begin
				led_data = digToLed(num1);
				an1 = 4'b1101;
				state = state +1;
			end
			st2: begin
				led_data = digToLed(num2);
				an1 = 4'b1011;
				state = state +1;
			end
			st3: begin
				led_data = digToLed(num3);
				an1 = 4'b0111;
				state = 0;
			end
			default: begin
				state = 0;
			end
			endcase
		end
	end

	
	reg[26:0] counter;
	reg[26:0] flashCount;
	always @(posedge clk or posedge rst) begin
		if(rst)begin
			counter =0;
			displayClk = 0;
			flashCount =0;
            flashClk = 0;
		end
		else if (counter >= 500) begin
			displayClk = ~displayClk;
			counter = 0;
		end
		else if (flashCount >= 20000000) begin
            flashClk = ~flashClk;
            flashCount = 0;
        end
		else begin
			counter = counter + 1;
			flashCount = flashCount + 1;
		end
	end
	
	 
	function[7:0] digToLed;
		input[5:0] dig;
		reg[5:0] dig;
		begin
			case(dig)
			0: digToLed=~8'b11111100;
			1: digToLed=~8'b01100000;
			2: digToLed=~8'b11011010;
			3: digToLed=~8'b11110010;
			4: digToLed=~8'b01100110;
			5: digToLed=~8'b10110110;
			6: digToLed=~8'b10111110;
			7: digToLed=~8'b11100000;
			8: digToLed=~8'b11111110;
			9: digToLed=~8'b11110110;
            L: digToLed=~8'b00011100; 
           	F: digToLed=~8'b10001110; 
            A: digToLed=~8'b11101110; 
            I: digToLed=~8'b00001100; 
            Sp: digToLed=~8'b00000000;
            S: digToLed=~8'b10110110; 
           	C: digToLed=~8'b10011100; 
            O: digToLed=~8'b11111100;
            R: digToLed=~8'b00001010; 
            E: digToLed=~8'b10011110; 
			H: digToLed=~8'b01101110; 
			V: digToLed=~8'b01111100; 
			endcase
		
		end
	endfunction

endmodule
	