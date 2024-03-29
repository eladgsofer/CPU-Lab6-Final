-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY Ifetch IS
    GENERIC(BUS_W : INTEGER := 12; ADD_BUS: INTEGER :=10; QUARTUS : INTEGER := 1);
    PORT(   Instruction      : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            PC_plus_4_out    : OUT   STD_LOGIC_VECTOR( 9 DOWNTO 0 );
            Add_result       : IN    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            Jump_result      : IN    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            Branch           : IN    STD_LOGIC;
            BNE              : IN    STD_LOGIC;
            Jump             : IN    STD_LOGIC;
            Jr               : IN    STD_LOGIC;
            Zero             : IN    STD_LOGIC;
            PC_out           : OUT   STD_LOGIC_VECTOR( 9 DOWNTO 0 );
            clock, reset     : IN    STD_LOGIC;
            read_data 		: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            INTR		 		: IN 	STD_LOGIC;
			INTA		 		: IN 	STD_LOGIC);
END Ifetch;

ARCHITECTURE behavior OF Ifetch IS
    SIGNAL PC, PC_plus_4     : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
    SIGNAL Mem_Addr : STD_LOGIC_VECTOR( ADD_BUS-1 DOWNTO 0 );
    SIGNAL BranchPc,JumpPc,next_PC  : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
BEGIN
--ROM for Instruction Memory
inst_memory: altsyncram
    
    GENERIC MAP (
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => ADD_BUS,
        lpm_type => "altsyncram",
        outdata_reg_a => "UNREGISTERED",
        init_file => "C:\program.hex",
        intended_device_family => "Cyclone"
    )
    PORT MAP (
        clock0          => clock,
        address_a       => Mem_Addr, 
        q_a             => Instruction 
    );
        
        -- Instructions always start on word address - not byte
        PC(1 DOWNTO 0)  <= "00";
        -- copy output signals - allows read inside module
        PC_out          <= PC;
        PC_plus_4_out   <= PC_plus_4;
        -- send address to inst. memory address register
        MODELSIM_PC : IF QUARTUS = 0 GENERATE                                                    
            Mem_Addr        <= Next_PC;       
        END GENERATE;
        QUARTUS_PC : IF QUARTUS = 1 GENERATE                                                    
            Mem_Addr        <= Next_PC & "00";
        END GENERATE;
        
        -- Adder to increment PC by 4        
        PC_plus_4( 9 DOWNTO 2 )  <= PC( 9 DOWNTO 2 ) + 1;
        PC_plus_4( 1 DOWNTO 0 )  <= "00";
        BranchPc <= Add_result               WHEN ( (( Branch = '1' ) AND ( Zero = '1' ))OR (( BNE = '1' ) AND ( Zero = '0' )) )ELSE
                    PC_plus_4( 9 DOWNTO 2 );
        
                        -- Mux to select Branch Address or PC + 4        
        Next_PC         <= X"00"                    WHEN Reset = '1' ELSE
                           read_data (9 downto 2)   WHEN INTR = '1' and INTA ='0' ELSE
                           Jump_result WHEN Jump = '1' OR Jr = '1' ELSE
                           BranchPc;
          PROCESS BEGIN
            WAIT UNTIL ( clock'EVENT ) AND ( clock = '1' );
            IF reset = '1' THEN
                   PC( 9 DOWNTO 2) <= "00000000" ; 
            ELSE 
                   PC( 9 DOWNTO 2 ) <= next_PC;
            END IF;
    END PROCESS;
END behavior;


