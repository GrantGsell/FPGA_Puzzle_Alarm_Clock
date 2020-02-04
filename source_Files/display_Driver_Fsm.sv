`timescale 1ns / 1ps
//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module display_Driver_Fsm(output logic [1:0] anode_sel, output logic [1:0] digit_sel,
	input logic clk, input logic rst, input logic m_sec);
	// define and enumerate state variables
	enum logic [1:0] {D0, D1, D2, D3} state, next_state;
	// sequential logic
	always @(posedge clk) begin
		state <= next_state;
	end
	// combinational for state machine
	always @* begin
	// complete the combinational logic for the state machine
		// defaults
		next_state = state; //Hold Condition if m_sec = 0
		// main logic
		case(state)
			D0: begin
				if(m_sec == 1) next_state = D1;	
				anode_sel = 2'b00;
				digit_sel = 2'b00;
			end
			D1:begin
				if(m_sec == 1) next_state = D2;
				anode_sel = 2'b01;
				digit_sel = 2'b01;
			end
			D2:begin
				if(m_sec == 1) next_state = D3;
				anode_sel = 2'b10;
				digit_sel = 2'b10;
			end
			D3 :begin
				if(m_sec == 1) next_state = D0;
				anode_sel = 2'b11;
				digit_sel = 2'b11;
			end
		endcase
		// priority logic
		if(rst == 1) next_state = D0;
	end // combinational state machine always
endmodule