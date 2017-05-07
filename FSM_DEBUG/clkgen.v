`timescale 1ns / 1ps

//Used in partnership with SSD Display Driver
//Generates a clock with a good refres rate
//@author Joe Caraccio
module clkgen(
    input     clk,  // master clock 
    output    refreshClk  //refresh the display
    );   
    reg [26:0]     count = 0;  // counter register variable
    reg [16:0]     refresh = 0; // refresh counter register variable
    reg          tmp_clk = 0; // temporary clock register variable
    reg         rclk = 0; // temporary refresh clock register variable   
    assign refreshClk = rclk; //refresh clock
    BUFG clock_buf_0(  //buffered clock to reduce the clock skew
      .I(clk),
      .O(clk_100mhz)
    );
    // use two always block to generate the clock. 
    // when postive edge of master clock, both always block will be evaluated immediately
    // Use non-block assignment in the block
    always @(posedge clk_100mhz) begin // use for loop to generate the tmp_clk. tmp_clk*count = master clock
      if (count < 10000000) begin //10,000,000 is within the refresh vector range 2^27 
        count <= count + 1; // count up
      end
      else begin
        tmp_clk <= ~tmp_clk; // flip the signal when count reaches 250,000. 
        count <= 0; // reset the counter
      end
    end
    
    always @(posedge clk_100mhz) begin // use for loop to generate the rclk. rclk*refresh = master clock
        if (refresh < 100000) begin //100,000 is within the refresh vector range 2^17
            refresh <= refresh + 1; // count up
        end else begin
            refresh <= 0; // reset the refresh counter
            rclk <= ~rclk; // flip the signal when count reaches 10,000.
        end
    end
    
 endmodule
 