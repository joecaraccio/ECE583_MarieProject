`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2017 07:21:41 PM
// Design Name: 
// Module Name: enable
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


module enable(
    input CLK,
    output enable_D1,
    output enable_D2,
    output enable_D3,
    output enable_D4
    );
    
    reg [3:0] pattern = 4'b0111;
    
    assign enable_D1 = pattern[3];
    
    assign enable_D2 = pattern[2];
    assign enable_D3 = pattern[1];
    assign enable_D4 = pattern[0];
       
    //Shift each Vector
    always @(posedge CLK) begin
        pattern <= {pattern[0],pattern[3:1]};
    end
       
endmodule
