----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2026 08:55:44 PM
-- Design Name: 
-- Module Name: uart_clock_divider - RTL
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use IEEE.MATH_REAL.ALL;

entity uart_clock_divider is

    generic (
               div_max_val : integer := 16;
               div_mark_pos : integer := 1);
  Port ( 
            clk : in std_logic ; -- this is the clock of the system itself
             rst: in std_logic ;
             --user interface
             clear : in std_logic ;--clock divider coounter clear this is for the internal state of the clock divider
              enable : in std_logic; --enable for the clock divider count
               div_mark : out std_logic);
end uart_clock_divider;

architecture RTL of uart_clock_divider is
      constant clk_div_width : integer := integer(ceil(log2(real(div_max_val))));
     
     signal clk_div_cnt  : unsigned(clk_div_width-1 downto 0);
     signal clk_div_cnt_mark : std_logic;
        
begin
        clock_counting_process : process(clk)
            begin
                if(rising_edge(clk)) then 
                    if(clear ='1') then
                        clk_div_cnt <=(others => '0'); 
                     elsif(enable = '1') then
                        if(clk_div_cnt = div_max_val -1 ) then 
                            clk_div_cnt <= (others=>'0');
                         else  
                            clk_div_cnt <= clk_div_cnt +1 ;
                        end if;
                     end if;
                end if ;
            end process clock_counting_process;
   clk_div_cnt_mark <= '1' when (clk_div_cnt = div_mark_pos) else '0';
   
   mark_division : process(clk)
        begin 
            if(rising_edge(clk)) then
                div_mark <= enable and clk_div_cnt_mark;
            end if ;
        end process;
end RTL;
