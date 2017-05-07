#Joe Caraccio
##Clock signal
set_property PACKAGE_PIN W5 [get_ports masterClock]
set_property IOSTANDARD LVCMOS33 [get_ports masterClock]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports masterClock]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {RecievedData[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[0]}]
set_property PACKAGE_PIN E19 [get_ports {RecievedData[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[1]}]
set_property PACKAGE_PIN U19 [get_ports {RecievedData[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[2]}]
set_property PACKAGE_PIN V19 [get_ports {RecievedData[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[3]}]
set_property PACKAGE_PIN W18 [get_ports {RecievedData[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[4]}]
set_property PACKAGE_PIN U15 [get_ports {RecievedData[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[5]}]
set_property PACKAGE_PIN U14 [get_ports {RecievedData[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[6]}]
set_property PACKAGE_PIN V14 [get_ports {RecievedData[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RecievedData[7]}]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports recieverInput]
set_property IOSTANDARD LVCMOS33 [get_ports recieverInput]
#set_property PACKAGE_PIN A18 [get_ports TxD]
#set_property IOSTANDARD LVCMOS33 [get_ports TxD]

#Found on the Diligent Forms
set_property BITSTREAM.STARTUP.STARTUPCLK JTAGCLK [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
