## ===================================================================================
## Clock Input - 100MHz Oscillator
## ===================================================================================
set_property PACKAGE_PIN H4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Reset Input - Push Button S3 (Active-High)
set_property PACKAGE_PIN N17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Seven Segment Display Outputs (ACTIVE-LOW)

# Enable pins (Active Low)
set_property -dict { PACKAGE_PIN N3  IOSTANDARD LVCMOS33 } [get_ports { enable[0] }];
set_property -dict { PACKAGE_PIN R1  IOSTANDARD LVCMOS33 } [get_ports { enable[1] }];
set_property -dict { PACKAGE_PIN P1  IOSTANDARD LVCMOS33 } [get_ports { enable[2] }];
set_property -dict { PACKAGE_PIN L4  IOSTANDARD LVCMOS33 } [get_ports { enable[3] }];

# Segment pins (Active Low) - Mapping seg_out(0) to Segment A, etc.
set_property -dict { PACKAGE_PIN P4  IOSTANDARD LVCMOS33 } [get_ports { seg_out[0] }]; # a
set_property -dict { PACKAGE_PIN N4  IOSTANDARD LVCMOS33 } [get_ports { seg_out[1] }]; # b
set_property -dict { PACKAGE_PIN M3  IOSTANDARD LVCMOS33 } [get_ports { seg_out[2] }]; # c
set_property -dict { PACKAGE_PIN M5  IOSTANDARD LVCMOS33 } [get_ports { seg_out[3] }]; # d
set_property -dict { PACKAGE_PIN L5  IOSTANDARD LVCMOS33 } [get_ports { seg_out[4] }]; # e
set_property -dict { PACKAGE_PIN L6  IOSTANDARD LVCMOS33 } [get_ports { seg_out[5] }]; # f
set_property -dict { PACKAGE_PIN M6  IOSTANDARD LVCMOS33 } [get_ports { seg_out[6] }]; # g