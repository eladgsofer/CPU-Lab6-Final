LIBRARY ieee;
USE ieee.std_logic_1164.all;

-------------------------------------
ENTITY IO_top IS
  GENERIC (BUS_W : INTEGER := 8); -- QUARTUS MODE = 12; | MODELSIM = 8;
  PORT (    datain : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			address : IN STD_LOGIC_VECTOR (BUS_W-1 DOWNTO 0);
			SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clk, MemRead, MemWrite: IN std_logic;
			LEDG, LEDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            dataout: OUT STD_LOGIC_VECTOR(31 downto 0));
END IO_top;
--------------------------------------------------------------
--------------------------------------------------------------
architecture dfl of IO_top is
  component HexGen is
		port(
			HexIn : in std_logic_vector(3 downto 0);
			----------------------------------------
			HexOut : out std_logic_vector(6 downto 0)
		);
	end component;
	
    component IO_Biderctional IS
        GENERIC (n : INTEGER := 8);
        PORT (
        LatchDataIn  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
              MemRead, MemWrite, CSi, clk : IN STD_LOGIC;
              MipsDataBus  : OUT STD_LOGIC_VECTOR(31 downto 0);
              IoDeviceDataIn     : OUT STD_LOGIC_VECTOR(n-1 downto 0));
    END component;
	
	component IO_ReadOnly IS
		PORT (datain : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			  MemRead, CS7 : IN STD_LOGIC;
			  dataout : OUT STD_LOGIC_VECTOR(31 downto 0));
	END component;
	
	component Decoder IS
		PORT (Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0); 
			  CS: OUT STD_LOGIC_VECTOR(15 downto 0));
	END component;
	-----------------------------------------------------------
    --------------------------------------------------------------
	SIGNAL Out_SW, Out_LEDG, Out_LEDR, Out_HEX0, Out_HEX1, Out_HEX2, Out_HEX3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL CS : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL disp_LEDG,disp_LEDR : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL disp_HEX0,disp_HEX1,disp_HEX2,disp_HEX3 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL BTIFG: STD_LOGIC;
begin
    
    
	
	dataout <= 
			   Out_LEDG WHEN CS(0) = '1' ELSE
			   Out_LEDR WHEN CS(1) = '1' ELSE
			   Out_HEX0 WHEN CS(2) = '1' ELSE
			   Out_HEX1 WHEN CS(3) = '1' ELSE
			   Out_HEX2 WHEN CS(4) = '1' ELSE
			   Out_HEX3 WHEN CS(5) = '1' ELSE
               Out_SW   WHEN CS(6) = '1' ELSE
               
			   X"00000000";
	B1 : Decoder port map(address, CS);
    
	B2 : IO_ReadOnly port map(SW,MemRead,CS(6),Out_SW);
    
    -- LEDS
	B3 : IO_Biderctional generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(0),clk,Out_LEDG,disp_LEDG);
	B4 : IO_Biderctional generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(1),clk,Out_LEDR,disp_LEDR);
    LEDG<=disp_LEDG;
	LEDR<=disp_LEDR;
    
    -- HEX LCD
	B5 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(2),clk,Out_HEX0,disp_HEX0);
	B6 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(3),clk,Out_HEX1,disp_HEX1);
	B7 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(4),clk,Out_HEX2,disp_HEX2);
	B8 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(5),clk,Out_HEX3,disp_HEX3);
    
    -- Hex Signal Generators
    H0 : HexGen port map(HexIn=>disp_HEX0,HexOut=>HEX0);
	H1 : HexGen port map(disp_HEX1,HEX1);
	H2 : HexGen port map(disp_HEX2,HEX2);
	H3 : HexGen port map(disp_HEX3,HEX3);
    
    -- Basic Timer
	BT : timer
	PORT MAP (clock => clock, reset => reset, data=> datain(7 DOWNTO 0),
				BTCTL_ctl => CS(11), BTCNT_ctl => BTCNT_ctl(12),
				BTIFG_OUT => BTIFG);
                
END dfl;


