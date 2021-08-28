--------------------------------------------------------------------------------
-- PROJECT: SIMPLE UART FOR FPGA
--------------------------------------------------------------------------------
-- AUTHORS: Jakub Cabal <jakubcabal@gmail.com>
-- LICENSE: The MIT License, please read LICENSE file
-- WEBSITE: https://github.com/jakubcabal/uart-for-fpga
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_PARITY is
    Generic (
        DATA_WIDTH  : integer := 8;
        PARITY_TYPE : string  := "none" -- legal values: "none", "even", "odd", "mark", "space"
    );
    Port (
        DATA_IN     : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        PARITY_MODE : in  std_logic_vector(2 downto 0);
        PARITY_OUT  : out std_logic
    );
end entity;

architecture RTL of UART_PARITY is

SIGNAL PARITY_EVEN_OUT: std_logic;
SIGNAL PARITY_ODD_OUT: std_logic;
SIGNAL PARITY_MARK_OUT: std_logic;
SIGNAL PARITY_SPACE_OUT: std_logic;

begin

    -- -------------------------------------------------------------------------
    -- PARITY BIT GENERATOR
    -- -------------------------------------------------------------------------


  -- LATER ON 
    PARITY_OUT <= PARITY_EVEN_OUT  when  (PARITY_MODE = "000") else
                  PARITY_ODD_OUT  when   (PARITY_MODE = "001")  else
                  PARITY_MARK_OUT  when  (PARITY_MODE = "010") else
                  PARITY_SPACE_OUT;
                  
                  --PARITY_SPACE_OUT   when  (PARITY_MODE = "00") else

    even_parity_g : 
        process (DATA_IN)
        	variable parity_temp : std_logic;
        begin
            parity_temp := '0';
            for i in DATA_IN'range loop
                parity_temp := parity_temp XOR DATA_IN(i);
            end loop;
            PARITY_EVEN_OUT <= parity_temp;
        end process;

    odd_parity_g : 
        process (DATA_IN)
        	variable parity_temp : std_logic;
        begin
            parity_temp := '1';
            for i in DATA_IN'range loop
                parity_temp := parity_temp XOR DATA_IN(i);
            end loop;
            PARITY_ODD_OUT <= parity_temp;
        end process;

    PARITY_MARK_OUT <= '1';

    PARITY_SPACE_OUT <= '0';
    
    

end architecture;
