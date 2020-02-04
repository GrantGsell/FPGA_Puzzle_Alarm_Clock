//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module top_FPGA_Puzzle_Alarm_Clock(
	output logic [4:0] led,
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic [1:0] JA,
	output dp,
	//output [1:0]JC,
	output logic [7:0] JB,
	input logic [0:0] btnC,
	input logic [0:0] btnU,
	input logic [0:0] btnD,
	input logic [0:0] btnL,
	input logic [0:0] btnR,
	input logic [15:0] sw,
	input logic clk
);
  //Interior Wire Instantiaitons
  logic [13:0] time_Dat, alarm_Dat, puzzle_Hex_Nums, mux_Chosen_Time;
  logic alm_Sound_Ret, alm_Sound_to_Puzzle, m_sec_Out, TC_60_To_alm_Clk, Am_Pm_Bit;
  
  //Clock Module Instantiation
  clock u0(
        .time_Data_Out(time_Dat),                                       //Outputs
        .clk(clk), .clk_ena(1'b1), .rst(btnC[0]), .sw(sw)               //Inputs
        );        
  
  //set_Alarm Module Instantiation
  set_Alarm u1(
        .read_data(alarm_Dat),                                          //Outputs
        .sw(sw), .clk(clk)                                              //Inputs 
               );
  
  //time_Mux_2x4 Module Instantiation
  time_Mux_2x4 u4(
        .chosen_Time(mux_Chosen_Time),                                  //Outputs
        .clock_Time(time_Dat), .alarm_Time(alarm_Dat), .sel(sw[15])     //Inputs
        );
  
  //One Minute Standalone Divider Module Instantiaion
  one_Min_Indp_Counter u7(
        .sixty_sec_TC(TC_60_To_alm_Clk),                                //Outputs
        .clk(clk), .clk_ena(1'b1), .rst(btnC[0])                        //Inputs
        );
  
  //test_New_Alm_Sound
  test_New_Alarm_Sound u6(
        .alm_Sound_Out(alm_Sound_to_Puzzle),                            //Outputs
        .alm_Dat(alarm_Dat), .time_Dat(time_Dat),                       //Inputs
        .puzzle_Solved(alm_Sound_Ret), .clk(clk),.rst(btnC[0])          //Inputs
        );   
  
  assign led[0] = alm_Sound_to_Puzzle;  
 
  //Puzzle Instatiation
  top_Puzzle u5(
        .JB(JB[7:0]), .puzzle_Solve_Out(alm_Sound_Ret),                 //Outputs
        .alm_Sound(alm_Sound_to_Puzzle), .sw(sw[3:0]),                  //Inputs
        .rst(btnC[0]), .clk(clk), .ena_60_Sec(TC_60_To_alm_Clk),        //Inputs
        .btn({btnL,btnD,btnR,btnU}), .ledTestOut(led[4:1])              //Inputs
        );    
  
  
  //display_Driver Module Instantiation
  display_Driver u3( 
        .cathode(seg), .anode(an), .anode_sel(JA[1:0]),                 //Outputs
        .m_sec(m_sec_Out),                                              //Outputs
        .input_Time(mux_Chosen_Time), .display_on(1'b1),                //Inputs
        .rst(btnC[0]), .clk(clk), .dot(dp)                              //Inputs
        );
  
endmodule