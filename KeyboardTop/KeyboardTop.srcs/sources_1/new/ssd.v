`timescale 1ns / 1ps
// Copright (c) Joe Caraccio
//
// Project : 7 Segement Display
// Module : ssd.v
//
// Description :
// Used with a clock genrator, this outputs a value to each seven segment display
// Uses hardcoded case statements to set the output seven segment values
// to the approariate value based upon what seven segment display is enabled
// input parameters hex through hex3 servered as 4 groups of switches each
// 

module ssd(
    input [7:0] hex,
    input [7:0] hex2,
    input enableD1,
    input enableD2,
    input enableD3,
    input enableD4,
    output reg [6:0] segment
    );

    always @ (*)
    if(enableD1 == 0) begin
        //segment = hex[6:0];
        //A B C D E F G h
         case (hex)
           69: segment = 7'b0000001;
           22: segment = 7'b1001111;
           30: segment = 7'b0010010;
           38: segment = 7'b0000110;
           37: segment = 7'b1001100;
           46: segment = 7'b0100100;
           54: segment = 7'b0100000;
           61: segment = 7'b0001101;
           62: segment = 7'b0000000;
           70: segment = 7'b0000100;
           28: segment = 7'b0001000;
           50: segment = 7'b1100000;
           33: segment = 7'b0110001;
           35: segment = 7'b1000010;
           36: segment = 7'b0110000;
           43: segment = 7'b0111000;

         default: segment = 7'b0111000;
         endcase
        
    end else if( enableD2 == 0) begin
                  segment = 7'b1111111;


    end else if( enableD3 == 0) begin
      segment = 7'b1111111;
    end else if( enableD4 == 0) begin
    segment = 7'b1111111;
    end
endmodule