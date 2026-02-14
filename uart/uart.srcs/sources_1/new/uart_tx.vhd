library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    generic(clk_div_val : integer:=16;
            parity_bit : string := "none"); -- none even  or odd
            
 Port (     
        clk : in std_logic;     
        rst : in std_logic ;
         
        uart_clk_en : in std_logic; 
         uart_txd : out std_logic; 
         
         din : in std_logic_vector(7 downto 0);
         din_vld : in std_logic; 
         din_rdy  : out std_logic );
         
end uart_tx;

architecture Behavioral of uart_tx is
    signal tx_clk_en : std_logic ;
    signal tx_clk_div_clr : std_logic; 
    signal tx_data : std_logic_vector(7 downto 0);
    signal tx_bit_count :  unsigned(2 downto 0);
    signal tx_bit_count_en : std_logic ;
    signal tx_ready : std_logic; 
    signal tx_parity_bit : std_logic;  
    signal tx_data_out_sel : std_logic_vector(1 downto 0);
    
      type state is (idle, txsync, startbit, databits, paritybit, stopbit);
    signal tx_pstate : state;
    signal tx_nstate : state;

begin
     din_rdy <= tx_ready;
     
     -- uart transmitter clock divider
     
     tx_clock_divider_i : entity work.uart_clock_divider
        generic map(div_max_val => clk_div_val, div_mark_pos => 1)
        
        port map(clk => clk, rst => rst ,clear => tx_clk_div_clr, enable => uart_clk_en ,div_mark => tx_clk_en ) ;
        
   -- uart transmitter input register(parallel input to the input register)
     input_register : process(clk)
        begin 
            if(rising_edge(clk)) then 
                if(din_vld = '1' and tx_ready = '1')then
                    tx_data <= din ;
                    end if;
                 end if;  
             end process;
        
     bit_counter : process(clk)         
        begin
            if(rising_edge(clk)) then 
                if(rst = '1') then
                   tx_bit_count <= (others => '0');
                  elsif (tx_bit_count_en = '1' AND tx_clk_en = '1') then
                if (tx_bit_count = "111") then
                    tx_bit_count <= (others => '0');
                else
                    tx_bit_count <= tx_bit_count + 1;
                end if;
               end if; 
             end if ; 
          end process;
          
     parity_generator : if (parity_bit /= "none") generate 
                uart_rx_parity_gen_i : entity work.uart_parity
                    generic map(data_width=> 8 , parity_type => parity_bit )
                    port map(data_in => tx_data , parity_out => tx_parity_bit);
                end generate; 
            
      tx_output_register : process(clk)
                begin 
                    if(rising_edge(clk)) then
                        if(rst = '1') then
                            uart_txd <= '1';
                         else
                  case tx_data_out_sel is
                    when "01" => 
                        uart_txd <= '0';
                    when "10" => 
                        uart_txd <= tx_data(to_integer(tx_bit_count));
                    when "11" => 
                        uart_txd <= tx_parity_bit;
                    when others => 
                        uart_txd <= '1';
                end case;
            end if;
        end if;
    end process;


FSM: process(clk)
    begin 
        if(rising_edge(clk)) then 
            if(rst ='1') then 
                tx_pstate <= idle;
            else
                tx_pstate <= tx_nstate;
            end if;
        end if;
    end process;
    
    
 fsm_next_state : process(tx_pstate , din_vld ,tx_clk_en ,tx_bit_count)
    begin
        case tx_pstate is
            when idle =>
                tx_ready <= '1';
                tx_data_out_sel <= "00";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '1';

                if (DIN_VLD = '1') then
                    tx_nstate <= txsync;
                else
                    tx_nstate <= idle;
                end if;

         when txsync =>
                tx_ready <= '0';
                tx_data_out_sel <= "00";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '0';

                if (tx_clk_en = '1') then
                    tx_nstate <= startbit;
                else
                    tx_nstate <= txsync;
                end if;

            when startbit =>
                tx_ready <= '0';
                tx_data_out_sel <= "01";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '0';

                if (tx_clk_en = '1') then
                    tx_nstate <= databits;
                else
                    tx_nstate <= startbit;
                end if;

            when databits =>
                tx_ready <= '0';
                tx_data_out_sel <= "10";
                tx_bit_count_en <= '1';
                tx_clk_div_clr <= '0';

                if ((tx_clk_en = '1') AND (tx_bit_count = "111")) then
                    if (parity_bit = "none") then
                        tx_nstate <= stopbit;
                    else
                        tx_nstate <= paritybit;
                    end if ;
                else
                    tx_nstate <= databits;
                end if;

            when paritybit =>
                tx_ready <= '0';
                tx_data_out_sel <= "11";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '0';

                if (tx_clk_en = '1') then
                    tx_nstate <= stopbit;
                else
                    tx_nstate <= paritybit;
                end if;

            when stopbit =>
                tx_ready <= '1';
                tx_data_out_sel <= "00";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '0';

                if (DIN_VLD = '1') then
                    tx_nstate <= txsync;
                elsif (tx_clk_en = '1') then
                    tx_nstate <= idle;
                else
                    tx_nstate <= stopbit;
                end if;

            when others =>
                tx_ready <= '0';
                tx_data_out_sel <= "00";
                tx_bit_count_en <= '0';
                tx_clk_div_clr <= '0';
                tx_nstate <= idle;

        end case;
    end process;
end Behavioral;
