//Module Name	: time_Mux_2x4
//Purpose		: Multiplexor Module that selects which time data to display, either the clock time or the alarm time
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
`timescale 1ns / 1ps
module time_Mux_2x4(
    output logic [13:0] chosen_Time,
    input logic [13:0] clock_Time,
    input logic [13:0] alarm_Time,
    input logic sel
    );
	always @* begin
      if(sel == 1'b0) chosen_Time = clock_Time;
      else chosen_Time = alarm_Time;
    end
endmodule