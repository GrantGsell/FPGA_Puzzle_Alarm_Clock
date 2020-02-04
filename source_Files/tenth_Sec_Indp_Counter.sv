`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Grant Gsell
// 
// Create Date: 12/21/2019 04:47:07 PM
// Module Name: tenth_Sec_Indp_Counter
// Project Name: FPGA_Puzzle_Alarm_Clock
//////////////////////////////////////////////////////////////////////////////////
module tenth_Sec_Indp_Counter(
    output logic tenth_sec_TC,
    input logic clk, 
    input logic clk_ena, 
    input logic rst
    );
    //Generates a tenth second timer
  parameterized_Counter #(.BIT_SIZE(24)) u0_tenth_sec(.tc(tenth_sec_TC), .dataX(), .clk(clk), .ena(clk_ena), .max_Count(24'd10000000), .init_Count(26'b0), .sw(), .rst(rst)  );
    
    
endmodule
