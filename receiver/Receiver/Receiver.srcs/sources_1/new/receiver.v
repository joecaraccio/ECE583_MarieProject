`timescale 1ns / 1ps
//Ben Miller, Joe Caraccio, Noah Fitter
//Works with out Python Module that sends bits.. 8 to be exact
//this can be modified and we will detail how in the code, just thought it would be the easierst way
//input is the RxD port (Reciever)
//Output RxData.. 
//
//All of this code below is ours, with the exception of the Parameter Logic (how to calculate baud rate
//Thank you to Alex Wong of the Diligent Sales Team for the post on baud/ div counter
//also with inspiration as how to organize the code, with always blocks and bit/sample counters, modes and resetters
//Examples provided by him enabled us to figure out how to be on the same baud rate and correctly shift in values
//and how to use parameters with the baud rate, along with how the sampling of the reciever port would work
module receiver(
    input masterClock, 
    input recieverInput, 
    output [7:0] RecievedData 
);

//know if we are on the write out sequence or read sequence
reg sequenceTrack = 0;

reg [1:0] dat1;
reg [1:0] newdat1; 
reg [1:0] newdat3; 
reg [1:0] newdat4; 
reg [1:0] newdat5; 
reg [1:0] sc; 

//used to track if we have new data
//set to 1 where the set it equal to 1
reg shiftNotify; 

//clears the sample counter
//clear it!
//if set to 1 will clear
//also add to sc_i
reg sc_cl;
reg sc_i;

//need to be count a value greater than 0
//this is our sample counter
reg [2:0] sc; 

//bit counter.. need to able to count up to 9
reg [4:0] bc;

//Counter fo rcounting the Baud Rate
//might not need to be this wide, but just want to make sure
reg [15:0] cnt; 

//Bit counter status variables
//if 1 these are true
reg bc_cl;
reg bc_i;
reg shiftRegTemp;
reg [3:0] lessCounter;
//Bit Shifting
//Since this is built for 8 bit output, we are constantly shifting

//clock for bitrate
reg bitClock;

//BC2 Trackers.
reg bc2_cl;
reg bc2_i;
reg bc3_cl;
reg bc3_i;

reg bitMode = 0;

//This was a weird bug, but solving this made sense
reg shiftRegTemp2 = 0;

//Credit to Alex Wong of Diligent Sales Team on these equations and how to calculate
//(as noted above)
//baud rate
//assuming a baud rate with a calculation of 9_600
parameter smp1 = 4; 
parameter smp2 = smp1 - 1;
parameter smp3 = (9_600*smp1);
//we know that this is the max we can reach
parameter countSpot = 100_000_000/smp3;
//need to account for 0, so subtract 1.. just afraid of order of ops
parameter countSpot2 = countSpot - 1;  
parameter mid_sample = (4/2);  

reg [9:1] temptempShiftHolder;
//10 bit swill be each data read
//1 start bit, 1 end bit, 8 data bits
parameter bitPatternDetection = 10;
//10 is probably not needed
parameter bitAccountForZero = 9; 

parameter ms1 = (4/2) - 1;
reg lessCounter;

//tempory 
reg [9:0] tempRegShiftHolder; 
reg traceone = 0;
reg countOverrideMode = 0;
//constant assign output
assign RecievedData = tempRegShiftHolder [8:1]; 
//we make sure to constantly assign RecievedData which is our output
    
 //Testing Bit Rate Clock
reg nwa;
always @( posedge masterClock) begin
    bitClock <= ~bitClock;
    nwa<=1;
end  
reg shifter12 = 0;

//not yet completely implimented
reg pythonSequenceModeSwitch = 0;
reg [15:0] doubleReg = 0; 

//Using One Master Always Block
//running on the clockedge of the MasterClock
//in this always block we make sure that if required to we shift in the new data bits
//which will be automatically assigned thanks to the assign block a few lines above
//one of the lower always blocks is in charge of running through the mod logic to make sure we read in the value
//it is important to keep the bit rates on que together
//This is always run upon a positive edge
//we use either a 1 or a 0 to determine what state the logic is in
//
always @ (posedge masterClock) begin 

    if(sequenceTrack == 0) begin
         //incriment our counter variable
            cnt <= cnt +1; 
            
        //Have we reached the count we need to match the baud rate
        //we can reset our mode
        //start are count at 0
        //if we are set to shift, then shift in a new value to register
        if (cnt >= countSpot2) begin 
        
            if(countOverrideMode == 0) begin
                //Set our counter to 0
                cnt <=0; 
                
                //setup the new mode in our new mode variable
                dat1 <= newdat1; 
                
                //Weird Bug I was able to solve
                if(shiftRegTemp == 1) begin
                    shiftRegTemp2 <= 1;
                end else begin
                    shiftRegTemp2 <= 0;
                end
            end
            //If we have new data that we should be shifting in
            if(shiftRegTemp2 == 1) begin
                //combine the two values
                //shift it over slightly and add in the value of our rxD
                //recieverInput is our newext value, so we shift it in with the others
                temptempShiftHolder <= tempRegShiftHolder[9:1];
                tempRegShiftHolder <= {recieverInput,tempRegShiftHolder[9:1]};
                if(shifter12 == 0) begin
                    tempRegShiftHolder <= {recieverInput,tempRegShiftHolder[9:1]};
                end else begin
                    tempRegShiftHolder <= {recieverInput,temptempShiftHolder};
                end
                
                //Brackets from Diligent form, wasn't aware you could do that
            end
            //bit counter and sample counter
            //BC Stuff
            //reset
            
            //if reset mode is 0, which it always should be
            if(traceone == 0) begin
            
                //Master reset Block           
                if(bc_cl == 1) begin 
                    //set to 0 to reset
                    bc <=0;
                end
                //incriment our bit counter                 
                if(bc_i == 1) begin
                    //incriment bitcounter
                    bc <= bc +1;
                end
                
                //we have a sampling counter that we can clear
                //only if the sample counter clear variable is == 1
                if(sc_cl == 1) begin
                    //set to 0
                   sc <=0;
                end
                
                 //if we are supposed to incriment
                if( sc_i == 1) begin
                    //incriment
                    sc <= sc +1;
                end
                
             end else if(traceone == 1) begin
                //debug stuff
                 //Master reset Block           
                if(bc_cl == 1) begin 
                    //set to 0 to reset
                    bc <=1;
                end
                //incriment our bit counter                 
                if(bc_i == 1) begin
                    //incriment bitcounter
                    bc <= bc -1;
                end
                
                if(sc_cl == 1) begin
                    //set to 0
                   sc <=0;
                end
                
                 //if we are supposed to incriment
                if( sc_i == 1) begin
                    //incriment
                    sc <= sc +1;
                end
             
             end 

        end
    
    end
    
    if(sequenceTrack == 0) begin
    
    //If this is one, in our always block above
    //we know to then shift over a bit in our bit string
    //bit string being output data 
    if(pythonSequenceModeSwitch == 0) begin
        shiftRegTemp <= 0;
    end else if(  pythonSequenceModeSwitch == 1) begin
        shiftRegTemp <= 1;
    end
    
    //set are sample counter 
    //Clear all our trackers
    //Upon each clock cycle it is like terning a new page
    
    //Just gonna leave Bit mode out for now
    if(bitMode == 0) begin
        sc_cl <=0; 
        sc_i <=0; 
        bc_cl <=0; 
        bc_i <=0; 
        bc2_cl <= 0;
        bc2_i <= 0;
        bc3_cl <= 0;
        bc3_i <= 0;
        
        //Not yet working the way I want this too but will just hold it like this for now
        //really only using newDat1
        newdat1 <=0; 
        newdat3 <= 0;
        newdat4 <= 0;
        newdat5 <= 0;
     end else if(bitMode == 1) begin
        sc_cl <=1; 
         sc_i <=1; 
         bc_cl <=1; 
         bc_i <=1; 
         bc2_cl <= 1;
         bc2_i <= 1;
         bc3_cl <= 1;
         bc3_i <= 1;
     
     end
    
     //walk through modes
     //mode 1 = is just watiing for data
     //mode 0 = we have data
    //dat 1 serves as an indicator basically
    if(dat1 == 1) begin 
    //no data, set to do nothing mode!
       if (recieverInput == 1) begin
       //if this is true this means we have new values
       //set new data to 1
       //at the end of the loop we transfer to 
         newdat1 <=1;    
       end else begin
           ///Still Nothing.. use all our clear bits 
           newdat1 <=0; 
           bc_cl <=1; 
           sc_cl <=1; 
           bc3_cl <= 1;
           bc2_cl <= 1;
           
           if(bitMode == 1) begin
               newdat1 <= 1;
           end
           
       end
           
    end else if(dat1 == 0) begin 
    //reciever
            //make sure we are on the same page with newDat1
            //as thats the next 'mode'
            newdat1 <= 0; 
       
            // if we are equal to the mid simple shift (Credit Diligent supper team)
            if (sc == ms1) begin
                //meaning we will have to shift
                //shift in a new value
                shiftRegTemp <= 1; 
            end
            
            //if we are at the sample count
            //basically make sure we reset
            if (sc == smp2) begin 
            
                //won't have data on the next cycle
                if (bc == bitAccountForZero) begin 
                    newdat1 <= 1;
                    
                    if(bitMode == 1) begin
                       newdat1 <= 0;
                   end
                     
                end 
                    
                //incrimentor 
                //set bit counter to incriment
                //set sc to incriment   
                bc_i <=1; 
                sc_cl <=1; 
                
                if(bitMode == 1) begin
                    bc_i <=0; 
                   sc_cl <=0; 
                 end

            end else begin
            //samp counter 
            //set it to incriment mode
            //in the always block at the top it will incriment
             sc_i <= 1; 
           end
           
           
        end else begin
        //Do Nothing
        //Set to do nothing mode
         newdat1 <=1; 
         //use this on the next cycle
       end
       
       end
       if(pythonSequenceModeSwitch == 0) begin
            sequenceTrack <= 0;
       end else if(pythonSequenceModeSwitch == 1) begin
            //16 bit mode.. still a work in progress
            doubleReg = 16'b0000000000000000;
       end
       
end   

//End of the Module! Hurrah!      
endmodule
