LIBRARY ieee;
USE ieee.std_logic_1164.all;

--------------------------------------
ENTITY Decoder IS
	PORT (Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		  CS: OUT STD_LOGIC_VECTOR(15 downto 0));
END Decoder;
--------------------------------------
ARCHITECTURE dataflow OF Decoder4_7 IS
BEGIN
	Cs <= "0000000000000001" when Address = "0x800" else -- LEDG 800
		  "0000000000000010" when Address = "0x804" else -- LEDR 804
		  "0000000000000100" when Address = "0x808" else -- HEX0 808
		  "0000000000001000" when Address = "0x80C" else -- HEX1
		  "0000000000010000" when Address = "0x810" else -- HEX2
		  "0000000000100000" when Address = "0x814" else -- HEX3
		  "0000000001000000" when Address = "0x818" else -- PORT_SW
          "0000000010000000" when Address = "0x81C" else -- PUSH BUTTONS
          "0000000100000000" when Address = "0x820" else -- UCTL
          "0000001000000000" when Address = "0x821" else -- RX_BUFFER
          "0000010000000000" when Address = "0x822" else -- TX_BUFFER
          "0000100000000000" when Address = "0x824" else -- BTCTL
          "0001000000000000" when Address = "0x828" else -- BTCNT
          "0010000000000000" when Address = "0x82C" else -- IE
          "0100000000000000" when Address = "0x82D" else -- IFG
          "1000000000000000" when Address = "0x82E" else -- TYPE
		  "0000000000000000";
END dataflow;

