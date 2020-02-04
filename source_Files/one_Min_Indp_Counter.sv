`timescale 1ns / 1ps
//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module one_Min_Indp_Counter(
    output logic sixty_sec_TC,
    input logic clk, 
    input logic clk_ena, 
    input logic rst
    );
  
  //Variable Declaration
  logic one_sec_TC;
  
  //Counter/Divider Module Instantiation
  //Generates a 1/2 second timer
  parameterized_Counter #(.BIT_SIZE(26)) u_1_sec(.tc(one_sec_TC), .dataX(), .clk(clk), .ena(clk_ena), .max_Count(26'd50000000), .init_Count(26'b0), .sw(), .rst(rst)  );
  
  //Generates a 60 second timer that increments the minute timer by one at tc
  parameterized_Counter #(.BIT_SIZE(7)) u_1_min(.tc(sixty_sec_TC), .dataX(), .clk(clk), .ena(one_sec_TC), .max_Count(7'd120), .init_Count(7'd0), .sw(), .rst(rst)  );

endmodule