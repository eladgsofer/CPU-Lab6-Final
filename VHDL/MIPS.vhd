                -- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MIPS IS
    GENERIC (BUS_W : INTEGER := 12; ADD_BUS: INTEGER :=10; QUARTUS : INTEGER := 1); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
        --GENERIC (BUS_W : INTEGER := 8; ADD_BUS: INTEGER :=8; QUARTUS : INTEGER := 0); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
    PORT( reset, clock                  : IN    STD_LOGIC; 
        -- Output important signals to pins for easy display in Simulator
        PC                              : OUT STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        ALU_result_out, read_data_1_out : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        read_data_2_out, write_data_out : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Instruction_out                 : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Branch_out, Zero_out            : OUT STD_LOGIC;
        Memwrite_out,Regwrite_out       : OUT STD_LOGIC;
        LEDG, LEDR                      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3          : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        SW                              : IN  STD_LOGIC_VECTOR (7 DOWNTO 0));
END     MIPS;

ARCHITECTURE structure OF MIPS IS

    COMPONENT Ifetch
         GENERIC (BUS_W : INTEGER := 12; ADD_BUS: INTEGER :=10; QUARTUS : INTEGER := 1); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
         PORT(  Instruction         : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                PC_plus_4_out       : OUT   STD_LOGIC_VECTOR( 9 DOWNTO 0 );
                Add_result          : IN    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
                Jump_Result         : IN    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
                Branch              : IN    STD_LOGIC;
                BNE                 : IN    STD_LOGIC;
                Jump                : IN    STD_LOGIC;
                Jr                  : IN    STD_LOGIC;
                Zero                : IN    STD_LOGIC;
                PC_out              : OUT   STD_LOGIC_VECTOR( 9 DOWNTO 0 );
                clock,reset         : IN    STD_LOGIC );
    END COMPONENT; 

    COMPONENT Idecode
         PORT(  read_data_1         : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                read_data_2         : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Instruction         : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                read_data           : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                ALU_result          : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                PC_plus_4           : IN    STD_LOGIC_VECTOR( 9  DOWNTO 0 );
                RegWrite            : IN    STD_LOGIC;
                MemtoReg            : IN    STD_LOGIC_VECTOR( 1  DOWNTO 0 );
                RegDst              : IN    STD_LOGIC_VECTOR( 1  DOWNTO 0 );
                Sign_extend         : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                clock, reset        : IN    STD_LOGIC );
    END COMPONENT;

    COMPONENT control
         PORT(  Opcode              : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0 );
                RegDst              : OUT   STD_LOGIC_VECTOR( 1 DOWNTO 0 );
                ALUSrc              : OUT   STD_LOGIC;
                MemtoReg            : OUT   STD_LOGIC_VECTOR( 1 DOWNTO 0 );
                RegWrite            : OUT   STD_LOGIC;
                MemRead             : OUT   STD_LOGIC;
                MemWrite            : OUT   STD_LOGIC;
                Branch              : OUT   STD_LOGIC;
                BNE                 : OUT   STD_LOGIC;
                Jump                : OUT   STD_LOGIC;
                Jr                  : IN    STD_LOGIC;
                ALUop               : OUT   STD_LOGIC_VECTOR( 2 DOWNTO 0 );
                clock, reset        : IN    STD_LOGIC );
    END COMPONENT;

    COMPONENT  Execute
         PORT(  Read_data_1         : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Read_data_2         : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Sign_Extend         : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Function_opcode     : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0 );
                Shamt               : IN    STD_LOGIC_VECTOR( 4 DOWNTO 0 );
                ALUOp               : IN    STD_LOGIC_VECTOR( 2 DOWNTO 0 );
                ALUSrc              : IN    STD_LOGIC;
                Jr                  : OUT   STD_LOGIC;
                Zero                : OUT   STD_LOGIC;
                ALU_Result          : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Add_Result          : OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0 );
                Jump_Result         : OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0 );
                PC_plus_4           : IN    STD_LOGIC_VECTOR( 9 DOWNTO 0 );
                clock, reset        : IN    STD_LOGIC );
    END COMPONENT;


COMPONENT dmemory IS
    GENERIC (BUS_W : INTEGER := 8; ADD_BUS: INTEGER :=8); -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
    PORT(   read_data           : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            address             : IN    STD_LOGIC_VECTOR( BUS_W-1 DOWNTO 0 );
            write_data          : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            MemRead, Memwrite   : IN    STD_LOGIC;
            clock,reset         : IN    STD_LOGIC;
            SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            LEDG, LEDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END COMPONENT;

                    -- declare signals used to connect VHDL components
    SIGNAL PC_plus_4        : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
    SIGNAL read_data_1      : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL read_data_2      : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL Sign_Extend      : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL Add_result       : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
    SIGNAL Jump_result      : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
    SIGNAL ALU_result       : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL read_data        : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL ALUSrc           : STD_LOGIC;
    SIGNAL Branch           : STD_LOGIC;
    SIGNAL BNE              : STD_LOGIC;
    SIGNAL Jump             : STD_LOGIC;
    SIGNAL Jr               : STD_LOGIC;
    SIGNAL RegDst           : STD_LOGIC_VECTOR( 1 DOWNTO 0 );
    SIGNAL Regwrite         : STD_LOGIC;
    SIGNAL Zero             : STD_LOGIC;
    SIGNAL MemWrite         : STD_LOGIC;
    SIGNAL MemtoReg         : STD_LOGIC_VECTOR( 1 DOWNTO 0 );
    SIGNAL MemRead          : STD_LOGIC;
    SIGNAL ALUop            : STD_LOGIC_VECTOR(  2 DOWNTO 0 );
    SIGNAL Instruction      : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    SIGNAL addressQuartus   : STD_LOGIC_VECTOR( BUS_W-1 DOWNTO 0 );
    SIGNAL resetSync        : STD_LOGIC;
    --SIGNAL Switches         : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
BEGIN
                    -- copy important signals to output pins for easy 
                    -- display in Simulator
   Instruction_out  <= Instruction;
   ALU_result_out   <= ALU_result;
   read_data_1_out  <= read_data_1;
   read_data_2_out  <= read_data_2;
   write_data_out   <= read_data                    WHEN MemtoReg = "01" ELSE 
                       X"00000" & B"00" & PC_plus_4 WHEN MemtoReg = "10" ELSE
                       ALU_result;
   Branch_out       <= Branch;
   Zero_out         <= Zero;
   RegWrite_out     <= RegWrite;
   MemWrite_out     <= MemWrite;    
   addressQuartus   <= ALU_Result(BUS_W-1 DOWNTO 2) & "00"; 
   --Switches         <= SW & reset;
 --address          <= ALU_Result(11 DOWNTO 2) & "00"; 
 
                    -- connect the 5 MIPS components   
  IFE : Ifetch
    GENERIC MAP(BUS_W => BUS_W, 
                ADD_BUS => ADD_BUS,
                QUARTUS => QUARTUS) -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
    PORT MAP (  Instruction     => Instruction,
                PC_plus_4_out   => PC_plus_4,
                Add_result      => Add_result,
                Jump_Result     => Jump_Result,
                Branch          => Branch,
                BNE             => BNE,
                Jump            => Jump,
                Jr              => Jr,
                Zero            => Zero,
                PC_out          => PC,              
                clock           => clock,  
                reset           => resetSync );

   ID : Idecode
    PORT MAP (  read_data_1     => read_data_1,
                read_data_2     => read_data_2,
                Instruction     => Instruction,
                read_data       => read_data,
                ALU_result      => ALU_result,
                PC_plus_4       => PC_plus_4,
                RegWrite        => RegWrite,
                MemtoReg        => MemtoReg,
                RegDst          => RegDst,
                Sign_extend     => Sign_extend,
                clock           => clock,  
                reset           => resetSync );


   CTL:   control
    PORT MAP (  Opcode          => Instruction( 31 DOWNTO 26 ),
                RegDst          => RegDst,
                ALUSrc          => ALUSrc,
                MemtoReg        => MemtoReg,
                RegWrite        => RegWrite,
                MemRead         => MemRead,
                MemWrite        => MemWrite,
                Branch          => Branch,
                BNE             => BNE,
                Jump            => Jump,
                Jr              => Jr,
                ALUop           => ALUop,
                clock           => clock,
                reset           => resetSync );

   EXE:  Execute
    PORT MAP (  Read_data_1     => read_data_1,
                Read_data_2     => read_data_2,
                Sign_extend     => Sign_extend,
                Function_opcode => Instruction( 5 DOWNTO 0 ),
                Shamt           => Instruction( 10 DOWNTO 6 ),
                ALUOp           => ALUop,
                ALUSrc          => ALUSrc,
                Jr              => Jr,
                Zero            => Zero,
                ALU_Result      => ALU_Result,
                Add_Result      => Add_Result,
                Jump_Result     => Jump_Result,
                PC_plus_4       => PC_plus_4,
                Clock           => clock,
                Reset           => resetSync );
   QUARTUS_MEM : IF QUARTUS = 1 GENERATE
       MEM:  dmemory
        GENERIC MAP(BUS_W => BUS_W, 
                    ADD_BUS => ADD_BUS) -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
        PORT MAP (  read_data       => read_data,
                    address         => addressQuartus, --jump memory address by 4
                    write_data      => read_data_2,
                    MemRead         => MemRead, 
                    Memwrite        => MemWrite, 
                    clock           => clock,  
                    reset           => resetSync,
                    SW => SW,
                    LEDG => LEDG,
                    LEDR=> LEDR,
                    HEX0 => HEX0,
                    HEX1 => HEX1,
                    HEX2 => HEX2,
                    HEX3 => HEX3);
    END GENERATE;
    
    MODELSIM_MEM : IF QUARTUS = 0 GENERATE
        MEM:  dmemory
        GENERIC MAP(BUS_W => BUS_W, 
                    ADD_BUS => ADD_BUS) -- QUARTUS MODE = 12; 10 | MODELSIM = 8; 8
        PORT MAP (  read_data       => read_data,
                    address         => ALU_Result (BUS_W+1 DOWNTO 2), --jump memory address by 4
                    write_data      => read_data_2,
                    MemRead         => MemRead, 
                    Memwrite        => MemWrite, 
                    clock           => clock,  
                    reset           => resetSync,
                    SW => SW,
                    LEDG => LEDG,
                    LEDR=> LEDR,
                    HEX0 => HEX0,
                    HEX1 => HEX1,
                    HEX2 => HEX2,
                    HEX3 => HEX3);
    END GENERATE;
    PROCESS (clock)BEGIN
        if(rising_edge(Clock)) then
            resetSync <= not reset; 
        end if;   
    END PROCESS;
END structure;

