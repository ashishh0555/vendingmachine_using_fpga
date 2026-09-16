## =========================================================
## CLOCK
## =========================================================

set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {CLK100MHZ}]

create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}]


## =========================================================
## BUTTONS
## =========================================================

## BTNC - RESET
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {BTNC}]

## BTNU - SELECT ₹10
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports {BTNU}]

## BTNL - INSERT ₹5
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports {BTNL}]

## BTNR - INSERT ₹10
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports {BTNR}]

## BTND - SELECT ₹20
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports {BTND}]


## =========================================================
## LEDS
## =========================================================

## LED0 - ₹10 DISPENSE
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports {LED[0]}]

## LED1 - ₹20 DISPENSE
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports {LED[1]}]

## LED2 - CHANGE
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports {LED[2]}]

## LED3 - ₹20 OR MORE
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {LED[3]}]


## =========================================================
## 7-SEGMENT
## =========================================================

set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports {SEG[0]}]

set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports {SEG[1]}]

set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports {SEG[2]}]

set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports {SEG[3]}]

set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports {SEG[4]}]

set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports {SEG[5]}]

set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports {SEG[6]}]

## Decimal point
set_property -dict { PACKAGE_PIN H15 IOSTANDARD LVCMOS33 } [get_ports {SEG[7]}]


## =========================================================
## 7-SEGMENT ANODES
## =========================================================

set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports {AN[0]}]

set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports {AN[1]}]

set_property -dict { PACKAGE_PIN T9 IOSTANDARD LVCMOS33 } [get_ports {AN[2]}]

set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports {AN[3]}]

set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {AN[4]}]

set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports {AN[5]}]

set_property -dict { PACKAGE_PIN K2 IOSTANDARD LVCMOS33 } [get_ports {AN[6]}]

set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports {AN[7]}]
