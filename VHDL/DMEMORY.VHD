                        --  Dmemory module (implements the data
                        --  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS
    GENERIC (BUS_W : INTEGER := 10; ADD_BUS: INTEGER :=8); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
             
    PORT(   read_data              : OUT    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            address                : IN     STD_LOGIC_VECTOR( BUS_W-1 DOWNTO 0 );
            write_data             : IN     STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            MemRead, Memwrite      : IN     STD_LOGIC;
            clock,reset            : IN     STD_LOGIC;
            INTR                   : IN     STD_LOGIC;
            TYPEx                  : IN     STD_LOGIC_VECTOR(ADD_BUS-1 DOWNTO 0));
END dmemory;

ARCHITECTURE behavior OF dmemory IS

SIGNAL write_clock,WriteToMem : STD_LOGIC;
SIGNAL address_orType : STD_LOGIC_VECTOR(ADD_BUS-1 DOWNTO 0 );
BEGIN


-- Load memory address register with write clock
    write_clock <= NOT clock;
        
    -- No need this... just check if we are at the memory space 
                 
    WriteToMem <='1' when (memwrite ='1' and address(BUS_W-1)='0') else '0';
    address_orType <= address(ADD_BUS-1 downto 0) when INTR = '0' ELSE TYPEx; -- need to CHANGE for QUARTUS competability

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
        address_a => address_orType,  -- CHANGE THIS WHEN MOVING TO QUARTUS : address(9 downto 0)
        data_a    => write_data,
        q_a       => read_data    );
    
END behavior;

