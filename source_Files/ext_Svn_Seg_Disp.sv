//Module Name	: ext_Svn_Seg_Disp
//Purpose		:
//I/O			:
//					Output:
//                          seg_Out: Eight bit signal with each bit corresponding to a different segment or dot of the external seven segment display
//					Input :
//                          bcd_In: Four bit signal used to decode the hexadeciaml number choice into an eight bit represenation for the seven segment display
//                          display_On: One bit signal turning the external display ON or OFF
`timescale 1ns / 1ps
module ext_Svn_Seg_Disp(
	output logic [7:0] seg_Out,
	input logic [3:0] bcd_In,
	input logic display_On
	);

	always_comb begin
	   //Default
	   //Main
		if(display_On == 1) begin 
			case(bcd_In)
				4'b0000 : seg_Out = 8'b00000000; //0
				4'b0001 : seg_Out = 8'b00000110; //1
				4'b0010 : seg_Out = 8'b01011011; //2
				4'b0011 : seg_Out = 8'b01001111; //3
				4'b0100 : seg_Out = 8'b01100110; //4
				4'b0101 : seg_Out = 8'b01101101; //5
				4'b0110 : seg_Out = 8'b01111101; //6
				4'b0111 : seg_Out = 8'b00000111; //7
				4'b1000 : seg_Out = 8'b01111111; //8
				4'b1001 : seg_Out = 8'b01101111; //9
				4'b1010 : seg_Out = 8'b01110111; //A
				4'b1011 : seg_Out = 8'b01111100; //B
				4'b1100 : seg_Out = 8'b00111001; //C
				4'b1101 : seg_Out = 8'b01011110; //D
				4'b1110 : seg_Out = 8'b01111001; //E
				4'b1111 : seg_Out = 8'b01110001; //F
				default : seg_Out = 8'b00000000; // Default
			endcase //End case
		end //End if statement
		else begin // If the display is off do the following
			 seg_Out = 8'b00000000; //Default for when the display is off
		end //End if statement
	end //End always
endmodule

