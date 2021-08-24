onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider Mem
add wave -noupdate -group MEM -radix hexadecimal -childformat {{/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(31) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(30) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(29) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(28) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(27) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(26) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(25) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(24) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(23) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(22) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(21) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(20) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(19) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(18) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(17) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(16) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(15) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(14) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(13) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(12) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(11) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(10) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(9) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(8) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(7) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(6) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(5) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(4) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(3) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(2) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(1) -radix hexadecimal} {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(0) -radix hexadecimal}} -subitemconfig {/mips_tb/U_0/MODELSIM_MEM/MEM/read_data(31) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(30) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(29) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(28) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(27) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(26) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(25) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(24) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(23) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(22) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(21) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(20) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(19) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(18) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(17) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(16) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(15) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(14) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(13) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(12) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(11) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(10) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(9) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(8) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(7) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(6) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(5) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(4) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(3) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(2) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(1) {-height 15 -radix hexadecimal} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data(0) {-height 15 -radix hexadecimal}} /mips_tb/U_0/MODELSIM_MEM/MEM/read_data
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/address
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/write_data
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/MemRead
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/Memwrite
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/clock
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/reset
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/SW
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/LEDG
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/LEDR
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/HEX0
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/HEX1
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/HEX2
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/HEX3
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/write_clock
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/WriteToMem
add wave -noupdate -group MEM /mips_tb/U_0/MODELSIM_MEM/MEM/readDataMem
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/readDataIo
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/datain
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/address
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/SW
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/clk
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/MemRead
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/MemWrite
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/LEDG
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/LEDR
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/HEX0
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/HEX1
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/HEX2
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/HEX3
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/dataout
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_SW
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_LEDG
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_LEDR
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_HEX0
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_HEX1
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_HEX2
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/Out_HEX3
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/CS
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_LEDG
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_LEDR
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_HEX0
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_HEX1
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_HEX2
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/disp_HEX3
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/D_adress
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B1/Address
add wave -noupdate -group IO /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B1/CS
add wave -noupdate -group B1_DECODER /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B1/Address
add wave -noupdate -group B1_DECODER /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B1/CS
add wave -noupdate -group B2_SW /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B2/datain
add wave -noupdate -group B2_SW /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B2/MemRead
add wave -noupdate -group B2_SW /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B2/CS7
add wave -noupdate -group B2_SW /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B2/dataout
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/LatchDataIn
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/MemRead
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/MemWrite
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/CSi
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/clk
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/MipsDataBus
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/IoDeviceDataIn
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/LatchDataOut
add wave -noupdate -group B3_LEDG /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B3/LatchEnable
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/LatchDataIn
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/MemRead
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/MemWrite
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/CSi
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/clk
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/MipsDataBus
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/IoDeviceDataIn
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/LatchDataOut
add wave -noupdate -group B4_LEDR /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B4/LatchEnable
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/LatchDataIn
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/MemRead
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/MemWrite
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/CSi
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/clk
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/MipsDataBus
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/IoDeviceDataIn
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/LatchDataOut
add wave -noupdate -group B5_HEX0 /mips_tb/U_0/MODELSIM_MEM/MEM/IO/B5/LatchEnable
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -divider Fetch
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4_out
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Add_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Branch
add wave -noupdate /mips_tb/U_0/IFE/BNE
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Zero
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_out
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/next_PC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -divider Decode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data_2
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/ALU_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/RegWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/MemtoReg
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/RegDst
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/register_array
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/write_register_address_0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -divider Execute
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Read_data_2
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Function_opcode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALUOp
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALUSrc
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Zero
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Add_Result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/PC_plus_4
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -radix decimal /mips_tb/U_0/EXE/ALU_output_mux
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/Branch_Add
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
add wave -noupdate -radix decimal /mips_tb/U_0/EXE/mult64
add wave -noupdate -divider Mem
add wave -noupdate -divider {Control Signals}
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Opcode
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/RegDst
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemRead
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Branch
add wave -noupdate /mips_tb/U_0/CTL/BNE
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/ALUop
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/R_format
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Lw
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Sw
add wave -noupdate -radix hexadecimal /mips_tb/U_0/CTL/Beq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {334197 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 350
configure wave -valuecolwidth 103
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {777066 ps}
