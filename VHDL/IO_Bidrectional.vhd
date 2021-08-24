LIBRARY ieee;
USE ieee.std_logic_1164.all;

--------------------------------------
ENTITY IO_Biderctional IS
	GENERIC (n : INTEGER := 8);
	PORT (LatchDataIn  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  MemRead, MemWrite, CSi, clk : IN STD_LOGIC;
		  MipsDataBus  : OUT STD_LOGIC_VECTOR(31 downto 0);
		  IoDeviceDataIn     : OUT STD_LOGIC_VECTOR(n-1 downto 0));
END IO_Biderctional;
--------------------------------------
ARCHITECTURE dataflow OF IO_Biderctional IS

	SIGNAL LatchDataOut : std_logic_vector(7 downto 0);
	SIGNAL LatchEnable : std_logic;

BEGIN
	
	LatchEnable <= '1' when (MemWrite='1' AND CSi = '1') ELSE '0';
    
    -- IO Latch
    PROCESS (clk)
    BEGIN
	IF (clk'EVENT and clk='1') THEN
		IF (LatchEnable = '1') THEN
			LatchDataOut <= LatchDataIn(7 DOWNTO 0); -- IT IS 7 always! 
		End IF;
    END IF;
    END PROCESS;
    
	IoDeviceDataIn <= LatchDataOut(n-1 downto 0); -- take only the n bits from the register..! 
	
  -- If MemRead is on pass the Register to the DataBus
	MipsDataBus <= X"000000" & LatchDataOut when (MemRead AND CSi) = '1' else X"00000000";
    

	

END dataflow;

