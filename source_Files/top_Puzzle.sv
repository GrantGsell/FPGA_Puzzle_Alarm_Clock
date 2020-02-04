//Module Name	: top_Puzzle
//Purpose		: Overarching module that operates the external seven segment display in conjunction with the hexadecimal switch puzzle
//I/O			: 
//					Output: 
//                          JB: Eight bit signal controlling the signals being sent to the seven segment display
//                          puzzle_Solve_Out: One bit signal which is returned to the alm_Sound module to control the alm_Sound output signal
//					Input :
//                          alm_Sound: One bit signal which indicates if whether or not the alarm signal is high or low
//                          sw: Four bit signal indicating the user input switch answer to the hexadecimal puzzle
//                          rst: One bit signal to reset the inner 'hex_Game' modules
//                          clk: One bit signal representing the Basys3 internal clock
//                          btn: {btnL,btnD,btnR,btnU} == {[3:0]}
`timescale 1ns / 1ps
 module top_Puzzle(
    output logic [7:0] JB,
    output logic [3:0] ledTestOut,
    output logic puzzle_Solve_Out,
    input logic alm_Sound,
    input logic [3:0] sw,
    input logic [3:0] btn,
    input logic rst,
    input logic clk,
    input logic ena_60_Sec
    );
    //Internal Wire Instantiations
    logic ext_Disp_Ena, puzzle_Solve_Internal, simSays_Ena, hex_Ena;         //Internal connecting wire turning the external seven segment display ON or OFF
    logic [3:0] hex_Num;                                            //Internal connecting wire dictating what hex number to display
    logic internalOutputDelay;
     assign hex_Ena = alm_Sound & ~puzzle_Solve_Internal;
    //Hex_Game Module Instantiation
    hex_Game u1(.ext_Disp_On(ext_Disp_Ena), .puzzle_Solved(puzzle_Solve_Internal), .hex_Num_Sel(hex_Num),
        .game_Ena(hex_Ena), .user_Inp(sw[3:0]), .rst(rst), .clk(clk), .ena_60_Sec(ena_60_Sec) );
     
    //Ext_7_Seg_Disp Module Instantiation
    ext_Svn_Seg_Disp u2( .seg_Out(JB[7:0]), .display_On(ext_Disp_Ena), .bcd_In(hex_Num));
    
    //Simon Says Enable Bit
    assign simSays_Ena = alm_Sound & puzzle_Solve_Internal;

    //Simon Says Module Instantiation
    top_Simon_Says u3(.simSaysLedPat(ledTestOut), .puzzle_Solved(puzzle_Solve_Out), .user_Inp(btn), .game_Ena(simSays_Ena), .clk(clk), .rst(rst));
    
endmodule
