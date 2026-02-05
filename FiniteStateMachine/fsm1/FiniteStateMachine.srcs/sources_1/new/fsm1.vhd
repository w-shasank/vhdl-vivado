----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2026 04:32:53 PM
-- Design Name: 
-- Module Name: fsm1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm1 is
 Port ( tog_en :in std_logic;
         CLR : in std_logic;
          CLK: in std_logic;
           output : out std_logic); 
end fsm1;

architecture Behavioral of fsm1 is
    type state_type is (st0,st1);
    signal ps , ns :state_type;
    
    begin
    
      --The synchronous process block handles the asynchrounous reset and also handles the state transition upon the arrival of suitable clock
         sync_process :process(clr,clk)
                            begin
                          
                                -- initially the input is zero and if the clear signal is active then the stete should be state_0
                                if(clr = '1') then
                                        PS <= st0;
                                 elsif (rising_edge(clk)) then
                                         ps<=ns;
                                 end if;
                       end process sync_process;
       --The combinational process block handles the ouputs and computes the logic for next state transition
       -- this is a moore machine hence the output is only the function of the present state hence independet of the input the output values are same
       --but if we were to implment the mealy machine the outputs should be assigned in a if -- statement block with the input for assigning
       --next state and the output    
         comb_process : process(ps,tog_en)
                        begin   
                            ns<=ps;
                            case PS is
                            ---modeling the cases for the first state
                                when st0 =>
                                      if(tog_en = '1') then
                                            ns <= st1;
                                       else ns <= st0;
                                      end if;
                               -- modeling the cases for the second state
                                 when st1 =>
                                       if(tog_en = '1') then
                                                ns <= st0;
                                        else ns<=st1;
                                      end if;
                                  when others =>
                                        ns <= st0;
                             end case ;
                        end process comb_process;
                        
                        
                    output <= '1' when ps = st1 else '0';
                        

end Behavioral;
