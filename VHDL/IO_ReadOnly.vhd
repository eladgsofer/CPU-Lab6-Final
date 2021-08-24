LIBRARY ieee;
USE ieee.std_logic_1164.all;

--------------------------------------
ENTITY IO_ReadOnly IS
	PORT (datain : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  MemRead, CS7 : IN STD_LOGIC;
		  dataout : OUT STD_LOGIC_VECTOR(31 downto 0));
END IO_ReadOnly;
--------------------------------------
ARCHITECTURE dataflow OF IO_ReadOnly IS
BEGIN
	dataout <= X"000000" & datain when (CS7 AND MemRead)='1' else X"00000000"; -- replace X"00000000" with HIGH Z?
END dataflow;

