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
    input [3:0] hex,
    input [3:0] hex1,
    input [3:0] hex2,
    input [3:0] hex3,
    input enableD1,
    input enableD2,
    input enableD3,
    input enableD4,
    output reg [6:0] segment
    );

    always @ (*)
    if(enableD1 == 0) begin
    
         case (hex)
           0: segment = 7'b0000001;
           1: segment = 7'b1001111;
           2: segment = 7'b0010010;
           3: segment = 7'b0000110;
           4: segment = 7'b1001100;
           5: segment = 7'b0100100;
           6: segment = 7'b0100000;
           7: segment = 7'b0001101;
           8: segment = 7'b0000000;
           9: segment = 7'b0000100;
           10: segment = 7'b0001000;
           11: segment = 7'b1100000;
           12: segment = 7'b0110001;
           13: segment = 7'b1000010;
           14: segment = 7'b0110000;
           15: segment = 7'b0111000;
         default: segment = 7'b0000001;
         endcase
        
    end else if(enableD2 == 0) begin
    
            case (hex1)
      0: segment = 7'b0000001;
          1: segment = 7'b1001111;
          2: segment = 7'b0010010;
          3: segment = 7'b0000110;
          4: segment = 7'b1001100;
          5: segment = 7'b0100100;
          6: segment = 7'b0100000;
          7: segment = 7'b0001101;
          8: segment = 7'b0000000;
          9: segment = 7'b0000100;
          10: segment = 7'b0001000;
          11: segment = 7'b1100000;
          12: segment = 7'b0110001;
          13: segment = 7'b1000010;
          14: segment = 7'b0110000;
          15: segment = 7'b0111000;
    default: segment = 7'b1111111;
    endcase
    end else if(enableD3 == 0) begin
    case (hex2)
      0: segment = 7'b0000001;
      1: segment = 7'b1001111;
      2: segment = 7'b0010010;
      3: segment = 7'b0000110;
      4: segment = 7'b1001100;
      5: segment = 7'b0100100;
      6: segment = 7'b0100000;
      7: segment = 7'b0001101;
      8: segment = 7'b0000000;
      9: segment = 7'b0000100;
      10: segment = 7'b0001000;
      11: segment = 7'b1100000;
      12: segment = 7'b0110001;
      13: segment = 7'b1000010;
      14: segment = 7'b0110000;
      15: segment = 7'b0111000;
    default: segment = 7'b1111111;
    endcase
          
    end else if(enableD4 == 0) begin
     case (hex3)
      0: segment = 7'b0000001;
      1: segment = 7'b1001111;
      2: segment = 7'b0010010;
      3: segment = 7'b0000110;
      4: segment = 7'b1001100;
      5: segment = 7'b0100100;
      6: segment = 7'b0100000;
      7: segment = 7'b0001101;
      8: segment = 7'b0000000;
      9: segment = 7'b0000100;
      10: segment = 7'b0001000;
      11: segment = 7'b1100000;
      12: segment = 7'b0110001;
      13: segment = 7'b1000010;
      14: segment = 7'b0110000;
      15: segment = 7'b0111000;
    default: segment = 7'b1111111;
    endcase
    end
endmodule
