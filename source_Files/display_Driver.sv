//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
`timescale 1ns / 1ps
module display_Driver( 
    output logic [6:0] cathode, 
    output logic [3:0] anode,
	output logic [1:0] anode_sel,
	output logic dot, 
	output logic m_sec,
	input logic [13:0] input_Time,
	input logic display_on, 
	input logic rst, 
	input logic clk
	);
	//Internal Wire Instantiations
	logic [1:0] digit_sel;
	logic [2:0] digit3; 
    logic [3:0] digit2; 
    logic [2:0] digit1;
	logic [3:0] digit0;
	logic am_Pm_Bit;
	//Input Time split into Digits
	assign digit0 = input_Time[3:0]; 
	assign digit1 = input_Time[6:4];
	assign digit2 = input_Time[10:7];
	assign digit3 = input_Time[12:11];
	assign am_Pm_Bit = input_Time[13];
	//Divider 
	divider #(.BIT_SIZE (17) ) u3(.clk(clk), .rst(rst) , .inp_count(17'd99999), .ena(1'b1), .tc(m_sec), .count() );
	//Display Driver FSM
	display_Driver_Fsm u2 (.*);
	//Display Driver DP
  	display_Driver_DP u1 (.display_On(display_on),.am_Or_Pm(am_Pm_Bit), .svn_Seg_Dot(dot), .*);
endmodule