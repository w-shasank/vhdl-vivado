----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 10:23:17 AM
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
Port ( a,b,c : in std_logic;
        F : out std_logic_vector(7 downto 0) );
end decoder;

architecture structure of decoder is
  signal sel : std_logic_vector(2 downto 0);
        begin
        sel <= a & b & c;
           process(sel)
              begin
        case sel is
            when "000" => F <= "00000001";
            when "001" => F <= "00000010";
            when "010" => F <= "00000100";
            when "011" => F <= "00001000";
            when "100" => F <= "00010000";
            when "101" => F <= "00100000";
            when "110" => F <= "01000000";
            when "111" => F <= "10000000";
            when others => F <= (others => '0');
        end case;
    end process;
        end structure;
