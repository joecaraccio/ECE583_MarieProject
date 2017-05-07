`timescale 1ns / 1ps
//Joe Caraccio, Noah Fitter, Ben Miller
//Test Module for keyboard
module Top(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    output        tx,
    output [15:0] led,
     output [6:0] segment,
     output enable_D1,
     output enable_D2,
     output enable_D3,
     output enable_D4


);
    reg  [15:0] keycodev=0;
    wire        tready;
    wire        ready;
    wire        tstart;
    reg         start=0;
    reg         CLK50MHZ=0;
    wire [31:0] tbuf;
    //reg  [15:0] keycodev=0;
    wire [15:0] keycode;
    wire [ 7:0] tbus;
    reg  [ 2:0] bcount=0;
    wire        flag;
    reg         cn=0;
    reg [15:0] led2 = 0;
  // wire [7:0] actualSeg;
   wire [7:0] actualSeg2;
   reg clk2 = 0;
    
    
    
    reg state;
    reg [32:0] counter;
    assign led[10] = state;

    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
        
    end
    /*   wire [7:0] actualSeg;

    always @(clk) begin
        //Creates something that is basically the clock
        
        clk2 <= ~clk2;
    end
    
    always @ (posedge clk2) begin
           counter <= counter + 1;
             state <= counter[25];
        end
    */
    //Signle Stepper module
    
    wire [7:0] actualSeg;
    keyboardReceiver uut (
        CLK50MHZ,
        PS2Clk,
        PS2Data,
        actualSeg
    );
    //ILA
     
    //
    assign led = actualSeg;
  
      wire clk_point1hz; //counter clock
        wire refreshClk; ////refresh the display
        /*
       ila_0 ilago(
        clk,
        actualSeg
       );
       */
       //turn on all 4 seven segment displays
       Enabler en1(refreshClk,
       enable_D1,
       enable_D2,
       enable_D3,
       enable_D4
       );
       
    ssd sssu(
    actualSeg,
    actualSeg2,
    enable_D1,
    enable_D2,
    enable_D3,
    enable_D4,
    segment
 );
 
   
    
   
    
endmodule