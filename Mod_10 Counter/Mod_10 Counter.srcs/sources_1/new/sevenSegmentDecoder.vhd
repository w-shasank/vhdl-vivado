----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2026 08:17:44 AM
-- Design Name: 
-- Module Name: sevenSegmentDecoder - Behavioral
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

entity sevenSegmentDecoder is
 Port (binary_input : in std_logic_vector(3 downto 0);
       seg_out : out std_logic_vector(6 downto 0) );
end sevenSegmentDecoder;

architecture Behavioral of sevenSegmentDecoder is

begin
    process(binary_input)
    begin
     case binary_input is
            when "0000" => seg_out <= "0111111"; -- 0
            when "0001" => seg_out <= "0000110"; -- 1
            when "0010" => seg_out <= "1011011"; -- 2
            when "0011" => seg_out <= "1001111"; -- 3
            when "0100" => seg_out <= "1100110"; -- 4
            when "0101" => seg_out <= "1101101"; -- 5
            when "0110" => seg_out <= "1111101"; -- 6
            when "0111" => seg_out <= "0000111"; -- 7
            when "1000" => seg_out <= "1111111"; -- 8
            when "1001" => seg_out <= "1101111"; -- 9
            when others => seg_out <= "1000000"; -- Error (middle bar)
        end case;
     end process;
end Behavioral;
