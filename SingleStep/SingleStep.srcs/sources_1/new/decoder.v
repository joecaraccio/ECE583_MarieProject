`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2017 04:49:58 PM
// Design Name: 
// Module Name: decoder
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

module decoder(
    input clk,
    input [2:0] inputer,
    output reg [7:0] outer
    );
    
    always @(posedge clk) begin
        case(inputer)
            3'b000: outer = 8'b00000001;
            3'b010: outer = 8'b00000010;
            3'b001: outer = 8'b00000100;
            3'b011: outer = 8'b00001000;
            3'b100: outer = 8'b00010000;
            3'b101: outer = 8'b00100000;
            3'b110: outer = 8'b01000000;
            3'b111: outer = 8'b10000000;
        endcase
     end
endmodule

