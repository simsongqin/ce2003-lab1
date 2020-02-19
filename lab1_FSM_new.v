`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:12 02/05/2020 
// Design Name: 
// Module Name:    lab1_FSM 
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
module lab1_FSM(
    input clk,
    input rst,
    input cancel,
    input dollar,
    input fifty,
    output reg money_return,
    output reg dispense,
    output reg insert_coin,
    output reg [1:0] st
    );

parameter INIT = 2'b00, S50c = 2'b01, VEND = 2'b10, RETURN = 2'b11;
reg[1:0] nst, cur_st;


always @(posedge clk)
begin
	if(!rst)
		cur_st<=INIT;
	else
		cur_st<=nst;
end // end always

always @*
begin
	nst = cur_st;
	case(cur_st)
	INIT: begin // start state
		st = 2'b00;
		money_return = 0;
		dispense = 0;
		insert_coin = 1;
		if(fifty)
			nst = S50c;  // 50c state
		if(dollar) 
			nst = VEND;  // $1 state
			
		end // end init
	
	S50c: begin // 50c state
		st = 2'b01;
		money_return = 0;
		dispense = 0;
		insert_coin = 1;
		if(fifty) 
			nst = VEND;  // $1 state
			
		if(dollar || cancel) 
			nst = RETURN;  // return state
			
		end
		
	VEND: begin // VEND STATE
		st = 2'b10;
		money_return = 0;
		dispense = 1;
		insert_coin = 0;
		if(!rst)
			nst = INIT;
			
		end
	RETURN: begin // RETURN STATE
		st = 2'b11;
		money_return = 1;
		dispense = 0;
		insert_coin = 0;
		
		nst = INIT;
		end
	endcase
	
end

endmodule