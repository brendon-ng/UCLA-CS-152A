`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:54 01/30/2020 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(clk, rst, sw, pause_b, up_b, down_b, seg, an, Led);
	input rst;
	input pause_b;
	wire[3:0] num3, num2, num1, num0;
	input clk;
	input [7:0] sw;
	
	input up_b;
	input down_b;
	
	output [7:0] seg;
	output [3:0] an;
	output [7:0] Led;
	reg [6:0] led_data;
	wire a,b,c,d,e,f,g;
	reg [30:0] counter;
	reg [11:0] seconds;
	reg [3:0] an1;
	reg [3:0] an2;
	
	reg secClk;
	reg slowClk;
    reg lessSlowClk;
	reg lessSlowClk_d;
	
    reg overflow;
	
	//sw[0] == cnt_dn mode
	//sw[1] == adjust mode
	//sw[4] == adjustB
	//sw[3] == select
	
	wire running;
	//reg pause_b;
	reg paused = 0;
	reg pause;
	assign running = ~sw[1] && ~paused;
	
	assign {a,b,c,d,e,f,g} = led_data;
	assign seg[7:0] = {1'b1,g,f,e,d,c,b,a};
	assign num0[3:0] = seconds % 10;
	assign num1[3:0] = (seconds % 60) / 10;
	assign num2[3:0] = (seconds / 60) % 10;
	assign num3[3:0] = (seconds / 60) / 10;
	assign an[3:0] = an1 | an2;
	
	
	assign Led[5:0] = sw[5:0];
	assign Led[7] = paused;
	assign Led[6] = pause;
    //reg rst_art;
    //wire rst;
    //assign rst = rst_i | rst_art;
    
	
	
	
	//all debouncing - 4 buttons
	reg [2:0] step_pause;
	reg[2:0] step_up;
	reg[2:0] step_down;
	always@(posedge clk) begin
		//detect posedge of pause button
		if (rst) begin
			step_pause[2:0] <= 0;
			step_up[2:0] <= 0;
			step_down[2:0] <= 0;
		end
		else if(lessSlowClk) begin
			step_pause[2:0] <= {pause_b, step_pause[2:1]};
			step_up[2:0] <= {up_b, step_up[2:1]};
			step_down[2:0] <= {down_b, step_down[2:1]};
		end
	end
	
	reg pause_st;
	wire is_pause_posedge;
	assign is_pause_posedge = ~step_pause[0] & step_pause[1];
	reg up;
	reg down;
	wire is_up_posedge;
	assign is_up_posedge = ~step_up[0] & step_up[1];
	wire is_down_posedge;
	assign is_down_posedge = ~step_down[0] & step_down[1];
	always @ (posedge clk) begin
		if(rst) begin
			pause <= 0;
			up <= 0;
			down<= 0;
		end
		else if(lessSlowClk_d) begin
			pause <= is_pause_posedge;
			up <= is_up_posedge;
			down <= is_down_posedge;
		end
		else begin
			pause <= 0;
			up <= 0;
			down <= 0;
		end
	end

	/*
	always @ (posedge clk) begin
		if (rst) begin
			step_up[2:0] <= 0;
			step_down[2:0] <= 0;
		end
		else if (lessSlowClk) begin
			step_up[2:0] <= {up_b, step_up[2:1]};
			step_down[2:0] <= {down_b, step_down[2:1]};
		end
	end
	reg up;
	reg down;
	wire is_up_posedge;
	assign is_up_posedge = ~step_up[0] & step_up[1];
	wire is_down_posedge;
	assign is_down_posedge = ~step_down[0] & step_down[1];
	always@ (posedge clk) begin
		if (rst) begin
			up <= 0;
			down<= 0;
		end
		else if (lessSlowClk_d) begin
			up <= is_up_posedge;
			down <= is_down_posedge;
		end
		else begin
			up <= 0;
			down <= 0;
		end
	end
	*/

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			counter <= 0;
			secClk <= 0;
			slowClk <= 0;
			lessSlowClk <= 0;
		end
		else begin
			counter <= counter +1;
			lessSlowClk <= counter % 10000000;
			lessSlowClk_d <= lessSlowClk;
			if (counter >= 99999999) begin
				counter <= 0;	
			end
			if (counter % 25000000 == 0) begin
				secClk <= ~secClk;
			end
			if(counter % 500 == 0) begin
				slowClk <= ~slowClk;
			end
		end
	end
	
	//test
	
	wire full_sec;
	assign full_sec = (counter == 0);
	wire half_sec;
	assign half_sec = (counter%50000000 == 0);
	//always @(posedge secClk  or posedge pause or posedge rst or posedge down) begin
	always @(posedge clk) begin
		if(rst) begin
			seconds = 0;
            overflow = 0;
            //rst_art = 0;
		end
		else if(pause) begin
			if(~sw[0] && seconds >=  3599) begin
				paused = 0;
				seconds = 0;
         
			end
			if(~sw[1] && seconds < 3599) begin
				if (paused) paused = 0;
				else paused = 1;
			end
		end
		else if (running && ~sw[0] && full_sec && seconds < 3599) begin //normal mode, count up
            seconds = seconds + 1;
		end
      else if (running && ~sw[0] && full_sec && seconds >= 3599) begin
            paused = 1;
      end
        //else if (running && ~sw[0] && full_sec && seconds >= 3599) begin
        //    seconds = 0;
        //end
		else if (running && sw[0] && seconds>0 && full_sec) begin // normal mode, count down
			seconds = seconds-1;
		end
		else if (half_sec && sw[1] && ~sw[4]) begin //adjust mode, going up by 2
			if (~sw[3] && ~sw[4]) begin //minutes selected, not adjusted by buttons
				if ((seconds / 60)  >= 58) begin // If we are going to overflow
					seconds = seconds - 3600 + 120;
				end
				else begin // Normal +2 min increment
					seconds = seconds + 120;
				end
			end
			if (sw[3] && ~sw[4]) begin //seconds selected, not adjusted by buttons
				if ((seconds % 60)  >= 58) begin // If we are going to overflow
					seconds = seconds - 60 + 2;
				end
				else begin // Normal +2 sec increment
					seconds = seconds+ 2;
				end
			end
		end
		else if (sw[1] && (up ^ down) && sw[4]) begin
			if (sw[4] && up) //button mode
			begin
				if(sw[3]) begin
					if((seconds % 60) >= 59) begin
						seconds = seconds - 60 +1;
					end
					else begin
						seconds = seconds +1;
					end
				end
				else begin
					if((seconds/60) >= 59) begin
						seconds = seconds - 3600 + 60;
					end
					else begin
						seconds = seconds + 60;
					end
				end
				/*
				if (sw[3] && seconds<3599) 
					seconds = seconds + 1;
				else if (~sw[3] && seconds<3539)
					seconds = seconds + 60;
				else if (sw[3] && seconds >= 3599)
					seconds = 3599;
				else if (~sw[3] && seconds >=3539)
					seconds = 3599;
				*/
			end
			else if (sw[4] && down) begin
				if(sw[3]) begin
					if((seconds % 60) <= 0) begin
						seconds = seconds + 60 -1;
					end
					else begin
						seconds = seconds -1;
					end
				end
				else begin
					if((seconds/60) <= 0) begin
						seconds = seconds + 3600 - 60;
					end
					else begin
						seconds = seconds - 60;
					end
				end
				/*
				if (sw[3] && seconds > 0)
					seconds = seconds - 1;
				else if (~sw[3] && seconds>60)
					seconds = seconds - 60;
				else if (sw[3] && seconds <= 0)
					seconds = 0;
				else if (~sw[3] && seconds <=60)
					seconds = 0;
				*/
			end
		end
        else overflow = 0;
	end
	/*
	always @(posedge secClk or posedge rst) begin
		if(rst) full_sec = 1;
		else full_sec = ~full_sec;
	end
	*/
	
	reg[2:0] state;
	
	parameter st0 = 0;
	parameter st1 = 1;
	parameter st2 = 2;
	parameter st3 = 3;
	
	always @(posedge slowClk or posedge rst) begin
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
	
	/*
	// Pausing
	always @(posedge pause_b or posedge overflow) begin
        if (overflow) paused = 1;
        else if (~sw[1]) paused = ~paused;
	end
	*/

	//Flashing
	always @(negedge secClk) begin
		if (rst) an2 = 4'b0000;
		else begin
			if (sw[1] && ~sw[3]) begin
				an2 = an2 ^ 4'b1100;
				if(an2 == 4'b1111) an2 = 4'b0000;
			end
			else if (sw[1] && sw[3]) begin
				an2 = an2 ^ 4'b0011;
				if(an2 == 4'b1111) an2 = 4'b0000;
			end
			else
				an2 = 4'b0000;
		end
	end
		
	
	function[6:0] digToLed;
		input[3:0] dig;
		reg[3:0] dig;
		begin
			case(dig)
			0: digToLed=~7'b1111110;
			1: digToLed=~7'b0110000;
			2: digToLed=~7'b1101101;
			3: digToLed=~7'b1111001;
			4: digToLed=~7'b0110011;
			5: digToLed=~7'b1011011;
			6: digToLed=~7'b1011111;
			7: digToLed=~7'b1110000;
			8: digToLed=~7'b1111111;
			9: digToLed=~7'b1111011;
			endcase
		
		end
	endfunction
		
	
	
	
	

endmodule
