`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:24 02/20/2020 
// Design Name: 
// Module Name:    whackamole 
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

module whackamole(
	sw, btnE, btnN, btnH, rst, btnStart, clk, Led, seg, an);
	
	parameter timer = 200000000;

	
	input [7:0]sw;
	input btnE, btnN, btnH, rst, btnStart;
	input clk;
	
	output [7:0] Led;
	output [7:0] seg;
	output [3:0] an;
	
	
	wire [2:0] num1;
	wire [2:0] num2;
	wire [2:0] num3;

	reg gameOver;
    reg go;
	
	reg [20:0] hiscore1 =0;
	reg [20:0] hiscore2 =0;
	reg [20:0] hiscore3 =0;
	
	wire slowClk;
	wire running;
	wire slowPulse;
	wire debounceClk;
	assign running = ~gameOver;
	
	reg stchange;
	reg [20:0] score;
	
	reg [7:0] desiredState;
	reg [7:0] previousState;
    reg [1:0] level;
	reg [31:0] timerFactor;
	
	wire easy_b;
	wire med_b;
	wire hard_b;
	
	reg [1:0] gameState;
	parameter beginning = 0;
	parameter playing = 1;
	parameter ended = 2;
	parameter ready = 3;
	
	random rand_(.clk(clk), .rst(rst), .num1(num1), .num2(num2), .num3(num3));
    
	clockDivide clkDiv_(.clk(clk), .rst(rst), .slowClk(slowClk), .slowPulse(slowPulse), .debounceClk(debounceClk));
	
    display dis(.rst(rst), .clk(clk), .score(score), .level(level), .gameState(gameState), .stchange(stchange), .hiscore1(hiscore1), .hiscore2(hiscore2), .hiscore3(hiscore3), .seg(seg), .an(an), .go(go));
    debounce deb(.clk(clk), .debounceClk(debounceClk), .rst(rst), .btnE(btnE), .btnN(btnN), .btnH(btnH), .btnStart(btnStart), 
	.easy_b(easy_b), .med_b(med_b), .hard_b(hard_b), .start_b(start_b));
	
	//to do:
	//multiple LEDs lighting up -- DONE
	//level 3 -- make timer faster
	//debounce buttons -- DONE
	//game over flashing score
	
	reg[26:0] buffercounter;
	reg[26:0] failcounter;
    
	reg success;
	//or posedge rst or posedge btnStart or posedge btnE or posedge btnN or posedge btnH

	reg [7:0] gameOverLed;
	assign Led[7:0] = (sw[7:0] ^ desiredState[7:0]) | gameOverLed[7:0];

	reg [7:0] mask;
	
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			//Led[7:0] = 0;
			gameOverLed = 0;
			gameOver = 1;
            go = 0;
			score = 0;
            level = 0;
			desiredState = sw;
			previousState = sw;
			mask = 8'b11111111;
			success = 0;
			gameState = beginning;
			stchange = 0;
		end	
		
        else if (start_b) begin
            //Led[7:0] = 0;
			if(level == 0) level = 1;
            gameOver = 0;
            go = 0;
            score = 0;
			desiredState = sw;
			mask = 8'b11111111;
			previousState = 0;
			gameOverLed = 0;
			success = 1;
			gameState = playing;
			stchange = 1;
        end
        else if (easy_b) begin
            level = 1;
			timerFactor = timer/3;
			gameState = ready;
			stchange = 1;
        end
        else if (med_b) begin
            level = 2;
			timerFactor = timer/3;
			gameState = ready;
			stchange = 1;
        end
        else if (hard_b) begin
            level = 3;
			timerFactor = timer/2;
			gameState = ready;
			stchange = 1;
        end
		else if (running) begin
			stchange = 0;
			if(slowPulse) begin
				previousState = sw[7:0];
				if (level == 2 || level==3) begin
					desiredState = (oneHot(num1)|oneHot(num2)) ^sw[7:0];
					mask = ~(oneHot(num1) | oneHot(num2));
				end	
				else begin
					desiredState = oneHot(num1) ^ sw[7:0];
					mask = ~oneHot(num1);
				end
				buffercounter = 0;
				success = 0;
			end
            else if (desiredState == sw && !success) begin
				success = 1;
				//Led[7:0] = 0;
				score = score+1;
				buffercounter = 0;
			end
			else if((sw&mask) != (previousState&mask) && (sw&mask) != (desiredState&mask)) begin
				gameOver = 1;
                go = 1;
				gameState = ended;
				stchange = 1;
				if(level == 1 && score >= hiscore1) hiscore1 = score;
				else if(level == 2 && score >= hiscore2) hiscore2 = score;
				else if(level == 3 && score >= hiscore3) hiscore3 = score;
			end
			else if(buffercounter >= timer - timerFactor) begin
				gameOver = 1;
                go = 1;
                buffercounter = 0;
				gameState = ended;
				stchange = 1;
				if(level == 1 && score >= hiscore1) hiscore1 = score;
				else if(level == 2 && score >= hiscore2) hiscore2 = score;
				else if(level == 3 && score >= hiscore3) hiscore3 = score;
			end 
			
			else if(!success) buffercounter = buffercounter + 1;
		end
		else if (gameOver) begin
			stchange = 0;
			//Led[7:0] = 8'b11111111;
			gameOverLed[7:0] = 8'b11111111;
            if (failcounter >= timer - timer/3) begin 
                go = 0;
                failcounter = 0;
            end
            else if (go) failcounter = failcounter + 1;
		end
	end

	function [7:0] oneHot;
		input [2:0] num;
		begin
		case(num)
			0: oneHot = 8'b10000000;
			1: oneHot = 8'b00000001;
			2: oneHot = 8'b00000010;
			3: oneHot = 8'b00000100;
			4: oneHot = 8'b00001000;
			5: oneHot = 8'b00010000;
			6: oneHot = 8'b00100000;
			7: oneHot = 8'b01000000;
		endcase
		end
	endfunction

endmodule






module debounce(clk, debounceClk, rst, btnE, btnN, btnH, btnStart, 
	easy_b, med_b, hard_b, start_b);

	input clk, debounceClk, rst, btnE, btnN, btnH, btnStart;
	output easy_b, med_b, hard_b, start_b;
	
	reg [2:0] step_easy;
	reg[2:0] step_med;
	reg[2:0] step_hard;
	reg[2:0] step_start;
	
	always@(posedge clk) begin
		//detect posedge of pause button
		if (rst) begin
			step_easy[2:0] <= 0;
			step_med[2:0] <= 0;
			step_hard[2:0] <= 0;
			step_start[2:0] <= 0;
		end
		else if(debounceClk) begin
			step_easy[2:0] <= {btnE, step_easy[2:1]};
			step_med[2:0] <= {btnN, step_med[2:1]};
			step_hard[2:0] <= {btnH, step_hard[2:1]};
			step_start[2:0] <= {btnStart, step_start[2:1]};
		end
	end
	
	reg easy_st;
	wire is_easy_posedge;
	assign is_easy_posedge = ~step_easy[0] & step_easy[1];
	reg med_st;
	reg hard_st;
	reg start_st;
	wire is_med_posedge;
	assign is_med_posedge = ~step_med[0] & step_med[1];
	wire is_hard_posedge;
	assign is_hard_posedge = ~step_hard[0] & step_hard[1];
	wire is_start_posedge;
	assign is_start_posedge = ~step_start[0] & step_start[1];
	
	assign easy_b = easy_st;
	assign med_b = med_st;
	assign hard_b = hard_st;
	assign start_b = start_st;
	
	always @ (posedge clk) begin
		if(rst) begin
			easy_st <= 0;
			med_st <= 0;
			hard_st<= 0;
			start_st <= 0;
		end
		else if(debounceClk) begin
			easy_st <= is_easy_posedge;
			med_st <= is_med_posedge;
			hard_st <= is_hard_posedge;
			start_st <= is_start_posedge;
		end
		else begin
			easy_st <= 0;
			med_st <= 0;
			hard_st<= 0;
			start_st <= 0;
		end
	end

endmodule
