`timescale 1ns / 1ps
//Module Name	: Divider
//Purpose		:
//I/O			:
//					Output:
//					Input :
//Useage		:
//Notes			:
module divider #(parameter BIT_SIZE=4)(
    output logic tc, 
	output logic [BIT_SIZE-1:0] count, 
	input logic clk,
	input logic rst, 
	input logic ena, 
	input logic [BIT_SIZE-1:0] inp_count
	);

	logic [BIT_SIZE-1:0] next_count;
	// synchronous logic
	always @(posedge clk) begin
    	count <= next_count;
	end
	// combinational logic
	always @* begin
    	// defaults
    	tc = 0;
    	next_count = count;	
    	//Main
    	if (ena == 1) begin
       		next_count = count - 1;
    		if (count == 0) begin
        		tc = 1;	
        		next_count = inp_count;
    		end	
    	end	
    	//Priority
    	if (rst == 1) begin
    		next_count = inp_count;
    	end
	end
endmodule