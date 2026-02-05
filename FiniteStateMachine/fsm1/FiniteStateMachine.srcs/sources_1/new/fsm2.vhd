----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2026 06:53:35 PM
-- Design Name: 
-- Module Name: fsm2 - Behavioral
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
 
entity fsm2 is
  Port ( tog_en : in std_logic; 
         clk,clr : in std_logic;
         y , output : out std_logic );
end fsm2;

architecture Behavioral of fsm2 is

    type state_type is (st0 , st1);
    signal ns , ps : state_type;
begin

sync_process:process(clk,clr)
        begin
        if(clr='1')then
            ps<=st0;
         elsif(rising_edge(clk)) then
                ps<=ns;
          end if;
        end process sync_process;

comb_process:process(ps,tog_en)
        begin 
                ns<=ps;
            case ps is 
                when st0 =>
                    if(tog_en ='1') then  ns<=st1; 
                     else  ns<=st0 ;
                     end if;
                when st1=>
                      if(tog_en='1') then ns<=st0;
                      else ns<=st1;
                      end if;
                 when others =>
                      ns<=st0;
            end case ;
       end process comb_process;
        
        -- this is for the other output port
 output<= '1' when ps = st1 else '0';
    --  for the state output 
    
  with ps select
      y<= '0' when st0,
           '1' when st1,
           '0' when others;
        

end Behavioral;
