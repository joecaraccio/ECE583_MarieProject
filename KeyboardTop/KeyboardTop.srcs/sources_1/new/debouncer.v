`timescale 1ns / 1ps
//Joe Caraccio, Noah Fitter, Ben Miller
//Intially will set the data output to just mirror whateve rthe input is
//but then basically delays down the clock cycle for when we set
//using a counter variable
//this will help limit some of the too frequent changes in the clock cycle
//Most of this work is inspired from the forms online
//citation:
//Based off of the Public Diligent Source on Github with Modifications
module debouncer(
    input inputClock,
    input inputData,
    output reg OuptutLine
    );
    
    //Didn't feel like doing the math
    //but 18:0 is just to ensure its bigg enough
    //pretty sure this is unnesscary however
    reg [22:0] count;
    
    //this will hold the temporary data 
    reg DataHolderComp = 0;
    //upon the positive edge of the clock
    //this always block basiccaly surves as a delay inbetween clock cycles
    //this will help stop the debouncing as we do not want to change our data line too fast
    always@(posedge inputClock)begin
        if (inputData == DataHolderComp) begin
            //if input data is equal to the data output
            if (count == 17)
                //once w are at 17
                //this basically delays 17 clock cycles
                //set this to our output line so the rest of the module can use it
                OuptutLine <= inputData;
            else
                //incriment!!!
                count <= count + 1;
        end else begin
            //if these two are not equal
            //we set the dataHolder line to the input data
            //set count to 0
            //next we wait and count up before setting a new value
            DataHolderComp <= inputData;
            count <= 0;
        end
    end //end always block
endmodule