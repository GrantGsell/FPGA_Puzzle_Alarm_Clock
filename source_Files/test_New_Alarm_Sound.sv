//Module Name	:
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
`timescale 1ns / 1ps
module test_New_Alarm_Sound(
    output logic alm_Sound_Out,
    input logic [13:0] alm_Dat,
    input logic [13:0] time_Dat,
    input logic puzzle_Solved,
    input logic clk, //One_Min_Tc
    input logic rst
    );
    //Internal Wire Instantiations
    logic alm_Snd_Nxt;
    
    //Synchronous Block
    always @(posedge clk) begin
        alm_Sound_Out <= alm_Snd_Nxt;
    end
    
    //Combinational Block
    always @* begin
        //Hold Statement
        alm_Snd_Nxt = alm_Sound_Out;
        
        //Main Logic
        if(time_Dat == alm_Dat) alm_Snd_Nxt = 1'b1;
        if(puzzle_Solved == 1'b1) alm_Snd_Nxt = 1'b0;
        
        //Priority Logic
        if(rst == 1'b1) alm_Snd_Nxt = 1'b0;
    end
endmodule