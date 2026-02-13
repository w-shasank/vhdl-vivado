


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity uart_debouncer is

    generic (latency : natural :=4);
 Port ( 
         clk: in std_logic;  -- this is the system clock itself
          deb_in : in std_logic;  --input signal fron the other device
          deb_out : out std_logic); --filered signal 
end uart_debouncer;

architecture Behavioral of uart_debouncer is
    constant shift_reg_depth : natural := latency - 1;
     
    signal in_shift_reg : std_logic_vector(shift_reg_depth-1 downto 0);
    signal out_reg_rst : std_logic;
    signal out_reg_set : std_logic;

begin
    --input shift register
     input_shift_register: process(clk)
        begin 
            if(rising_edge(clk)) then
                in_shift_reg <= in_shift_reg(shift_reg_depth -2 downto 0) & deb_in;
            end if;
        end process;
        
     --output shift register  
     --low case reset
       output_shift_register_reset : process(in_shift_reg , deb_in)
            variable or_var : std_logic ;
                begin 
                    or_var := deb_in;
                        all_bits_or_l : for i in 0 to shift_reg_depth -1 loop  
                            or_var := or_var or in_shift_reg(i);
                         end loop;
                      out_reg_rst <= not or_var;
                 end process;
      --high case set 
       output_shift_register_set : process(deb_in , in_shift_reg)
        variable and_var : std_logic;
       begin 
            and_var := deb_in ;
            all_bits_and_l : for i in 0 to shift_reg_depth -1 loop
                    and_var := and_var and in_shift_reg(i);
                  end loop;  
                out_reg_set <= and_var;
        end process;   
        
        
     --output register
     output_reg_process : process(clk)
         begin 
            if(rising_edge(clk)) then 
                if(out_reg_rst = '1') then
                        deb_out <= '0' ;
                 elsif(out_reg_set = '1') then 
                        deb_out <= '1';
                  end if ;  
               end if; 
         end process;
end Behavioral;
