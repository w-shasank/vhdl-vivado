
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- this is the uart reveiver hence it should reveive the sereial data from the transmitter and give it to the system
--  the uart transimitter interface of the sending uart is connnected to the uart receiving interface of the receiving uart
  -- the receiver is the interface for the other uart as well as the user data
entity uart_rx is

    generic(clk_div_val : integer := 16;
        parity_bit : string := "none");
 Port (  
        clk :in std_logic; -- system input clk
        rst : in std_logic;
          -- uart interface
         uart_clk_en : in std_logic;
          uart_rxd : in std_logic ;
              -- this is the user interface
           dout : out std_logic_vector(7 downto 0); -- output data received through uart
           dout_vld : out std_logic;   -- when output validity is 1 then the the output data are valid without any errors
           frame_error : out std_logic;   -- when frame error is 1 then invalid frame was received 
           parity_error : out std_logic);   -- the error in the parity bit is occured i.e if 1
end uart_rx;

architecture Behavioral of uart_rx is
        signal rx_clk_en : std_logic;
        signal rx_data : std_logic_vector(7 downto 0);
        signal rx_bit_count : unsigned(2 downto 0);
        signal rx_parity_bit : std_logic;
        signal rx_parity_error : std_logic;
        signal rx_parity_chech_en : std_logic; 
        signal rx_done : std_logic;
        signal fsm_idle : std_logic; -- on if the fsm  is idle 
        signal fsm_databits : std_logic; --on if the the bits are databits
        signal fsm_stopbit : std_logic;  --on if the bits are stopbit
        
        
        type state is (idle , startbit ,databits , paritybit , stopbit);
        signal fsm_pstate : state;
        signal fsm_nstate : state;
        
begin
        
           --uart receiver clock 
           rx_clock_divider_1 : entity work.uart_clock_divider
            generic map(div_max_val => clk_div_val , div_mark_pos => 3)
            port map(clk=>clk,rst => rst ,clear => fsm_idle , enable => uart_clk_en , div_mark => rx_clk_en);
           
            
           --uart receiver bit count
           uart_rx_bit_counter_process : process(clk)
                begin
                    if(rising_edge(clk)) then   
                        if(rst = '1') then   
                            rx_bit_count <=(others => '0');
                         elsif(rx_clk_en = '1' and fsm_databits = '1') then
                            if(rx_bit_count = "111") then
                                rx_bit_count <=(others => '0');
                             else
                                rx_bit_count<=rx_bit_count + 1;
                             end if ;
                       end if;
                    end if ;
               end process uart_rx_bit_counter_process;
                                
           --uart receiver shift register serial to parallel converter
           uart_rx_data_shift_register_process : process(clk)
            begin   
                if(rising_edge(clk)) then 
                    if(rx_clk_en = '1' and fsm_databits = '1') then
                        rx_data <= uart_rxd & rx_data(7 downto 0);
                     end if;
                 end if;
            end process;
      
       dout<= rx_data;
              
              
             --uart receiver parrity checker
             uart_rx_parity_generator : if (parity_bit /= "none") generate 
                uart_rx_parity_gen_1 : entity work.uart_parity
                    generic map(data_width=> 8 , parity_type => parity_bit )
                    port map(data_in => rx_data , parity_out => rx_parity_bit);
                    
                uart_rx_parity_check : process(clk)
                    begin if (rising_edge(clk)) then 
                        if(rx_clk_en = '1') then 
                            rx_parity_error <= rx_parity_bit xor uart_rxd ; --- if the calculated parity bit and the reveived parity bit are not same then 
                                                                           --- the parity bit error is set high
                        end if;
                       end if;
                 end process;
               end generate ;
           
           uart_rx_no_parity : if(parity_bit = "none") generate
                            rx_parity_error <= '0';
                          end generate; 
                     
                   
           rx_done <= rx_clk_en and fsm_stopbit; -- the transimssion is done if the stop bit is high and hence the done flag is set
           
          uart_rx_output_register : process(clk)
                begin
                    if(rising_edge(clk)) then
                        if(rst = '1') then 
                                dout_vld <= '0';
                                frame_error <= '0';
                                parity_error <= '0';
                         else 
                            dout_vld <= rx_done and not rx_parity_error and uart_rxd ;
                            frame_error <= rx_done and not uart_rxd ;
                            parity_error <= rx_done and rx_parity_error ;
                         end if ;
                     end if; 
                  end process;
           -- the revceiver fsm state
           
           -- the present state register
            process(clk)
                begin 
                    if(rising_edge(clk)) then
                        if(rst='1') then 
                            fsm_pstate <= idle;
                        else 
                            fsm_pstate <= fsm_nstate ;
                         end if ;
                      end if;  
                  end process;   
             
            -- the next state and the output combinational logic
            process(fsm_pstate , uart_rxd , rx_clk_en , rx_bit_count)
                begin 
                    case fsm_pstate is
                        when idle =>
                            fsm_stopbit <= '0';
                            fsm_databits<='0';
                            fsm_idle <= '1';
                            
                            if(uart_rxd = '0') then
                                fsm_nstate<=startbit;
                             else 
                                fsm_nstate <= idle ;
                             end if ;
                         
                         when startbit=>
                                fsm_stopbit <= '0';
                                fsm_databits<= '0';
                                fsm_idle <= '0';
                             -- if the data is going to be transferred i.e enable flag 1 
                             if(rx_clk_en = '1') then
                                fsm_nstate <= databits;
                              else
                                    fsm_nstate <= startbit ;
                               end if;
                          
                         when databits=>
                                fsm_stopbit<='0';
                                fsm_databits <='1';
                                fsm_idle <= '0';
                               
                               
                               if((rx_clk_en = '1') and (rx_bit_count = "111")) then 
                                        if(parity_bit = "none") then 
                                            fsm_nstate <=stopbit ;
                                         else
                                            fsm_nstate <= paritybit ;
                                       end if;
                               else 
                                fsm_nstate <= databits;
                              end if;
                         
                         when paritybit =>
                            fsm_stopbit <= '0';
                            fsm_databits<= '0';
                            fsm_idle <= '0';
                            
                            if(rx_clk_en = '1') then 
                                fsm_nstate <= stopbit ;
                             else 
                                 fsm_nstate <= paritybit;
                              end if;
                              
                          when stopbit=>
                                fsm_stopbit <='1';
                                fsm_databits<= '0';
                                fsm_idle <= '0';
                                
                               if(rx_clk_en = '1') then 
                                    fsm_nstate  <= idle;
                                else
                                     fsm_nstate <= stopbit;
                              end if;
                              
                         when others => 
                                fsm_stopbit <= '0';
                                fsm_databits<= '0';
                                fsm_idle <= '0';
                                fsm_nstate <= idle ;
                             
                     end case;
               end process ;
          
          
         end architecture ;
                           
                                  
                           
                           
                                       
                                  
                            
                                
                            
               
                                          
                     
                           
                    
             
     
