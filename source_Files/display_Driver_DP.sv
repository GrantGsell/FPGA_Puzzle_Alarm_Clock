`timescale 1ns / 1ps
//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module display_Driver_DP(output logic [6:0] cathode, output logic svn_Seg_Dot, output logic [3:0] anode, input logic [3:0] digit3,
	input logic [3:0] digit2, input logic [3:0] digit1, input logic [3:0] digit0,
    input logic [1:0] digit_sel, input logic display_On, input logic [1:0] anode_sel, input logic am_Or_Pm);
	//Internal Wire Instantiations
  logic [3:0] bcd_in;
	//4x1 Multiplexer
	always @* begin	
	   //Default
	   svn_Seg_Dot = 1'b1;
	   //Main
		case(digit_sel)					//Determines SvnSegDisp Digit 
			2'b00: begin
			  bcd_in = digit0;		    //Furthest Right SvnSegDisp Digit
			  svn_Seg_Dot = ~am_Or_Pm;  //Indicates if the alarm/clock time is set to Am or Pm (INITIALLY SET to Low)
			end
			2'b01: bcd_in = digit1;		//Second from Right SvnSegDisp Digit
			2'b10: bcd_in = digit2;		//Second from  Left SvnSegDisp Digit
			default: bcd_in = digit3;	//Furthest Left SvnSegDisp Digit
		endcase					
		//if(digit0[2] == 1'b1) dp = 1'b1;
		//else dp = 1'b0;	
	end 								//End Always
	//Seven Segment Decoder
    seven_Seg_Disp u1 (.*, .disp_On(display_On), .seg_Out(cathode));
	//Anode Decoder
    anode_Decode u2 (.anode_Sel(anode_sel), .anode_Out(anode), .*);
endmodule