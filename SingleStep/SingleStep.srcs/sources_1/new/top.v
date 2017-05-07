`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2017 09:35:23 AM
// Design Name: 
// Module Name: top
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


module top(
    input PS2Data,
    input PS2Clk,
    input [15:0] sw,
    input pushButton,
    input clk_out1,
    output enable_D1,
    output enable_D2,
    output enable_D3,
    output enable_D4,
    output [6:0] segment,
    output [7:0] dec1,
    output [15:8] dec2
    );
    reg clk2 = 0;
    reg state;
    reg mode = 0;
    reg         CLK50MHZ=0;
    wire [7:0] actualSeg;
    //assign led = actualSeg;
    
    
     reg controlBit = 1;
       wire actualClock;
       reg stepperClock = 0;
        
    
    always @(posedge(clk_out1))begin
         CLK50MHZ<=~CLK50MHZ;
    end
    
    always @(clk_out1)begin
        clk2<=~clk2;
       
    end
    
    //User Controlled clock
    
   
    /*
    reg [7:0] indicator = 8'b11111111;
    assign dec2 = stepperClock;
    
   
   
   reg trackingBit = 0;
   reg debounceBit = 0;                
    always @(posedge trackingBit) begin
       if(debounceBit == 1) begin            
        stepperClock<=~stepperClock;
       end else begin
        debounceBit <= 1;
       end
    end

    //listen for key pres
    //A = 28 enable multistep
    //S = 27 disable multistep
    always @(actualSeg) begin
        if(actualSeg == 5) begin
           controlBit <= 0;
        end else if( actualSeg == 6) begin
           controlBit <= 1;
           //indicator= 8'b00001111;
        end else if( actualSeg == 4 && controlBit == 0 ) begin
            trackingBit = 1;
        end else begin
            trackingBit = 0;
        end
    end
   
    
   
    ClockMux cmu(
        clk_out1,
        stepperClock,
        controlBit,
        actualClock       
    );
    */
        
         PS2Receiver2 uut (
               .clk(CLK50MHZ),
               .kclk(PS2Clk),
               .kdata(PS2Data),
               .segInfo(actualSeg)
           );
    
       
          SingleStepper sing1(
                clk_out1,
                actualSeg,
                actualClock
                );
          
          decoder d1(actualClock, sw[2:0], dec1);
                  
               
   
endmodule
