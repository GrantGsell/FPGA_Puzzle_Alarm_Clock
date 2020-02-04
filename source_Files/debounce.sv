`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2019 05:43:39 PM
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce(
    input logic clk,
    input logic i_btn,
    output logic o_state,
    output logic o_ondn,
    output logic o_onup
    );

    // sync with clock and combat metastability
    logic sync_0, sync_1;
    always @(posedge clk) sync_0 <= i_btn;
    always @(posedge clk) sync_1 <= sync_0;

    // 2.6 ms counter at 100 MHz
    //Changed 18:0 to 30:0
    logic [18:0] counter;
    logic idle = (o_state == sync_1);
    logic max = &counter;

    always @(posedge clk)
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            if (max)
                o_state <= ~o_state;
        end
    end

    assign o_ondn = ~idle & max & ~o_state;
    assign o_onup = ~idle & max & o_state;
endmodule
