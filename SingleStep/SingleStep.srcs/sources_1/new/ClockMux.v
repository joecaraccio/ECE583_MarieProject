`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2017 04:37:44 PM
// Design Name: 
// Module Name: ClockMux
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


module ClockMux(
    input NormalClock,
    input OtherClock,
    input control,
    output reg outputClock
    );
    
   always @(*)
   begin
   
    if(control == 1) begin
       outputClock <= NormalClock;
    end else if(control == 0) begin
       outputClock <= OtherClock;
    end
                
    end
endmodule



