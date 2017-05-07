`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Benjamin Miller 
// 
// Module Name: FSM: 
// Description: Finite State Machine used for debugging Marie Register values
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM(
    input clk,
    input PS2Data,
    input PS2Clk,
    output [6:0] segment,
    output enable_D1,
    output enable_D2,
    output enable_D3,
    output enable_D4,
    input [15:0] MARdata,
    input [15:0] MBRdata,
    input [15:0] IRdata,
    input [15:0] PCdata,
    input [15:0] INREGdata,
    input [15:0] OUTREGdata,
    input [15:0] ACdata
    
    );
    
// placeholder TLB values
parameter dval = 4'b0001, mval = 4'b0010, aval = 4'b0011,
 bval = 4'b0101, nval = 4'b0110, ival = 4'b0111,
pval = 4'b1000, oval = 4'b1001;
    
// for State values (placeholder)
parameter IDLE = 4'b0000,
 DISPLAY = 4'b0001,
 MA = 4'b0010,
 MB = 4'b0011, 
 PC = 4'b0100, 
 IR = 4'b0101,
 INREG = 4'b0111,
OUTREG = 4'b1000, AC = 4'b1001;

// for key values 
parameter dkey = 8'h00000023, mkey = 8'h0000003A, 
akey = 8'h0000001C, bkey = 8'h00000032, nkey = 8'h00000031, 
ikey = 8'h00000043, pkey = 8'h0000004D,
 okey = 8'h00000044, rkey = 8'h0000002D; 
 
 wire [7:0] keyPress;
 
 //keyboard initialization
 PS2Receiver uut (
         .clk(clk),
         .kclk(PS2Clk),
         .kdata(PS2Data),
         .segInfo(keyPress)
     );
 // Keeps track of current register
 reg [3:0] State;
 //reg [3:0] nextState;
 reg[15:0] out; // holds data values of current register selected
 
 
 
 wire refreshClk; ////refresh the display
 
 //ssd clock
 clkgen Uclkgen(
    .clk(clk),
    .refreshClk(refreshClk)
     );
           
 //turn on all 4 seven segment displays
 enable en1(refreshClk,
    enable_D1,
    enable_D2,
    enable_D3,
    enable_D4
    );
  
  // SSD intialization        
 ssd sssu(
    out[3:0],
    out[7:4],
    out[11:8],
    out[15:12],
    enable_D1,
    enable_D2,
    enable_D3,
    enable_D4,
    segment
    );
    

 // changes output based on current state
 always @( State ) 
 begin
    case( State )
        MA: 
            out = MARdata; // ssd shows MARdata value
        MB:     
            out = MBRdata; // ssd shows MBRdata value
        IR:
            out = IRdata; // ssd shows IRdata value
        PC:
            out = PCdata; // ssd shows PCdata value
        INREG:
            out = INREGdata; // ssd shows INREGdata value
        OUTREG:
            out = OUTREGdata; // ssd shows OUTREG value
        AC:
            out = ACdata; // ssd shows ACdata value
        IDLE:
            out = 4'b0000; // IDLE state, just put 0 on the ssd
     endcase
                 
                 
 end
 
 
 // always blocks to compute next state
 always @(posedge clk)
 begin
    if( keyPress == rkey )
    begin
        State = IDLE; // r key to reset
    end
    else
    begin
    
         case( State )
            IDLE:
            begin
                if( keyPress == mkey )
                begin
                    State = MA; // load MA  
                end
                else if( keyPress == bkey )
                 begin
                    State = MB; // load MA
                
                end
                else if( keyPress == ikey )
                begin
                    State = IR; // load IR 
                end
                else if( keyPress == pkey )
                begin
                    State = PC; // load PC
                end
                else if( keyPress == nkey )
                begin
                    State = INREG; // load INREG
                end
                else if( keyPress == okey )
                begin
                    State = OUTREG; // load OUTREG
                end
                else if( keyPress == akey )
                begin
                    State = AC; // load AC
                end
           end  
    endcase
end
end
                                  
endmodule
