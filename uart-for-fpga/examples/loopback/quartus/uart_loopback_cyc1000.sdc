#-------------------------------------------------------------------------------
# PROJECT: SIMPLE UART FOR FPGA
#-------------------------------------------------------------------------------
# AUTHORS: Jakub Cabal <jakubcabal@gmail.com>
# LICENSE: The MIT License, please read LICENSE file
# WEBSITE: https://github.com/jakubcabal/uart-for-fpga
#-------------------------------------------------------------------------------

create_clock -name {clk_24MHz} -period "24 MHz"  [get_ports { clk_24MHz }]
create_generated_clock -name {clk_12MHz} -source [get_ports { clk_24MHz }] -divide_by 2 [get_registers clk]