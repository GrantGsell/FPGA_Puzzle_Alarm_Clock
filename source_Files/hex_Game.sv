//Module Name	: hex_Game
//Purpose		: Module that determines if the external seven segment display is ON or OFF, determines if the puzzle is solved and selects which hexidecimal number to display
//I/O			:
//					Output:
//                          ext_Disp_On: One bit signal turning the external seven segment display ON or OFF
//                          hex_Num_Sel: Four bit signal determining which hexadecimal number is chosen
//                          puzzle_Solved: One bit signal indicating if the user has solved the hexidecimal puzzle
//					Input :
//                          user_Inp: Four bit signal representing the users guess based on built-in switches to the hexadecimal puzzle
//                          game_Ena: One bit signal indicating if the alarm sound is HIGH or LOW
//                          clk: One bit signal generted from the Basys3 internal 100 MHz clock
//                          rst: One bit reset signal
//                          ena_60_Sec: One bit signal ensuring the puzzle is not active for 60 seconds once it has been solved
`timescale 1ns / 1ps
module hex_Game(
    output logic ext_Disp_On,
    output logic [3:0] hex_Num_Sel,
    output logic puzzle_Solved,
    //input logic [3:0] hex_Num_Inp,
    input logic [3:0] user_Inp,
    input logic game_Ena,
    input logic clk,
    input logic rst,
    input logic ena_60_Sec
    );
    //Internal Wire Instantiations
    logic puzzle_Nxt, disp_Nxt;
    logic [3:0] hex_Nxt;
    
    //Synchronous Logic
    always @(posedge clk) begin
        puzzle_Solved = puzzle_Nxt;
        ext_Disp_On <= disp_Nxt;
        hex_Num_Sel <= hex_Nxt;
    end
    
    //Combinational Logic
    always @* begin
        //Hold Statements
        puzzle_Nxt = puzzle_Solved;
        disp_Nxt = ext_Disp_On;
        hex_Nxt = hex_Num_Sel;
        //Main
        if(game_Ena == 1'b0) begin
            hex_Nxt = hex_Num_Sel - 4'd1;
    		if (hex_Nxt == 4'd0) hex_Nxt = 4'd15;
        end
        if(game_Ena == 1'b1) begin
            disp_Nxt = 1'b1;
            if(user_Inp == hex_Num_Sel) begin
                puzzle_Nxt = 1'b1;
                disp_Nxt = 1'b0;
            end
        end
        else if({ena_60_Sec, puzzle_Solved} == 2'b11) puzzle_Nxt = 1'b0;
        //Priority
        if(rst == 1'b1) begin
            disp_Nxt = 1'b0;
            puzzle_Nxt = 1'b0;
        end 
    end
endmodule
