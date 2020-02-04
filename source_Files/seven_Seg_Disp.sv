`timescale 1ns / 1ps
//Module Name	: seven_Seg_Disp
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module seven_Seg_Disp(output logic [6:0] seg_Out, input logic disp_On, input logic [3:0] bcd_in);
	always @* begin
      if(disp_On == 1) begin 				// If the display is on do the following
			case(bcd_in)
				4'b0000 : seg_Out = 8'b01000000; //0
				4'b0001 : seg_Out = 8'b01111001; //1
				4'b0010 : seg_Out = 8'b00100100; //2
				4'b0011 : seg_Out = 8'b00110000; //3
				4'b0100 : seg_Out = 8'b00011001; //4
				4'b0101 : seg_Out = 8'b00010010; //5
				4'b0110 : seg_Out = 8'b00000010; //6
				4'b0111 : seg_Out = 8'b01111000; //7
				4'b1000 : seg_Out = 8'b00000000; //8
				4'b1001 : seg_Out = 8'b00010000; //9
				default : seg_Out = 8'b00010000; //Default to 9
			endcase 							//End case statement
		end 									//End if statement
		else begin 								// If the display is off do the following
			 seg_Out = 8'b11111111; 				//Default for when the display is off
		end 									//End if statement
	end 										//End always
endmodule