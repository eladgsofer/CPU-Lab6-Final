                        --  Dmemory module (implements the data
                        --  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS
    GENERIC (BUS_W : INTEGER := 8; ADD_BUS: INTEGER :=8); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
             
    PORT(   read_data              : OUT    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            address                : IN     STD_LOGIC_VECTOR( BUS_W-1 DOWNTO 0 );
            write_data             : IN     STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            MemRead, Memwrite      : IN     STD_LOGIC;
            clock,reset            : IN     STD_LOGIC;
            SW                     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            LEDG, LEDR             : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END dmemory;

ARCHITECTURE behavior OF dmemory IS
    COMPONENT IO_top IS
      GENERIC (BUS_W : INTEGER := 8); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
      PORT (    datain : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                address : IN STD_LOGIC_VECTOR (BUS_W-1 DOWNTO 0);
                SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                clk, MemRead, MemWrite: IN std_logic;
                LEDG, LEDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                dataout: OUT STD_LOGIC_VECTOR(31 downto 0));
    END COMPONENT;

SIGNAL write_clock,WriteToMem : STD_LOGIC;
SIGNAL readDataMem, readDataIo : STD_LOGIC_VECTOR(31 downto 0);

BEGIN

-- Load memory address register with write clock
    write_clock <= NOT clock;
        
    read_data <= readDataIo WHEN address(BUS_W-1) = '1' ELSE
                 readDataMem;   
                 
    IO: IO_top 
    GENERIC MAP(
        BUS_W    => BUS_W)
    PORT MAP (
        datain   => write_data,
        address  => address,
        SW       => SW,
        clk      => write_clock,
        MemRead  => MemRead,
        MemWrite => Memwrite,
        LEDG     => LEDG,
        LEDR     => LEDR,
        HEX0     => HEX0,
        HEX1     => HEX1,
        HEX2     => HEX2,
        HEX3     => HEX3,
        dataout  => readDataIo);
        
    WriteToMem <='1' when (memwrite ='1' and address(BUS_W-1)='0') else '0';

    data_memory : altsyncram
    GENERIC MAP  (
        operation_mode         => "SINGLE_PORT",
        width_a                => 32,
        widthad_a              => ADD_BUS,
        lpm_type               => "altsyncram",
        outdata_reg_a          => "UNREGISTERED",
        init_file              => "C:\dmemory.hex",
        intended_device_family => "Cyclone"
    )
    PORT MAP (
        wren_a    => WriteToMem,
        clock0    => write_clock,
        address_a => address(ADD_BUS-1 downto 0),  -- CHANGE THIS WHEN MOVING TO QUARTUS : address(9 downto 0)
        data_a    => write_data,
        q_a       => readDataMem    );
    

    
END behavior;

