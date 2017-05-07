`timescale 1ns / 1ps
//Ben Miller, Noah Fitter, Joe Caraccio

//Description:
//Outputs a clock signal that utilizes the keyboard press
//F1 = Enable Single Step
//F2 = Disable Single Step
//F3 = Single Step
//outputs a Clock
module SingleStepper(
    input SystemClock,
    input [7:0] keyboardValue,
    output reg clockSignal
    );
    //local variables
    reg stepperClock = 0;
    reg controlBit = 1;
    wire actualClock;
    
    reg trackingBit = 0;
    reg debounceBit = 0;
    
     always @(posedge trackingBit) begin
        if(debounceBit == 1) begin            
         stepperClock<=~stepperClock;
         stepperClock<=~stepperClock;
        end else begin
         debounceBit <= 1;
        end
     end
     
    //listen for key pres
    //Right now keyboard values
    //F1 = Enable Single Step
    //F2 = Disable Single Step
    //F3 = Single Step
    always @(keyboardValue) begin
    if(keyboardValue == 5) begin
          controlBit <= 0;
        end else if( keyboardValue == 6) begin
           controlBit <= 1;
        end else if( keyboardValue == 4 && controlBit == 0 ) begin
            trackingBit = 1;
        end else begin
            trackingBit = 0;
        end
    end
    
    //Selects among two clock symbols
    //SystemClock
    ClockMux cmu(
        SystemClock,
        stepperClock,
        controlBit,
        actualClock       
    );
      
      
     //output of Clock Signal should constantly be attached to clock
     always @(*) begin
        clockSignal <= actualClock;
     end
    
    
    
endmodule
