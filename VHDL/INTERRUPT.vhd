        -- BASIC TIMER
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY Interrupt IS
   PORT(    
    clock,irq0,irq1,irq2,irq3,irq4,irq5, INTA,GIE_enable,reset  : IN    STD_LOGIC;
    data                            : IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    GIE_ctl,IFG_store_ctl,IFG_load_ctl,IE_ctl           : IN    STD_LOGIC;
    INTR                            : OUT   STD_LOGIC;
    TYPEx                           : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 );
    out_IFG                         : OUT   STD_LOGIC_VECTOR( 31 DOWNTO 0 )
     );

END Interrupt;

ARCHITECTURE behavior OF interrupt IS

    SIGNAL  GIE             : STD_LOGIC; 
    SIGNAL  IE              : STD_LOGIC_VECTOR( 5 DOWNTO 0 );
    SIGNAL  IFG,IFG2            : STD_LOGIC_VECTOR( 5 DOWNTO 0 );


BEGIN  
    -- GIE, decides if on '1' or '0'
    PROCESS (reset, clock)
        BEGIN
            IF(reset='1') THEN
                GIE <= '0';     
            ELSIF(clock'EVENT AND clock='1') THEN
                IF GIE_ctl='1' THEN 
                    GIE <= GIE_enable; 
                END IF;
            END IF;
    END PROCESS;

   
    --IE, interrupt enable register. used to allow interrupts
    PROCESS (reset,clock)
        BEGIN
            IF(reset='1') THEN
                IE <= "000000"; 
            ELSIF(clock'EVENT AND clock='0') THEN
                IF (IE_ctl='1') THEN 
                    IE <= data(5 DOWNTO 0); 
                END IF;
            END IF;
    END PROCESS;


    --IFG, store to or load from IFG
    PROCESS (reset,clock)--,clock)
        BEGIN
            IF(reset='1') THEN
                IFG <= "000000";
            ELSIF(clock'EVENT AND clock='0') THEN -- 0 or 1?    
                IF (IFG_store_ctl ='1') THEN  -- store to
                    IFG <= data(5 DOWNTO 0);        
                ELSIF (IFG_load_ctl='1') THEN  -- load from
                    out_IFG <= X"000000" & "00" &IFG(5 downto 0);
                ELSE IFG <= IFG2;               
                END IF; 
            END IF; 
        END PROCESS;
        
        
    
    PROCESS ( GIE, irq0, irq1, irq2, irq3, irq4, irq5, reset, IFG_store_ctl, INTA, IE, clock )
        BEGIN
            IF(reset='1') THEN
                    IFG2 <= "000000";
            --ELSIF (IFG_store_ctl ='1') THEN  -- store to
            --      IFG2 <= data(3 DOWNTO 0);
            ELSIF (clock'EVENT AND clock='0') THEN
                IF (IFG_store_ctl ='1') THEN  -- store to
                    IFG2 <= data(5 DOWNTO 0);
                ELSIF (GIE = '1' AND INTA ='0') THEN
                    IF (irq0='1' AND IE(0) = '1')  THEN --Uart Rx
                        IFG2 (0) <= '1';
                    END IF; 
                    IF (irq1='1' AND IE(1) = '1')  THEN --Uart Tx
                        IFG2 (1) <= '1';
                    END IF; 
                    IF (irq2='1' AND IE(2) = '1')  THEN --BTIFG
                        IFG2 (2) <= '1';
                    END IF; 
            
                    IF (irq3 = '0' AND IE(3) = '1')  THEN --Key1
                        IFG2 (3) <= '1'; 
                    END IF; 
            
                    IF (irq4 = '0' AND IE(4) = '1') THEN --Key2
                        IFG2 (4) <= '1';
                    END IF;
            
                    IF (irq5 = '0' AND IE(5) = '1')  THEN --Key3
                        IFG2 (5) <= '1';    
                    END IF;
                END IF;
            END IF;
        END PROCESS;
        
        
    
    -- this is where the work happens. 
    PROCESS(clock, IE, IFG, GIE, INTA)
        BEGIN
            IF(clock'EVENT AND clock='1') THEN
            IF GIE = '1' AND INTA = '0'  then 
                    IF    IE(0) = '1' AND IFG (0) = '1' THEN --Uart Rx
                        TYPEx <= X"000000" & "00001000"; -- "0x08" 
                        INTR    <= '1';
                    elsif     IE(1) = '1' AND IFG (1) = '1' THEN --Uart Tx
                        TYPEx <= X"000000" & "00001100"; -- "0x0C" 
                        INTR    <= '1';
                    elsif     IE(2) = '1' AND IFG (2) = '1' THEN --BTIFG
                        TYPEx <= X"000000" & "00010000"; -- "0x10" 
                        INTR    <= '1';
                    elsif IE(3) = '1' AND   IFG(3) = '1' THEN --Key1IFG     
                        TYPEx <= X"000000" & "00010100"; -- "0x14" 
                        INTR    <= '1';
                    elsif IE(4) = '1' AND   IFG(4) = '1' THEN --Key2IFG         
                        TYPEx <= X"000000" & "00011000"; -- "0x18" 
                        INTR    <= '1';
                    elsif IE(5) = '1' AND   IFG(5) = '1' THEN --Key3IFG         
                        TYPEx <= X"000000" & "00011100"; -- "0x1C" 
                        INTR    <= '1';
                    END IF;
                ELSE INTR <= '0';   
                END IF;
            END IF;
    END PROCESS;
    
    
    
    
    
    
    
END behavior;
