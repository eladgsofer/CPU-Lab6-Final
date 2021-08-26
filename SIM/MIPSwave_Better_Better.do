onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -divider Fetch
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4_out
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/Add_result
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/Jump_result
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/Branch
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/BNE
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/Jump
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/Jr
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/Zero
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/PC_out
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/clock
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/reset
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/read_data
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/INTR
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/INTA
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/BranchPc
add wave -noupdate -group Fetch_ /mips_tb/U_0/IFE/JumpPc
add wave -noupdate -group Fetch_ -radix hexadecimal /mips_tb/U_0/IFE/next_PC
add wave -noupdate -divider Decode
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/read_data_1
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/read_data_2
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/Instruction
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/read_data
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/ALU_result
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/PC_plus_4
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/RegWrite
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/MemtoReg
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/RegDst
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/clock
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/reset
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/INTR
add wave -noupdate -group Decode_ /mips_tb/U_0/ID/INTA
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/PC
add wave -noupdate -group Decode_ -radix hexadecimal -childformat {{/mips_tb/U_0/ID/register_array(0) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(1) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(2) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(3) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(4) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(5) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(6) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(7) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(8) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(9) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(10) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(11) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(12) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(13) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(14) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(15) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(16) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(17) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(18) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(19) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(20) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(21) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(22) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(23) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(24) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(25) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(26) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(27) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(28) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(29) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(30) -radix hexadecimal} {/mips_tb/U_0/ID/register_array(31) -radix hexadecimal}} -expand -subitemconfig {/mips_tb/U_0/ID/register_array(0) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(1) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(2) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(3) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(4) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(5) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(6) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(7) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(8) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(9) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(10) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(11) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(12) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(13) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(14) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(15) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(16) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(17) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(18) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(19) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(20) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(21) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(22) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(23) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(24) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(25) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(26) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(27) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(28) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(29) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(30) {-radix hexadecimal} /mips_tb/U_0/ID/register_array(31) {-radix hexadecimal}} /mips_tb/U_0/ID/register_array
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/write_register_address
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/write_data
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/write_register_address_1
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/write_register_address_0
add wave -noupdate -group Decode_ -radix hexadecimal /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -divider Execute
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Read_data_2
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Function_opcode
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/ALUOp
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/ALUSrc
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Zero
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Add_Result
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/PC_plus_4
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/clock
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/reset
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -group Execute_ -radix decimal /mips_tb/U_0/EXE/ALU_output_mux
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/Branch_Add
add wave -noupdate -group Execute_ -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
add wave -noupdate -group Execute_ -radix decimal /mips_tb/U_0/EXE/mult64
add wave -noupdate -divider Mem
add wave -noupdate -group Dmem_ -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/read_data
add wave -noupdate -group Dmem_ -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/address
add wave -noupdate -group Dmem_ -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/write_data
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/MemRead
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/Memwrite
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/clock
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/reset
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/INTR
add wave -noupdate -group Dmem_ -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/TYPEx
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/write_clock
add wave -noupdate -group Dmem_ /mips_tb/U_0/MODELSIM_MEM/MEM/WriteToMem
add wave -noupdate -group Dmem_ -radix hexadecimal /mips_tb/U_0/MODELSIM_MEM/MEM/address_orType
add wave -noupdate -divider IO
add wave -noupdate -group GPIO -radix hexadecimal /mips_tb/U_0/IO/datain
add wave -noupdate -group GPIO -radix hexadecimal /mips_tb/U_0/IO/address
add wave -noupdate -group GPIO /mips_tb/U_0/IO/SW
add wave -noupdate -group GPIO /mips_tb/U_0/IO/pushButtons
add wave -noupdate -group GPIO /mips_tb/U_0/IO/GIE_ctl
add wave -noupdate -group GPIO /mips_tb/U_0/IO/INTA
add wave -noupdate -group GPIO /mips_tb/U_0/IO/INTR
add wave -noupdate -group GPIO /mips_tb/U_0/IO/TYPEx
add wave -noupdate -group GPIO /mips_tb/U_0/IO/clk
add wave -noupdate -group GPIO /mips_tb/U_0/IO/reset
add wave -noupdate -group GPIO /mips_tb/U_0/IO/MemRead
add wave -noupdate -group GPIO /mips_tb/U_0/IO/MemWrite
add wave -noupdate -group GPIO /mips_tb/U_0/IO/LEDG
add wave -noupdate -group GPIO /mips_tb/U_0/IO/LEDR
add wave -noupdate -group GPIO /mips_tb/U_0/IO/HEX0
add wave -noupdate -group GPIO /mips_tb/U_0/IO/HEX1
add wave -noupdate -group GPIO /mips_tb/U_0/IO/HEX2
add wave -noupdate -group GPIO /mips_tb/U_0/IO/HEX3
add wave -noupdate -group GPIO /mips_tb/U_0/IO/dataout
add wave -noupdate -group GPIO /mips_tb/U_0/IO/out_IFG
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_Buttons
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_SW
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_LEDG
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_LEDR
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_HEX0
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_HEX1
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_HEX2
add wave -noupdate -group GPIO /mips_tb/U_0/IO/Out_HEX3
add wave -noupdate -group GPIO /mips_tb/U_0/IO/CS
add wave -noupdate -group GPIO /mips_tb/U_0/IO/pushButtonsInput
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_LEDG
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_LEDR
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_HEX0
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_HEX1
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_HEX2
add wave -noupdate -group GPIO /mips_tb/U_0/IO/disp_HEX3
add wave -noupdate -group GPIO /mips_tb/U_0/IO/BTIFG
add wave -noupdate -group GPIO /mips_tb/U_0/IO/TODO_not_connected_yet
add wave -noupdate -group GPIO /mips_tb/U_0/IO/ifg_write
add wave -noupdate -group GPIO /mips_tb/U_0/IO/ifg_read
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/clock
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/irq0
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/irq1
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/irq2
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/irq3
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/INTA
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/GIE_enable
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/reset
add wave -noupdate -group Interrupt -radix hexadecimal /mips_tb/U_0/IO/INTRPT/data
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/GIE_ctl
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/IFG_store_ctl
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/IFG_load_ctl
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/IE_ctl
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/INTR
add wave -noupdate -group Interrupt -radix hexadecimal /mips_tb/U_0/IO/INTRPT/TYPEx
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/out_IFG
add wave -noupdate -group Interrupt /mips_tb/U_0/IO/INTRPT/GIE
add wave -noupdate -group Interrupt -radix hexadecimal /mips_tb/U_0/IO/INTRPT/IE
add wave -noupdate -group Interrupt -radix hexadecimal /mips_tb/U_0/IO/INTRPT/IFG
add wave -noupdate -group Interrupt -radix hexadecimal /mips_tb/U_0/IO/INTRPT/IFG2
add wave -noupdate -divider {Control Signals}
add wave -noupdate -group Control /mips_tb/U_0/CTL/Opcode
add wave -noupdate -group Control /mips_tb/U_0/CTL/RegDst
add wave -noupdate -group Control /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -group Control /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemRead
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -group Control /mips_tb/U_0/CTL/Branch
add wave -noupdate -group Control /mips_tb/U_0/CTL/BNE
add wave -noupdate -group Control /mips_tb/U_0/CTL/Jump
add wave -noupdate -group Control /mips_tb/U_0/CTL/Jr
add wave -noupdate -group Control /mips_tb/U_0/CTL/ALUop
add wave -noupdate -group Control /mips_tb/U_0/CTL/clock
add wave -noupdate -group Control /mips_tb/U_0/CTL/reset
add wave -noupdate -group Control /mips_tb/U_0/CTL/INTR
add wave -noupdate -group Control /mips_tb/U_0/CTL/INTA
add wave -noupdate -group Control /mips_tb/U_0/CTL/RT
add wave -noupdate -group Control /mips_tb/U_0/CTL/GIE_ctl
add wave -noupdate -group Control /mips_tb/U_0/CTL/R_format
add wave -noupdate -group Control /mips_tb/U_0/CTL/OpcodeZero
add wave -noupdate -group Control /mips_tb/U_0/CTL/I_format
add wave -noupdate -group Control /mips_tb/U_0/CTL/Lw
add wave -noupdate -group Control /mips_tb/U_0/CTL/Sw
add wave -noupdate -group Control /mips_tb/U_0/CTL/Beq
add wave -noupdate -group Control /mips_tb/U_0/CTL/Mul
add wave -noupdate -group Control /mips_tb/U_0/CTL/Jal
add wave -noupdate -group Control /mips_tb/U_0/CTL/Lui
add wave -noupdate -group Control /mips_tb/U_0/CTL/RegWriteSig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2250314 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 305
configure wave -valuecolwidth 40
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
WaveRestoreZoom {2096256 ps} {2711852 ps}
