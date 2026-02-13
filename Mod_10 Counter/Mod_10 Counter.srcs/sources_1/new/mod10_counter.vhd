----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2026 08:04:07 AM
-- Design Name: 
-- Module Name: mod10_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL; 

entity mod10_counter is
 Port (div_clk   : in std_logic;
       reset : in std_logic;
       q     : out std_logic_vector(3 downto 0) );
end mod10_counter;

architecture Behavioral of mod10_counter is
    signal reg_count : unsigned(3 downto 0) := (others => '0');
    signal seg_out : std_logic_vector(6 downto 0);
begin   
 
    process(div_clk, reset)
    begin
        if reset = '0' then
            reg_count <= (others => '0');
        elsif rising_edge(div_clk) then
            if reg_count = to_unsigned(9, reg_count'length)then 
                reg_count <= (others => '0'); 
            else
                reg_count <= reg_count + 1;
            end if;
        end if;
    end process;
         
    q <= std_logic_vector(reg_count);
    
  
end Behavioral;
