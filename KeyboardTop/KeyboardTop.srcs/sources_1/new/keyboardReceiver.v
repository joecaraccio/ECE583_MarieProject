`timescale 1ns / 1ps
//Joe Caraccio, Noah Fitter, Ben Miller
//Using the PS2 Ports, read the keyboard input
//Previously called PS2 Reciever
//citation:
//Based off of the Public Diligent Source on Github with Modifications
module keyboardReceiver(
    input MASTERCLOCK,
    input kclk,
    input terminalData,
    output reg [7:0] keyboardPressInformation = 0
    );
    //Intialize KeyboardPressInformation to 0
    //Will be 0 until we read in information
    //
    // we need to be able to count up to at least 11
    // so just make sure we have a big enough counter to hold it
    // 2^n ....
    reg [3:0] counterTracker = 0;
    
    //Used int he Debounce module
    //allows for us to modify the clock frquency
    wire dataClockModifiedFrequency;
    wire dataBitRead;
    
    //Intialize current data to 0 
    //will be 0 until we overwrite
    reg [7:0] currentData = 0;

    //As Explained in our documentation, there are extra bits
    reg extraBits = 0;
    reg debounceMode = 0;
    
    
    //two debouncing modules inspired from Diligent forms
    //this are parameter arguments which we learned how to do online
    debouncer bclk(
        MASTERCLOCK,
        kclk,
        dataClockModifiedFrequency
    );
    
    //DB Data
    //Debounce the data
    debouncer  bdata(
        MASTERCLOCK,
        terminalData,
        dataBitRead
    );
    
    
    
//from here are out we use the third parameter of those two
//as they will be a better source without worrying about debug
 
 //extra bit storage
reg flagBitWatcher;
reg seq1 = 0;
reg initialzedGo = 1; 
reg inCase = 0;
//Always Block Watching
//Important to remeber that there are 11 bits
//Bit 0.. when count is 0 will just be the start bit.. we don't need that
//Bits 1 through 8 in our counter 
// last two bits we use for the flag
//
always@(negedge(dataClockModifiedFrequency))begin

    //COUNT
    // following the bit structure we reset once we have complete a cycle
    //Bare in mind that 0 also will count towards the count
    if(counterTracker <= 10) begin
    //remeber we need to keep track of 1 as well
    //so index 0 accounts for it
        counterTracker <= counterTracker + 1;
    end else if( counterTracker == 11 ) begin
    //reaching 10 in the counter tracker means that we have read 11 bits 
        counterTracker <= 0;
    end

    

    //Inspired from the diligent forms
    if(seq1 == 0) begin  
        if(counterTracker == 1) begin
            currentData[0]<=dataBitRead;
        end else if(counterTracker == 2) begin
            currentData[1]<=dataBitRead;
        end else if(counterTracker == 3) begin
            currentData[2]<=dataBitRead;
        end else if(counterTracker == 4) begin
            currentData[3]<=dataBitRead;
        end  else if(counterTracker == 5) begin
            currentData[4]<=dataBitRead;
        end else if(counterTracker == 6) begin
           currentData[5]<=dataBitRead;
        end else if(counterTracker == 7) begin
            currentData[6]<=dataBitRead;
        end  else if(counterTracker == 8) begin
            currentData[7]<=dataBitRead;
        end  else if(counterTracker == 9) begin
            extraBits<=1'b1;
        end else if(counterTracker == 10) begin
            extraBits<=1'b0;
        end 
        
        //Make sure we dont go over the limit
        //restart the cycle
        if(counterTracker == 10) begin
            counterTracker <= 0;
         end
      
        
     end
     
end

//always
//leave this like this in case we want to divide down the clock
reg CustomClock;
always@(MASTERCLOCK) begin
    //just leaves us with the option to divide down the clock
    CustomClock <= MASTERCLOCK;
end 

//On the Positive Edge of the Systems Master Clock
always@(posedge CustomClock) begin
    if(inCase == 0)begin
            //we setup out code to look for extrabits 
            //particulary so we can ensure that extra bits are 1 
            if (extraBits == 1 && flagBitWatcher == 0 && initialzedGo == 1) begin
                //We did intially have previous storing but took it out
                keyboardPressInformation <= currentData;
            end 
            //always set this...
            flagBitWatcher <= extraBits;
     end
end

endmodule