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
    SIGNAL  SERVICED            : STD_LOGIC_VECTOR(2 DOWNTO 0); -- FOR AUTOMATICALLY IFG TURNOFF
    -- 0 waiting for intr = 1
    -- 1 waiting for inta = 1
    -- 2 waiting for inta = 0
    type InterruptState is (WaitIntr, WaitInta, WaitIntaDown, CleanIFG);
    SIGNAL CLEARED : STD_LOGIC;
    SIGNAL CLEARED2 : STD_LOGIC;
    SIGNAL  Inta_state : InterruptState;
    SIGNAL  next_inta_state : InterruptState;
    SIGNAL  INTR_REG   : STD_LOGIC;
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
    state_machine : process(clock, reset)
    begin

        if (reset='1') then
                Inta_state <= WaitIntr;
        elsif (clock'event and clock='1') then
            Inta_state <= next_inta_state;
        end if;
    end process;
    --Mark the falling edge of INTA
    PROCESS (Inta_state,INTA,INTR_REG)BEGIN
        case Inta_state is
            
            when WaitIntr =>
                IF (INTR_REG = '1') THEN
                    next_inta_state <= WaitInta;
                END IF;
                
            when WaitInta =>
                IF (INTA = '1') THEN
                    next_inta_state <= WaitIntaDown;
                END IF;
            when WaitIntaDown =>
                IF (INTA = '1') THEN
                    next_inta_state <= CleanIFG;
                END IF;
            when CleanIFG =>
                IF (CLEARED = '1' AND CLEARED2 = '1') THEN
                    next_inta_state <= WaitIntr;
                END IF;
        end case;
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
                -- Automatically turn off the IFG when an interrupt finished it's ISR    
                ELSIF (Inta_state = CleanIFG) THEN
                    CLEARED <= '1';
                    IF (SERVICED(0)='1') THEN 
                        IFG(0) <= '0';
                    ELSIF (SERVICED(1)='1') THEN 
                        IFG(1) <= '0';                    
                    ELSE 
                        IFG(2) <= '0';
                    END IF;
                
                ELSE 
                    CLEARED<='0';
                    IFG <= IFG2;
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
                -- Automatically turn off the IFG when an interrupt finished it's ISR    
                ELSIF (Inta_state = CleanIFG) THEN
                    CLEARED2 <= '1';
                    IF (SERVICED(0)='1') THEN 
                        IFG2(0) <= '0';
                    ELSIF (SERVICED(1)='1') THEN 
                        IFG2(1) <= '0';                    
                    ELSE 
                        IFG2(2) <= '0';
                    END IF;
                ELSIF (GIE = '1' AND INTA ='0') THEN
                    CLEARED2 <= '0';
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
        
        
    INTR <= INTR_REG;
    -- this is where the work happens. 
    PROCESS(clock, IE, IFG, GIE, INTA)
        BEGIN
            IF(clock'EVENT AND clock='1') THEN
            IF GIE = '1' AND INTA = '0'  then 
                    IF    IE(0) = '1' AND IFG (0) = '1' THEN --Uart Rx
                        TYPEx <= X"000000" & "00001000"; -- "0x08" 
                        INTR_REG    <= '1';
                        SERVICED <= "001";
                    elsif     IE(1) = '1' AND IFG (1) = '1' THEN --Uart Tx
                        TYPEx <= X"000000" & "00001100"; -- "0x0C" 
                        INTR_REG    <= '1';
                        SERVICED <= "010";
                    elsif     IE(2) = '1' AND IFG (2) = '1' THEN --BTIFG
                        TYPEx <= X"000000" & "00010000"; -- "0x10" 
                        INTR_REG    <= '1';
                        SERVICED <= "100";
                    elsif IE(3) = '1' AND   IFG(3) = '1' THEN --Key1IFG     
                        TYPEx <= X"000000" & "00010100"; -- "0x14" 
                        INTR_REG    <= '1';
                    elsif IE(4) = '1' AND   IFG(4) = '1' THEN --Key2IFG         
                        TYPEx <= X"000000" & "00011000"; -- "0x18" 
                        INTR_REG    <= '1';
                    elsif IE(5) = '1' AND   IFG(5) = '1' THEN --Key3IFG         
                        TYPEx <= X"000000" & "00011100"; -- "0x1C" 
                        INTR_REG    <= '1';
                    END IF;
                ELSE INTR_REG <= '0';   
                END IF;
            END IF;
    END PROCESS;
    
    
    
    
    
    
    
END behavior;
