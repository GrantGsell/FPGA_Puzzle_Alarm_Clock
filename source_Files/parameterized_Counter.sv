`timescale 1ns / 1ps
//Module Name	:	Parameterized Counter Divider
//Purpose		:	Creates a counter/timer by dividing the internal clock by the  input count	
//I/O			:	
//					Output: 
//						Terminal Count (TC) used to indicate the desired count was reached
//						dataX used to send to the time data to the display module
//					Input:
//						clk denotes 100 MHz Basys3 clock
//						ena denotes enable, if high the counter increments if low it holds the count
//						inp_count denotes the number to count up to(count) or the dividend(divider)
//Useage		:
//					A.Slows down the 100 MHz clock to 100 Hz clock (19 bit BIT_SIZE)
//					B.Increment the Minutes Counter once every 60 seconds
//					C.Increment the Hours Counter once every 60 minutes
module parameterized_Counter #(parameter BIT_SIZE=19) (
    output logic tc, 
    output logic [BIT_SIZE-1:0] dataX, 
    input clk, 
    input ena, 
    input logic [BIT_SIZE-1:0] init_Count, 
    input logic [BIT_SIZE-1:0] max_Count, 
    input logic [15:14] sw, 
    input logic rst
    );
  //Variable Declaration
  logic [BIT_SIZE-1:0] count, next_count;
  //Synchronous Logic
  always @(posedge clk)begin
  	count <= next_count;
  end
  //Combinational Logic
  always @* begin						//Block is executed if any of the variables change
  	//Defaults
    tc =0;								//Terminal Count is defaulted to zero
    next_count = count;					//Hold case if counter not enabled
  	//Main
    if(ena==1) begin					//If Enable is high the counter increments
      next_count = count+1;				//Count is incremented by one 
      if(count > max_Count) begin		//Counter has reached the same value as init_count
        tc = 1'b1;						//Output High indicating the input value was reached
        next_count = 0;					//Resets the counter
      end								
    end									
    //Priority
    if(rst==1) begin next_count = 0; end			//If reset is high, the counter is reset to zero
    if(sw[15:14] == 2'b01) begin
        next_count = init_Count; 
        if(init_Count > max_Count) begin next_count = max_Count; end 
    end
    dataX = count;						//Outputs the current time
  end									//End Combinational Logic Block
endmodule								//End Module