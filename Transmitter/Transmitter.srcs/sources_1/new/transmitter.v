`timescale 1ns / 1ps
//Ben Miller, Joe Caraccio, Noah Fitter
//Used for writing to the python terminal
//
//All of this code below is ours, with the exception of the Parameter Logic (how to calculate baud rate
//Thank you to Alex Wong of the Diligent Sales Team for the post on baud/ div counter
//also with inspiration as how to organize the code, with always blocks and bit/sample counters, modes and resetters
//Examples provided by him enabled us to figure out how to be on the same baud rate and correctly shift in values
//and how to use parameters with the baud rate, along with how the sampling of the reciever port would work
module transmitter(
input masterClock, 
input triggerPush, 
input [7:0] data, 
output reg OutTX  
    );
 //Editable Parameter
 //count target
 parameter countTarget = 10416;

 //this variable is used to counter to 10415   
 reg [20:0] counterVar = 1;
 reg [6:0] bc;
 //know if we are on the write out sequence or read sequence
 reg sequenceTrack = 0;
 
 reg [1:0] dat1;
 reg [1:0] newdat1; 
 reg [1:0] newdat3; 
 reg [1:0] newdat4; 
 reg [1:0] newdat5; 
 reg [1:0] sc;
 
 //lets us know if we are ready to load in new data
 reg [2:0] ready; 
 
 //This is for packaging up the bits
 //Start Bit will be 1
 //End Bit will be 0
 reg StartBit = 1'b1;
 reg EndBit = 1'b0;
 reg [9:0] outputData = 0;
 reg [15:0] doubleOutput;
 reg writeOutMode = 0;
 reg clearBit; 
 
 
 //used to indicate if we need something to be shifted
 //would be shifted by 1
 //not sure why it started at 1, because of debug
reg activateShift = 1;

//Data Register
//with an extra bit
reg [9:0] dataReg1; 

//Clock
//this give us option is fe want to reduce the clocking rate
reg customClock;
reg halfSpeedClock;
reg stateFlip = 0;
always@( masterClock ) begin
    //we can only change every other if we want to half speed
    customClock <= masterClock;
    
    //Half Speed Clock
    if(stateFlip == 0) begin
        stateFlip <= 1;
    end else begin
        //Flip Clock
        //will happen every other execution
        halfSpeedClock <= masterClock;

    end
    
end


always@(posedge customClock) begin

            counterVar <= counterVar + 1; 
            if ( counterVar >= countTarget ) begin 
                //same sort of convention with as our reciever
                //modes
                
                  dat1 <= newdat1; 
                  
                  //RESET THIS
                  counterVar <= 1;
                  
                  
                  //Bit Shift in Data
            	  if (ready == 1) begin
            	       
            	       if(writeOutMode == 0) begin
            	           outputData <= { StartBit, data, EndBit};
                           dataReg1 <= { outputData }; 
            	       end else begin
            	           //16 Bit mode.. Still in Progress
            	           doubleOutput <= { StartBit, data, data, EndBit};
            	       end
            	  
            	       
		          end
		          
		          
		          if (clearBit == 1) begin
		              bc <=0; 
		          end
                  
                  if (activateShift == 0) begin 
                        dataReg1 <= dataReg1 >> 1; 
                        bc <= bc + 1;
                   end else if(activateShift == 1) begin
                        //do not shift!
                   end
                   
                   
                   
                   
               end

    //determine if we are ready to shift
    ready <=0; 
    
    
    //basically our output register, the bit that will be written
    //reverse of rx
    OutTX <= 1; 
    
        clearBit <=0; 
    activateShift <= 1;
    if(dat1 == 1) begin
          if (triggerPush == 1) begin
                 newdat1 <= 0;
                 ready <=1; 
                 activateShift <=1; 
                 
                 
                     clearBit <=0; 
                 end 
            else begin 
            
                 newdat1 <= 1; 
                 OutTX <= 1; 
             end
    end else if(dat1 == 0) begin
                
               //if our count is 10
               //it means we have written out all 10 bits
               if (bc >= 10) begin 
                    //Clear out everything and idle
                    newdat1 <= 1; 
                    
                    clearBit <=1; 

                    
                end 
              
              
         else begin 
               //TURN ON SHIFT
               activateShift <= 0; 

            
              newdat1 <= 0; 
              
              //Get least significant bit of the string
              OutTX <= dataReg1[0]; 
          end
              
              
    end else
    
    
        //Do Nothing State
        newdat1 <= 1;
    
    end
    
    

endmodule

