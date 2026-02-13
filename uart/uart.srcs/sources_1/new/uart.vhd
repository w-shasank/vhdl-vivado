

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity uart is
   generic(
            clock_frequency : integer := 10e7;
            baud_rate : integer := 115200;
            parity_bit : string := "none";
             use_debouncer : boolean := True);
  Port ( 
    clk : in std_logic ;
    rst : in std_logic;
    
    
    -- this is the uart to uart interface
    uart_txd : out std_logic ;
    uart_rxd : in std_logic ;
    
    --user to uart interface
       din : in std_logic_vector(7 downto 0);
       din_vld : in std_logic ;
       din_rdy : out std_logic;
       
    --uart to user interface
    
    dout :out  std_logic_vector(7 downto 0);
    dout_vld : out std_logic;
    frame_error : out std_logic;
    parity_error : out std_logic 
  );
end uart;

architecture Behavioral of uart is
    constant os_divider : integer := integer(real(clock_frequency)/ real(16 * baud_rate));
    constant uart_clock_divider :integer := integer(real(clock_frequency)/real(os_divider * baud_rate));
    
    
    signal os_clock_en : std_logic;  
    signal uart_rxd_meta_n : std_logic;  
    signal uart_rxd_synced_n    : std_logic;
    signal uart_rxd_debounced_n : std_logic;
    signal uart_rxd_debounced   : std_logic;
    

begin
    
    --initializing the oversampling clock divider
        oversampling_divider : entity work.uart_clock_divider
                generic map(div_max_val => os_divider ,
                            div_mark_pos => os_divider -1) 
                      
                      port map(
                                clk => clk, rst => rst , clear =>rst , enable => '1', div_mark => os_clock_en) ;
                                
     
        uart_rxd_cdc_reg_p : process (CLK)
    begin
        if (rising_edge(CLK)) then
            uart_rxd_meta_n   <= not UART_RXD;
            uart_rxd_synced_n <= uart_rxd_meta_n;
        end if;
    end process;
    
    --uart debouncer
    debouncer_used_uart : if(use_debouncer = True) generate  
                debouncer_i : entity work.uart_debouncer
                    generic map(latency => 4)
                    port map(clk=>clk , deb_in => uart_rxd_synced_n,
                    deb_out=> uart_rxd_debounced_n);
                end generate;  
           
      debouncer_not_used_uart: if (use_debouncer = False) generate
                  uart_rxd_debounced_n <= uart_rxd_synced_n;
                 end generate;    
                 
                 
                 
  uart_rxd_debounced <= not uart_rxd_debounced_n;
  
  -- uart receriver
    rx_i : entity work.uart_rx
        generic map(clk_div_val => uart_clock_divider, parity_bit => parity_bit)
        
        port map(
                
               clk => clk,
               rst =>rst,
                
                uart_clk_en => os_clock_en,
                uart_rxd => uart_rxd_debounced,
                
                dout => dout,
                dout_vld=> dout_vld,
                frame_error=>frame_error,
                parity_error =>parity_error
                );
    
    
  --uart transmitter
    tx_i : entity work.uart_tx
         generic map(clk_div_val => uart_clock_divider, parity_bit => parity_bit)
         
         port map(
                  clk=> clk , rst=> rst , uart_clk_en => os_clock_en ,uart_txd => uart_txd , din =>din , din_vld => din_vld , din_rdy=> din_rdy);
                
end Behavioral;
