## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

##Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Switches
set_property PACKAGE_PIN V17 [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property PACKAGE_PIN V16 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property PACKAGE_PIN W16 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property PACKAGE_PIN W17 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]
set_property PACKAGE_PIN W15 [get_ports {switches[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[4]}]
set_property PACKAGE_PIN V15 [get_ports {switches[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[5]}]
set_property PACKAGE_PIN W14 [get_ports {switches[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[6]}]
set_property PACKAGE_PIN W13 [get_ports {switches[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[7]}]

##Buttons

set_property PACKAGE_PIN T18 [get_ports btn1]
set_property IOSTANDARD LVCMOS33 [get_ports btn1]



##USB-RS232 Interface
#set_property PACKAGE_PIN B18 [get_ports RxD]
#set_property IOSTANDARD LVCMOS33 [get_ports RxD]
set_property PACKAGE_PIN A18 [get_ports TxD]
set_property IOSTANDARD LVCMOS33 [get_ports TxD]

set_property BITSTREAM.STARTUP.STARTUPCLK JTAGCLK [current_design]

set_property CFGBVS VCCO [current_design]
#where value1 is either VCCO or GND

set_property CONFIG_VOLTAGE 3.3 [current_design]
#where value2 is the voltage provided to configuration bank 0








