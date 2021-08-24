LIBRARY ieee;
USE ieee.std_logic_1164.all;

--------------------------------------
ENTITY Decoder4_7 IS
	PORT (Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		  CS: OUT STD_LOGIC_VECTOR(6 downto 0));
END Decoder4_7;
--------------------------------------
ARCHITECTURE dataflow OF Decoder4_7 IS
BEGIN
	Cs <= "0000001" when Address = "1000" else -- LEDG 800
		  "0000010" when Address = "1001" else -- LEDR 804
		  "0000100" when Address = "1010" else -- HEX0 808
		  "0001000" when Address = "1011" else -- HEX1
		  "0010000" when Address = "1100" else -- HEX2
		  "0100000" when Address = "1101" else -- HEX3
		  "1000000" when Address = "1110" else -- PORT_SW
		  "0000000";
END dataflow;

