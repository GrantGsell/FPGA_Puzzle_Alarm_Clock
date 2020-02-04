`timescale 1ns / 1ps
//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module clock(
  input logic [15:0] sw,
  output logic [13:0] time_Data_Out, 
  input logic clk, clk_ena, rst
  );
  
  //Variable Declaration
  logic dig_0_TC, dig_1_TC, dig_2_TC, dig_3_TC, sixty_sec_TC, one_sec_TC;
  logic [3:0] data_Digit_0;
  logic [2:0] data_Digit_1; 
  logic [3:0] data_Digit_2;
  logic [1:0] data_Digit_3;
  logic am_Pm;
  
  //Counter/Divider Module Instantiation
  //Generates a 1/2 second timer
  parameterized_Counter #(.BIT_SIZE(26)) u_1_sec(.tc(one_sec_TC), .dataX(), .clk(clk), .ena(clk_ena), .max_Count(26'd50000000), .init_Count(26'b0), .sw(), .rst(rst)  );
  
  //Generates a 60 second timer that increments the minute timer by one at tc
  parameterized_Counter #(.BIT_SIZE(7)) u_1_min(.tc(sixty_sec_TC), .dataX(), .clk(clk), .ena(one_sec_TC), .max_Count(7'd120), .init_Count(7'd0), .sw(), .rst(rst)  );

  //Generates a counter for digit 1
  parameterized_Counter #(.BIT_SIZE(4)) u0_digit_0(.tc(dig_0_TC), .dataX(data_Digit_0), .clk(clk), .ena(sixty_sec_TC), .max_Count(4'd9), .init_Count(sw[3:0]), .sw(sw[15:14]), .rst(rst) );
  
  //Generates a counter for digit 2
  parameterized_Counter #(.BIT_SIZE(3)) u1_digit_1(.tc(dig_1_TC), .dataX(data_Digit_1), .clk(clk), .ena(dig_0_TC), .max_Count(3'd5), .init_Count(sw[6:4]), .sw(sw[15:14]), .rst(rst) );
  
  //Generates a counter for digit 3
  parameterized_Counter #(.BIT_SIZE(4)) u2_digit_2(.tc(dig_2_TC), .dataX(data_Digit_2), .clk(clk), .ena(dig_1_TC), .max_Count(4'd9), .init_Count(sw[10:7]), .sw(sw[15:14]), .rst(rst) );
  
  //Generates a counter for digit 4
  parameterized_Counter #(.BIT_SIZE(2)) u3_digit_3(.tc(dig_3_TC), .dataX(data_Digit_3), .clk(clk), .ena(dig_2_TC), .max_Count(2'd2), .init_Count(sw[12:11]), .sw(sw[15:14]), .rst(rst) );
  
  //Am_Pm_Bit
  always @* begin
  	if( {data_Digit_3,data_Digit_2}>=12 ) am_Pm = 1'b1;
  	else am_Pm = 1'b0;
  end
  //Output for Current Time
  assign time_Data_Out = {am_Pm, data_Digit_3, data_Digit_2, data_Digit_1, data_Digit_0};
endmodule