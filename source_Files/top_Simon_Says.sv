`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Grant Gsell 
// 
// Create Date: 08/22/2019 04:10:57 PM
// Module Name: top_Simon_Says
// Project Name: FPGA_Puzzle_Alarm_Clock
//////////////////////////////////////////////////////////////////////////////////
module top_Simon_Says(
    output logic [3:0] simSaysLedPat,
    output logic puzzle_Solved,
    input logic [3:0] user_Inp,
    input logic game_Ena,
    input logic clk,
    input logic rst
    );
    //Internal Wire Instantiations
    logic [2:0] patternIndex;
    logic [3:0]nextPatternItr;
    logic tenthSec;
    logic [3:0] btnPress;
    //Internal Register Instantiations
    logic [3:0] pattern_Reg [0:3];
    logic [3:0] pattern_User [0:3];
      
    //Pattern Generation Module
    num_Gen_SimSays u0(.simSaysPattern(nextPatternItr) ,.clk(clk), .rst(rst));
    //Tenth Second Generation Module
    tenth_Sec_Indp_Counter u1(.tenth_sec_TC(tenthSec), .clk(clk), .clk_ena(1'b1), .rst(rst) );

    
    /////////////////////////////////////
    logic [3:0] ledPat;
    logic rstDbnc;
    four_btn_debounce fourBtn(.led(ledPat), .btn(user_Inp) ,.clk(clk), .rst(rstDbnc));
    ///////////////////////////////////
    logic [34:0] clockCounter, debounceCounter;
    enum logic [2:0] {S1,S2,S3} state, nextState;
    logic [3:0] btn0;
    logic [2:0] userInpIndex,nxtUserInpIndex,vectNum;
    logic dispPattern;
    logic vectRst;  
    
    //Synchronous Block
    always @(posedge clk) begin
        if(rst==1'b1) begin
            clockCounter = 35'b0; 
            vectNum = 3'b000;
            debounceCounter =35'b0;
        end
        if(!dispPattern) begin
            if(vectRst == 1'd1) vectNum = 3'd0;
            if(clockCounter < 35'd200000000)begin
                clockCounter = clockCounter +1'b1;
            end
            else begin
                clockCounter <= 35'd0;
                vectNum = vectNum + 1'b1;
            end
        end
        else begin
            state <= nextState;
            if(debounceCounter < 28'd200000000) debounceCounter = debounceCounter + 1'd1;
            else debounceCounter = 28'b0;
        end
    end
    
    //Combination Block
    always @* begin       
        //Main
        if(game_Ena==1'b0) begin //&& tenthSec) begin
            //pattern_Reg[patternIndex] = nextPatternItr;
            patternIndex = patternIndex + 1'b1;
            if(patternIndex>3'd4) patternIndex = 3'd0;
        end
        else if(game_Ena==1'b1) begin
            if(!dispPattern) begin
                vectRst = 1'b0;
                //Display Pattern for User
                if(clockCounter < 28'd100000000 && vectNum==3'd1) simSaysLedPat = pattern_Reg[0];
                else if(clockCounter < 28'd100000000 && vectNum==3'd2) simSaysLedPat = pattern_Reg[1];
                else if(clockCounter < 28'd100000000 && vectNum==3'd3) simSaysLedPat = pattern_Reg[2];
                else if(clockCounter < 28'd100000000 && vectNum==3'd4) simSaysLedPat = pattern_Reg[3]; 
                else if(clockCounter < 28'd100000000 && vectNum>=3'd5) begin
                    dispPattern = 1'b1;
                end
                else simSaysLedPat = 4'b0000;
            end
            ////////////////////////////////////////////////////////////////////////////////////////
            else if((dispPattern==1'b1)&& (userInpIndex <= 3'b011))begin
                //Hold Condition
                nextState = state;
                //Main 
                case(state) 
                    S1: begin
                        rstDbnc = 1'b0;
                        simSaysLedPat = {1'b0,userInpIndex};
                        if(user_Inp!=0) begin
                            btn0 = ledPat;
                            nextState = S2;
                        end
                        else nextState = S1;
                    end
                    S2: begin
                        rstDbnc = 1'b0;
                        if(btn0==4'h1||btn0==4'h2||btn0==4'h4||btn0==4'h8) begin
                            if(debounceCounter == 35'd0) begin
                                pattern_User[userInpIndex] = btn0;
                                nextState = S3;  
                            end
                            else nextState = S2; 
                        end
                        else nextState = S1;
                    end
                    S3: begin
                        if(debounceCounter == 35'd0) userInpIndex = userInpIndex + 3'b001;
                        btn0 = 4'd0;
                        nextState = S1;
                        rstDbnc = 1'b1;
                    end
                endcase
                //Priority Conditions
                if (rst == 1) nextState = S1;
            end
            else if((dispPattern==1'b1)&& (userInpIndex > 3'd3))begin
                simSaysLedPat = 4'b1010;
                if(pattern_User[0]==pattern_Reg[0] && pattern_User[1]==pattern_Reg[1] && pattern_User[2]==pattern_Reg[2] && pattern_User[3]==pattern_Reg[3]) begin
                    puzzle_Solved = 1'b1;
                end
                else begin
                    vectRst = 1'b1;
                    dispPattern = 1'b0;
                    simSaysLedPat = 4'b1111;
                    //userInpIndex = 3'b000;
                end
            end
        end
        //Reset
        if(rst==1'b1) begin
            vectRst = 1'b0;
            puzzle_Solved = 1'b0;
            patternIndex = 3'd0;
            userInpIndex = 3'd0;
            pattern_Reg[0] = 4'd1;
            pattern_Reg[1] = 4'd2;
            pattern_Reg[2] = 4'd4;
            pattern_Reg[3] = 4'd8;
            pattern_User[0] = 4'd0;
            pattern_User[1] = 4'd0;
            pattern_User[2] = 4'd0;
            pattern_User[3] = 4'd0;
            dispPattern = 1'b0;
            simSaysLedPat = 4'd0;
        end
    end
endmodule