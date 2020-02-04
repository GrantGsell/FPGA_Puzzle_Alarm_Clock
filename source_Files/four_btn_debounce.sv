`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2019 05:43:39 PM
//////////////////////////////////////////////////////////////////////////////////
module four_btn_debounce(
    output logic [3:0] led,
    input logic [3:0] btn,
    input logic rst,
    input logic clk
    );
    //Button Zero
    logic btn0_state, btn0_dn, btn0_up;
    debounce d_btn0 (.clk(clk), .i_btn(btn[0]), .o_state(btn0_state), .o_ondn(btn0_dn), .o_onup(btn0_up) );
    
    //Button One
    logic btn1_state, btn1_dn, btn1_up;
    debounce d_btn1 (.clk(clk), .i_btn(btn[1]), .o_state(btn1_state), .o_ondn(btn1_dn), .o_onup(btn1_up) );
    
    //Button Two
    logic btn2_state, btn2_dn, btn2_up;
    debounce d_btn2 (.clk(clk), .i_btn(btn[2]), .o_state(btn2_state), .o_ondn(btn2_dn), .o_onup(btn2_up) );
    
    //Button Three
    logic btn3_state, btn3_dn, btn3_up;
    debounce d_btn3 (.clk(clk), .i_btn(btn[3]), .o_state(btn3_state), .o_ondn(btn3_dn), .o_onup(btn3_up) );
    
    logic [3:0] nxtLed;
    always @(posedge clk) begin
        if(btn0_dn) led = 4'd1;
        else if(btn1_dn) led = 4'd2;
        else if(btn2_dn) led = 4'd4;
        else if(btn3_dn) led = 4'd8;
        if(rst==1'b1) led = 4'b0;
    end
endmodule