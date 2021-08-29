LIBRARY ieee;
USE ieee.std_logic_1164.all;

-------------------------------------
ENTITY IO_top IS
  GENERIC (BUS_W : INTEGER := 8); -- QUARTUS MODE = 12; | MODELSIM = 8;
  PORT (    datain : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			address : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            pushButtons: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            GIE_ctl,INTA           : IN std_logic;
            INTR                   : OUT std_logic;
            TYPEx                  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			clk, reset, MemRead, MemWrite: IN std_logic;
			LEDG, LEDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			HEX0, HEX1, HEX2, HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            UART_TXD : OUT STD_LOGIC;
            UART_RXD : IN STD_LOGIC;
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
    GENERIC (BUS_W : INTEGER := 8); -- QUARTUS MODE = 12; | MODELSIM = 8;
	PORT (Address : IN STD_LOGIC_VECTOR (BUS_W-1 DOWNTO 0);
		  CS: OUT STD_LOGIC_VECTOR(15 downto 0));
    END component;
    
    COMPONENT timer 
		 PORT( 	clock,reset					: IN 	STD_LOGIC;
				data						: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				BTCTL_ctl, BTCNT_ctl 		: IN 	STD_LOGIC;
				BTIFG_OUT 		 				: OUT 	STD_LOGIC
			);
	END COMPONENT;
    COMPONENT Interrupt IS
       PORT( 	
            clock,irq0,irq1,irq2,irq3,irq4,irq5,INTA,GIE_enable,reset	: IN 	STD_LOGIC;
            data							                : IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            GIE_ctl,IFG_store_ctl,IFG_load_ctl,IE_ctl       : IN 	STD_LOGIC;
            Rx_read                                         : IN STD_LOGIC;
            Tx_Write                                        : IN STD_LOGIC;
            INTR							                : OUT 	STD_LOGIC;
            TYPEx 		 					                : OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
            out_IFG							                : OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 )
         );
    END COMPONENT;
    component UART is
    Generic (
        CLK_FREQ      : integer := 50e6;   -- system clock frequency in Hz
        BAUD_RATE     : integer := 115200; -- baud rate value
        USE_DEBOUNCER : boolean := True    -- enable/disable debouncer
    );
    Port (
        -- CLOCK AND RESET
        CLK          : in  std_logic; -- system clock
        RST          : in  std_logic; -- high active synchronous reset
		  --BAUD_RATE    : in std_logic_vector(16 downto 0);
		  
		  -- Parity Mode: "Even" - 000, "Odd" - 001, "Mark" - 010, "space" - 011 None - 100
        PARITY_MODE: in std_logic_vector(2 downto 0);
        -- UART INTERFACE
        UART_TXD     : out std_logic; -- serial transmit data
        UART_RXD     : in  std_logic; -- serial receive data
        -- USER DATA INPUT INTERFACE
        DIN          : in  std_logic_vector(7 downto 0); -- input data to be transmitted over UART
        DIN_VLD      : in  std_logic; -- when DIN_VLD = 1, input data (DIN) are valid
        DIN_RDY      : out std_logic; -- when DIN_RDY = 1, transmitter is ready and valid input data will be accepted for transmiting
        -- USER DATA OUTPUT INTERFACE
        DOUT         : out std_logic_vector(7 downto 0); -- output data received via UART
        DOUT_VLD     : out std_logic; -- when DOUT_VLD = 1, output data (DOUT) are valid (is assert only for one clock cycle)
        FRAME_ERROR  : out std_logic; -- when FRAME_ERROR = 1, stop bit was invalid (is assert only for one clock cycle)
        PARITY_ERROR : out std_logic  -- when PARITY_ERROR = 1, parity bit was invalid (is assert only for one clock cycle)
    );
    end component;
	-----------------------------------------------------------
    --------------------------------------------------------------
	SIGNAL Out_UCTL,Out_Rx,Out_Tx,out_IFG,Out_Buttons, Out_SW, Out_LEDG, Out_LEDR, Out_HEX0, Out_HEX1, Out_HEX2, Out_HEX3 : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL CS : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL pushButtonsInput : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL disp_LEDG,disp_LEDR : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL disp_HEX0,disp_HEX1,disp_HEX2,disp_HEX3 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL BTIFG: STD_LOGIC;
    SIGNAL TODO_not_connected_yet    : STD_LOGIC;
    SIGNAL ifg_write, ifg_read       : STD_LOGIC;
    SIGNAL write_clock               : STD_LOGIC;
    SIGNAL UCTL                      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL software_reset_en, parity_enable,parity_select,baud_rate : STD_LOGIC;
    SIGNAL frame_error, parity_error, overrun_error,BUSY            : STD_LOGIC;
    SIGNAL parity_mode : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL rx_read,tx_write          : STD_LOGIC;
    SIGNAL rx_buffer, tx_buffer      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL tx_valid                  : STD_LOGIC;
    SIGNAL tx_ready                  : STD_LOGIC;
    SIGNAL rx_valid                  : STD_LOGIC;
    SIGNAL rx_full                   : STD_LOGIC;
    SIGNAL tx_empty                  : STD_LOGIC;
    
begin
    write_clock <= NOT clk;

    ifg_read  <= CS(14) AND MemRead;
    ifg_write <= CS(14) AND MemWrite;
	
	dataout <= 
			   Out_LEDG WHEN CS(0) = '1' ELSE
			   Out_LEDR WHEN CS(1) = '1' ELSE
			   Out_HEX0 WHEN CS(2) = '1' ELSE
			   Out_HEX1 WHEN CS(3) = '1' ELSE
			   Out_HEX2 WHEN CS(4) = '1' ELSE
			   Out_HEX3 WHEN CS(5) = '1' ELSE
               Out_SW   WHEN CS(6) = '1' ELSE
 			   Out_Buttons WHEN CS(7) = '1' ELSE
               Out_UCTL    WHEN CS(8) = '1' ELSE
               Out_Rx      WHEN CS(9) = '1' ELSE
               Out_Tx      WHEN CS(10) = '1' ELSE
               out_IFG  WHEN CS(14) = '1' ELSE
               
			   X"00000000";
	 pushButtonsInput<="0000" & pushButtons & "0";
	B1 : Decoder generic map(12) port map(address, CS);
    
	B2 : IO_ReadOnly port map(SW,MemRead,CS(6),Out_SW);
 
	PushButtons_comp : IO_ReadOnly port map(pushButtonsInput,MemRead,CS(7),Out_Buttons);

    
    -- LEDS
	B3 : IO_Biderctional generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(0),write_clock,Out_LEDG,disp_LEDG);
	B4 : IO_Biderctional generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(1),write_clock,Out_LEDR,disp_LEDR);
    LEDG<=disp_LEDG;
	LEDR<=disp_LEDR;
    
    -- HEX LCD
	B5 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(2),write_clock,Out_HEX0,disp_HEX0);
	B6 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(3),write_clock,Out_HEX1,disp_HEX1);
	B7 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(4),write_clock,Out_HEX2,disp_HEX2);
	B8 : IO_Biderctional generic map(4) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(5),write_clock,Out_HEX3,disp_HEX3);
    
    -- Hex Signal Generators
    H0 : HexGen port map(HexIn=>disp_HEX0,HexOut=>HEX0);
	H1 : HexGen port map(disp_HEX1,HEX1);
	H2 : HexGen port map(disp_HEX2,HEX2);
	H3 : HexGen port map(disp_HEX3,HEX3);
    
    -- Basic Timer
	BT : timer
	PORT MAP (clock => write_clock, reset => reset, data=> datain,
				BTCTL_ctl => CS(11), BTCNT_ctl => CS(12),
				BTIFG_OUT => BTIFG
  );
    
  INTRPT: interrupt PORT MAP (  
        clock			=> clk,
        irq0			=> rx_full, 
        irq1			=> tx_empty, 
        irq2			=> BTIFG, 
        irq3			=> pushButtons(0),
        irq4			=> pushButtons(1),
        irq5			=> pushButtons(2),
        INTA			=> INTA,
        GIE_enable		=> address(0),
        reset			=> reset,
        data			=> datain,
        GIE_ctl			=> GIE_ctl,
        IFG_store_ctl	=> ifg_write,
        IFG_load_ctl	=> ifg_read,
        IE_ctl			=> CS(13),
        Rx_read         => rx_read,
        Tx_Write        => tx_write,
        INTR			=> INTR,
        TYPEx			=> TYPEx,
        out_IFG			=> out_IFG
    );	              
    RxD_Reg : IO_ReadOnly port map(rx_buffer,MemRead,CS(9),Out_Rx);
    --RxD_Reg : IO_ReadOnly generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(9),write_clock,Out_Rx);
    TxD_Reg : IO_Biderctional generic map(8) port map(datain(7 DOWNTO 0),MemRead,MemWrite,CS(10),write_clock,Out_Tx);
    
    rx_read  <= '1' WHEN (CS(9) = '1') AND (MemRead = '1') ELSE '0';
    tx_write <= '1' WHEN (CS(10) = '1') AND (MemWrite = '1') ELSE '0';
    
    -- UCTL Reg  Proccess
    process (clk) begin
        IF (clk'EVENT and clk='1') THEN
            
            -- CPU to UCTL
            IF (MemWrite='1' AND CS(8) = '1') THEN
                UCTL(3 downto 0) <= datain(3 downto 0);
                IF (parity_enable = '1') THEN
                    IF (parity_select = '1') THEN
                        parity_mode <= "001"; -- Odd
                    ELSE
                        parity_mode <= "000"; -- Even
                    END IF;
                ELSE
                    parity_mode <= "100"; -- None
                END IF;
            END IF;
            
            -- Uart to UCTL
            UCTL(4) <= frame_error;
            UCTL(5) <= parity_error;
            UCTL(6) <= overrun_error;
            UCTL(7) <= BUSY;
        END IF;
    end process;
    
    Out_UCTL <= X"000000" & UCTL;
    software_reset_en <= datain(0);
    parity_enable     <= datain(1);
    parity_select     <= datain(2);
    baud_rate         <= datain(3);
    
    -- tx_empty
    process (clk) begin
        IF (clk'EVENT and clk='1') THEN
            IF (MemWrite='1' AND CS(10) = '1') THEN
                tx_empty <= '0';
            ELSIF (tx_ready = '1') THEN
                tx_empty <= '1';
            ELSE
                tx_empty <= '0';
            END IF;
        END IF;
    end process;
    
    -- rx_full
    process (clk) begin
        IF (clk'EVENT and clk='1') THEN
            IF (MemRead='1' AND CS(9) = '1') THEN
                rx_full <= '0';
            ELSIF (rx_valid = '1') THEN
                rx_full <= '1';
            ELSE
                rx_full <= '0';
            END IF;
        END IF;
    end process;
    
    UART_controller : UART
    Generic map(
        CLK_FREQ      => 24e6,   -- system clock frequency in Hz
        BAUD_RATE     => 115200,
        USE_DEBOUNCER => True    -- enable/disable debouncer
    )
    Port map(
        -- CLOCK AND RESET
        CLK       => clk, -- system clock
        RST       => reset, -- high active synchronous reset
		--BAUD_RATE => UCTL(3),
		  -- Parity Mode: "Even" - 000, "Odd" - 001, "Mark" - 010, "space" - 011 None - 100
        PARITY_MODE =>parity_mode,
        -- UART INTERFACE
        UART_TXD     => UART_TXD, -- serial transmit data
        UART_RXD     => UART_RXD, -- serial receive data
        -- USER DATA INPUT INTERFACE
        DIN          => Out_Tx(7 DOWNTO 0), -- input data to be transmitted over UART
        DIN_VLD      => tx_valid, -- when DIN_VLD = 1, input data (DIN) are valid
        DIN_RDY      => tx_ready, -- when DIN_RDY = 1, transmitter is ready and valid input data will be accepted for transmiting
        -- USER DATA OUTPUT INTERFACE
        DOUT         => rx_buffer, -- output data received via UART
        DOUT_VLD     => rx_valid, -- when DOUT_VLD = 1, output data (DOUT) are valid (is assert only for one clock cycle)
        FRAME_ERROR  => frame_error, -- when FRAME_ERROR = 1, stop bit was invalid (is assert only for one clock cycle)
        PARITY_ERROR => parity_error  -- when PARITY_ERROR = 1, parity bit was invalid (is assert only for one clock cycle)
    );    
    
END dfl;

