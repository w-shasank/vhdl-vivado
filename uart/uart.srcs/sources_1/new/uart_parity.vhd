library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity uart_parity is
 generic(
            data_width : integer:= 8;
            parity_type : string := "none"); -- legal values: "none", "even", "odd"
    port(
        data_in : in std_logic_vector(data_width -1 downto 0);
         parity_out : out std_logic);
end uart_parity;

architecture Behavioral of uart_parity is
begin
    even_parity_generator : if(parity_type = "even") generate   
                               process(data_in)
                                   variable parity_temp : std_logic;
                                   begin
                                        parity_temp:='0';   
                                        for i in data_in'range loop
                                            parity_temp := parity_temp xor data_in(i);
                                        end loop ;
                                        parity_out <= parity_temp ;
                                end process;
                            end generate;
                          
   odd_parity_generator : if(parity_type ="odd") generate   
                           process(data_in)
                                variable parity_temp :std_logic;
                                        begin
                                            parity_temp :='1';
                                            for i in data_in'range loop
                                                parity_temp := parity_temp xor data_in(i);
                                             end loop;
                                             parity_out<= parity_temp;
                                         end process;
                                 end generate;
    none_parity_generator : if(parity_type = "none") generate
       parity_out <= '0'; -- default value
        end generate;
                           
end Behavioral;
