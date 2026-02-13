----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2026 08:27:47 AM
-- Design Name: 
-- Module Name: top_level - structural
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

entity top_level is
  Port ( clk:in std_logic;
         reset : in std_logic;
         seg_out : out std_logic_vector(6 downto 0);
         enable  : out std_logic_vector(3 downto 0));
end top_level;

architecture structural of top_level is
    signal binary_in : std_logic_vector(3 downto 0);
    signal div_clk : std_logic;
begin
    enable <= "0000";
Divider: entity work.clock_divider
    port map (
        clk_in => clk,
        reset   => reset,
        clk_out => div_clk
    );
    
Counter:entity work.mod10_counter
    port map(div_clk => div_clk, reset=>reset,q=>binary_in);
    

  SevenSegmentDisplay: entity work.sevenSegmentDecoder
    port map( binary_input=>binary_in,seg_out => seg_out);

end structural;
