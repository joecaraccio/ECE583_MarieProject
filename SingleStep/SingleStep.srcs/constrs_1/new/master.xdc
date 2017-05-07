# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_out1]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_out1]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_out1]
	
# Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw[8]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw[9]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw[10]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw[11]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw[12]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw[13]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw[14]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw[15]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {dec1[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[0]}]
set_property PACKAGE_PIN E19 [get_ports {dec1[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[1]}]
set_property PACKAGE_PIN U19 [get_ports {dec1[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[2]}]
set_property PACKAGE_PIN V19 [get_ports {dec1[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[3]}]
set_property PACKAGE_PIN W18 [get_ports {dec1[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[4]}]
set_property PACKAGE_PIN U15 [get_ports {dec1[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[5]}]
set_property PACKAGE_PIN U14 [get_ports {dec1[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[6]}]
set_property PACKAGE_PIN V14 [get_ports {dec1[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec1[7]}]
set_property PACKAGE_PIN V13 [get_ports {dec2[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[8]}]
set_property PACKAGE_PIN V3 [get_ports {dec2[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[9]}]
set_property PACKAGE_PIN W3 [get_ports {dec2[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[10]}]
set_property PACKAGE_PIN U3 [get_ports {dec2[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[11]}]
set_property PACKAGE_PIN P3 [get_ports {dec2[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[12]}]
set_property PACKAGE_PIN N3 [get_ports {dec2[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[13]}]
set_property PACKAGE_PIN P1 [get_ports {dec2[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dec2[14]}]
set_property PACKAGE_PIN L1 [get_ports {dec2[15]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {dec2[15]}]

set_property PACKAGE_PIN U17 [get_ports pushButton]						
        set_property IOSTANDARD LVCMOS33 [get_ports pushButton]	

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pushButton_IBUF]						

	
set_property PACKAGE_PIN C17 [get_ports PS2Clk]						
        set_property IOSTANDARD LVCMOS33 [get_ports PS2Clk]
        set_property PULLUP true [get_ports PS2Clk]
    set_property PACKAGE_PIN B17 [get_ports PS2Data]                    
        set_property IOSTANDARD LVCMOS33 [get_ports PS2Data]    
        set_property PULLUP true [get_ports PS2Data]
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {segment[6]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[6]}]
set_property PACKAGE_PIN W6 [get_ports {segment[5]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[5]}]
set_property PACKAGE_PIN U8 [get_ports {segment[4]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[4]}]
set_property PACKAGE_PIN V8 [get_ports {segment[3]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[3]}]
set_property PACKAGE_PIN U5 [get_ports {segment[2]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[2]}]
set_property PACKAGE_PIN V5 [get_ports {segment[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[1]}]
set_property PACKAGE_PIN U7 [get_ports {segment[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {segment[0]}]
     
set_property PACKAGE_PIN U2 [get_ports {enable_D1}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_D1}]
set_property PACKAGE_PIN U4 [get_ports {enable_D2}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_D2}]
set_property PACKAGE_PIN V4 [get_ports {enable_D3}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_D3}]
set_property PACKAGE_PIN W4 [get_ports {enable_D4}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {enable_D4}]
       