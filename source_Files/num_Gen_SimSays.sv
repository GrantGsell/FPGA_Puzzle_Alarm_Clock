`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Grant Gsell 
// 
// Create Date: 08/22/2019 04:16:23 PM
// Module Name: num_Gen_SimSays
// Project Name: FPGA_Puzzle_Alarm_Clock
//////////////////////////////////////////////////////////////////////////////////
module num_Gen_SimSays(
    output logic [3:0] simSaysPattern,
    input logic clk,
    input logic rst
    );
    //Internal Wire Instantiation
    logic [3:0] pattern_Nxt;
    
    //Synchronous Logic    
    always @(posedge clk) begin
        simSaysPattern <= pattern_Nxt;
    end
    
    //Combinational Logic
    always @* begin
        //Main 
        pattern_Nxt = simSaysPattern << 1;
        if(pattern_Nxt == 4'b0) pattern_Nxt = 4'd1;    
    
        //Priority Logic
        if(rst ==1'b1) pattern_Nxt = 4'd1;
    end
endmodule
