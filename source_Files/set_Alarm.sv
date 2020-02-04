`timescale 1ns / 1ps
//Module Name	: set_Alarm
//Purpose		: Using synchronous SRAM and D Flip Flops it stores one 15 bit word baed on switch settings which is the user set alarm time
//I/O			:
//					Output:
//						read_Data outputs the 15 bit number representing the set alarm time
//					Input :
//						sw (switches) allow the user to set the alarm using the onboard switches
//						clk is the standard 100 MHz Basys3 Clock			
module set_Alarm (
    output logic [13:0] read_data,
    input logic [15:0] sw,
    input logic clk 
    );
    
  logic [13:0] regDat;
  always @(posedge clk) begin    //Note always_ff doesnt work in this IDE
    if(sw[15:14] == 2'b11) regDat <= sw[13:0];
  end
  assign read_data = regDat;
endmodule