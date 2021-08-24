--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;


ENTITY  Execute IS
    PORT(   Read_data_1     : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            Read_data_2     : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            Sign_extend     : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            Shamt           : IN    STD_LOGIC_VECTOR( 4 DOWNTO 0 );
            Function_opcode : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0 );
            ALUOp           : IN    STD_LOGIC_VECTOR( 2 DOWNTO 0 );
            ALUSrc          : IN    STD_LOGIC;
            Jr              : OUT   STD_LOGIC;
            Zero            : OUT   STD_LOGIC;
            ALU_Result      : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            Add_Result      : OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            Jump_Result     : OUT   STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            PC_plus_4       : IN    STD_LOGIC_VECTOR( 9 DOWNTO 0 );
            clock, reset    : IN    STD_LOGIC );
END Execute;


ARCHITECTURE behavior OF Execute IS
--------------------------------------------------------
component Shifter IS
    GENERIC (n : INTEGER := 32;
             k : INTEGER := 5;   -- k=log2(n)
             m : INTEGER := 16   ); -- m=2^(k-1)
    PORT (ALUFN            :IN  STD_LOGIC;
          X                :IN  STD_LOGIC_VECTOR(4 downto 0);
          Y                :IN  STD_LOGIC_VECTOR(n-1 downto 0);
          output           :BUFFER STD_LOGIC_VECTOR(n-1 downto 0);
          cflag:OUT STD_LOGIC);
END component;
--------------------------------------------------------
TYPE   ALU_CMDS IS (ANDCMD,ORCMD,ADDCMD, ADDUCMD, SUBCMD,XORCMD,MULCMD,SLLCMD,SRLCMD,SLTCMD);
SIGNAL Ainput, Binput       : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux       : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add           : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL mult64               : STD_LOGIC_VECTOR( 63 DOWNTO 0 );
SIGNAL ALU_ctl              : ALU_CMDS;
SIGNAL JR_Sig               : STD_LOGIC;
SIGNAL Function_translation : STD_LOGIC_VECTOR( 5 DOWNTO 0 );
BEGIN
    Ainput <= Read_data_1;
                        -- ALU input mux
    Binput <= Read_data_2 
        WHEN ( ALUSrc = '0' ) 
        ELSE  Sign_extend( 31 DOWNTO 0 );
        
    
    -- AluOp 00 - lw/sw || ALUOP 01 - Beq || ALUOP 10 - Rtype 
    -- ALU_CTRL = command to ALU 
    -- 010
    -- 101
    -- OP = 00 -> ALUT_CTRL = 010
    -- OP = 01 -> 110

    --XOR op 00 func 100110
                        -- Generate ALU control bits
    --ALU_ctl( 0 ) <= ( Function_opcode( 0 ) OR Function_opcode( 3 ) ) AND ALUOp(1 );
    --ALU_ctl( 1 ) <= ( NOT Function_opcode( 2 ) ) OR (NOT ALUOp( 1 ) );
    --ALU_ctl( 2 ) <= ( Function_opcode( 1 ) AND ALUOp( 1 )) OR ALUOp( 0 );
    --Function_translation <= "101111" when Function_opcode = "001000" ELSE -- TODO:  JR CHANGE OPCODE
    --                        "000111" when Function_opcode = "000010" ELSE -- TODO:  SRL CHANGE OPCODE
    --                        Function_opcode;                              -- all other commands
-- ALUOP to function:
-- 000 : add    - LUI,ADDI
-- 001 : sub    - SLTI,BEQ,BNQ
-- 010 : xor    - XORI
-- 011 : or     - ORI 
-- 100 : and    - ANDI
-- 101 : mul    - MUL
-- 111 : R-type - R-type
  --ALU_ctl <= Function_translation when ALUOp = "00000"  else ALUOp;
    ALU_ctl <= ADDCMD  when  ((Function_opcode = "100000" AND ALUOp = "111") OR ALUOp = "000")  else                               -- ADD,ADDI,LUI
               SUBCMD  when ((Function_opcode = "100010"  AND ALUOp = "111") OR ALUOp = "001")  else -- SUB,BNE,BNEQ,SLTI
               XORCMD  when  ((Function_opcode = "100110" AND ALUOp = "111") OR ALUOp = "010" ) else                               -- XORI,XOR
               ORCMD   when  ((Function_opcode = "100101" AND ALUOp = "111") OR ALUOp = "011" ) else                              -- ORI,OR
               ANDCMD  when  ((Function_opcode = "100100" AND ALUOp = "111") OR ALUOp = "100" ) else                               -- ANDI,AND
               SLLCMD  when (Function_opcode = "000000" AND ALUOp = "111") else                                                    -- SLL
               SRLCMD  when (Function_opcode = "000010" AND ALUOp = "111") else                                                    -- SRL
               MULCMD  when (Function_opcode   = "000010" AND ALUOp = "101")  else                                                 -- MUL
               SLTCMD  when (Function_opcode   = "101010" AND ALUOp = "111") OR ALUOp = "110"  else  
               ADDUCMD when (Function_opcode = "100001" AND ALUOp = "111") else                                                   --ADU
               ADDCMD; -- JUMPS AND SO ON can do add
    
                        -- Generate Zero Flag
    Zero <= '1' WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000") ELSE '0';    
                        -- Select ALU output
    --ALU_result <= ALU_output_mux(31 DOWNTO 0);
    ALU_result <= X"0000000" & B"000"  & ALU_output_mux( 31 ) 
        WHEN  ALU_ctl = SLTCMD  -- 
        ELSE    ALU_output_mux( 31 DOWNTO 0 );
                        -- Adder to compute Branch Address
    Branch_Add  <= PC_plus_4( 9 DOWNTO 2 ) +  Sign_extend( 7 DOWNTO 0 ) ;
        Add_result  <= Branch_Add( 7 DOWNTO 0 );
    Jr_Sig <= '1' when Function_opcode = "001000" AND ALUOP = "111" ELSE '0';
    Jr <= Jr_Sig;
    Jump_Result <= Ainput(9 DOWNTO 2) WHEN Jr_Sig = '1' ELSE
                   Sign_extend( 7 DOWNTO 0 );
    
    mult64 <= Ainput*Binput;

PROCESS ( ALU_ctl, Ainput, Binput, mult64)
    BEGIN
                    -- Select ALU operation
    CASE ALU_ctl IS
    ------------------ Arithmetic Instructions
        WHEN ANDCMD =>  ALU_output_mux  <= Ainput AND Binput; 
                        -- ALU performs ALUresult = A_input OR B_input
        WHEN ORCMD  =>  ALU_output_mux  <= Ainput OR Binput;
                        -- ALU performs ALUresult = A_input + B_input
        WHEN ADDCMD =>  ALU_output_mux  <= Ainput + Binput;
                        -- ALU performs sll
        WHEN SLLCMD =>  ALU_output_mux  <= To_StdLogicVector(to_bitvector (Binput) sll CONV_INTEGER((Shamt)));
                        -- ALU performs srl
        WHEN SRLCMD =>  ALU_output_mux  <= To_StdLogicVector(to_bitvector (Binput) srl CONV_INTEGER((Shamt)));
                        -- ALU performs ALUresult = A_input XOR B_input 
        WHEN XORCMD =>  ALU_output_mux  <= Ainput XOR Binput;
                        -- ALU performs ALUresult = A_input -B_input
        WHEN SUBCMD =>  ALU_output_mux  <= Ainput - Binput;
                        -- ALU performs MUL
        WHEN MULCMD =>  ALU_output_mux  <= mult64(31 DOWNTO 0);
        
        WHEN SLTCMD =>  ALU_output_mux  <= Ainput - Binput;
        
        WHEN ADDUCMD => ALU_output_mux  <= Binput;
        
        WHEN OTHERS     =>  ALU_output_mux  <= X"00000000" ;        

        -- -- add
        -- WHEN "100000"    =>  ALU_output_mux  <= Ainput + Binput; 
                        -- -- subtract
        -- WHEN "100010"    =>  ALU_output_mux  <= Ainput - Binput;
                        -- -- add immediate
        -- WHEN "001000"    =>  ALU_output_mux  <= Ainput + Binput;
                        -- -- Multiply (without overflow)
        -- WHEN "011100"    =>  ALU_output_mux <= X"00000000";                
    -- ------------------ Logical Instructions
                        -- -- and
        -- WHEN "100100"    =>  ALU_output_mux <= Ainput AND Binput; 
                        -- -- or
        -- WHEN "100101"    =>  ALU_output_mux  <= Ainput OR Binput; 
                        -- -- xor
        -- WHEN "100110"    =>  ALU_output_mux  <= Ainput XOR Binput; 
                        -- -- andi
        -- WHEN "001100"    =>  ALU_output_mux <= Ainput AND Binput; 
                        -- -- ori
        -- WHEN "001101"    =>  ALU_output_mux <= Ainput OR Binput; 
                        -- -- xori
        -- WHEN "001110"    =>  ALU_output_mux <= Ainput XOR Binput; 
                        -- -- shift left logical
        -- WHEN "000000"    =>  ALU_output_mux <= X"00000000";
                        -- -- shift right logical translation from 000010 -> 000111
        -- WHEN "000111"   => ALU_output_mux <= X"00000000"; 

        
    -- ------------------Data Transfer Instructions
                        -- -- lw
        -- WHEN "100011"    =>  ALU_output_mux  <= Ainput + Binput;
                        -- -- sw
        -- WHEN "101011"    =>  ALU_output_mux <= X"00000000";
                        -- -- lui Load constant into upper 16 bits. Lower 16 bits are set to zero.
        -- WHEN "001111"    =>  ALU_output_mux <= X"00000000";
        -- -- MOVE - addu opcode - Rtype,  with $0
        -- WHEN "100001"    =>  ALU_output_mux <= X"00000000";
        
    -- ------------------ Conditional Branch Instructions
                            -- -- beq
        -- WHEN "000100"    =>  ALU_output_mux <= X"00000000";
                            -- -- bneq
        -- WHEN "000101"    =>  ALU_output_mux <= X"00000000";

    -- ------------------ Comparsion Instructions
                        -- -- set on less then
        -- WHEN "101010"    =>  ALU_output_mux <= X"00000000";
                        -- -- set on less then immediate 
        -- WHEN "001010"    =>  ALU_output_mux <= X"00000000";
    -- ------------------ Unconditional Jump Instructions
                            -- -- jump
        -- WHEN "000010"    =>  ALU_output_mux <= X"00000000";
                            -- -- jump register translation from 001000 -> 101111
        -- WHEN "101111"    =>  ALU_output_mux <= X"00000000";
                            -- -- jump and link
        -- WHEN "000011"    =>  ALU_output_mux <= X"00000000";
        
        -- WHEN OTHERS  =>  ALU_output_mux  <= X"00000000" ;
    END CASE;
  END PROCESS;
END behavior;

