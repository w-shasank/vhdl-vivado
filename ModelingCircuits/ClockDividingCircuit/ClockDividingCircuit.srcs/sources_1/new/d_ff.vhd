----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 06:17:40 PM
-- Design Name: 
-- Module Name: d_ff - behavioural
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

entity d_ff is
  Port (
         div_en : in std_logic;
         clk:in std_logic;
          sclk : out std_logic);
end d_ff;

architecture behavioural of d_ff is

begin
  process(clk)
    begin   
        if(rising_edge(clk)) then
            sclk<=div_en;
            end if;
    end process;
end behavioural;
