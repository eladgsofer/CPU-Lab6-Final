Control.vhd           : The control unit of the mips architecture.
Decoder.vhd           : simple 4 input 8 output decoder(output is one-hot encoded)
DMemory.vhd           : Data Memory of the mips architecture.
Execute.vhd           : Execute Phase of the mips architecture.
HexGen.vhd            : 4 to 7 bit decoder used to decode binary to hex display.
IDecode.vhd           : The Decode phase of the mips architecture.
IFetch.vhd            : The Fetch Phase of the mips architecture.
IO_Bidrectionnal.vhd  : This block is an input output driver for the IO devices. it is a simple register with a single data port in the IO side and a two bus in the cpu side(one for read and one for write).
IO_top.vhd            : Connects the interface of all other IO and designates CS to them.
IO_ReadOnly.vhd       : This Block is an output driver for the IO device.