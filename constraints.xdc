#TX pins
set_property PACKAGE_PIN AD12 [get_ports CLK_200_P]
set_property IOSTANDARD LVDS [get_ports CLK_200_P]
set_property IOSTANDARD LVDS [get_ports CLK_200_N]


set_property PACKAGE_PIN K24 [get_ports o_TX_Serial]
set_property IOSTANDARD LVCMOS25 [get_ports o_TX_Serial]

set_property PACKAGE_PIN K23 [get_ports RTS]
set_property IOSTANDARD LVCMOS25 [get_ports RTS]

set_property PACKAGE_PIN G12 [get_ports i_TX_DV]
set_property IOSTANDARD LVCMOS25 [get_ports i_TX_DV]

#RX pins

set_property PACKAGE_PIN AB8 [get_ports {o_RX_Byte[0]}]
set_property PACKAGE_PIN AA8 [get_ports {o_RX_Byte[1]}]
set_property PACKAGE_PIN AC9 [get_ports {o_RX_Byte[2]}]
set_property PACKAGE_PIN AB9 [get_ports {o_RX_Byte[3]}]
set_property PACKAGE_PIN AE26 [get_ports {o_RX_Byte[4]}]
set_property PACKAGE_PIN G19 [get_ports {o_RX_Byte[5]}]
set_property PACKAGE_PIN E18 [get_ports {o_RX_Byte[6]}]
set_property PACKAGE_PIN F16 [get_ports {o_RX_Byte[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {o_RX_Byte[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {o_RX_Byte[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {o_RX_Byte[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {o_RX_Byte[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {o_RX_Byte[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {o_RX_Byte[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {o_RX_Byte[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {o_RX_Byte[0]}]
set_property PACKAGE_PIN AD12 [get_ports CLK_200_P]
set_property IOSTANDARD LVDS [get_ports CLK_200_P]
set_property IOSTANDARD LVDS [get_ports CLK_200_N]

set_property PACKAGE_PIN K23 [get_ports RTS]
set_property IOSTANDARD LVCMOS25 [get_ports RTS]

set_property PACKAGE_PIN M19 [get_ports i_RX_Serial]
set_property IOSTANDARD LVCMOS25 [get_ports i_RX_Serial]


