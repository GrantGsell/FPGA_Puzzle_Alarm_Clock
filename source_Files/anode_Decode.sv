`timescale 1ns / 1ps
//Module Name	: 	anode_Decode
//Purpose		: 	Takes in a two bit value and outputs four bits inidicating which 7-segment display is active
//I/O			:
//					Output:
//						anode_Out indicates which of the four 7-segment display is active
//					Input :
//						anode_Sel is used to choose which digit display is active
//Useage		:	Used to select the proper anodes for the Display Driver module
//Notes			:
module anode_Decode(output logic [3:0] anode_Out,input logic [1:0] anode_Sel);
	always @* begin
      case(anode_Sel)
			2'b00 : anode_Out = 4'b1110; //Display Digit 0
			2'b01 : anode_Out = 4'b1101; //Display Digit 1
			2'b10 : anode_Out = 4'b1011; //Display Digit 2
			2'b11 : anode_Out = 4'b0111; //Display Digit 3
		endcase							 //End case
	end									 //End always
endmodule