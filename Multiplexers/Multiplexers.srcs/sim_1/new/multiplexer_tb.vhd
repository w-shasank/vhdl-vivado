----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 09:07:06 PM
-- Design Name: 
-- Module Name: multiplexer_tb - sim
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

entity multiplexer_tb is
--  Port ( );
end multiplexer_tb;

architecture sim of multiplexer_tb is
signal a,b,c,d:std_logic :='0';
signal mx_out :std_logic ;
signal sel : std_logic_vector (1 downto 0) :="00";
begin
uut : entity work.multiplexer
    port map(a=>a,b=>b,c=>c,d=>d,sel=>sel,mx_out=>mx_out);
    
process 
    begin
         -- Initialize inputs
        a <= '0'; b <= '1'; c <= '0'; d <= '1';

        -- Select A
        sel <= "00";
        wait for 20 ns;

        -- Select B
        sel <= "01";
        wait for 20 ns;

        -- Select C
        sel <= "10";
        wait for 20 ns;

        -- Select D
        sel <= "11";
        wait for 20 ns;

        -- Change data inputs to verify dynamic behavior
        a <= '1'; b <= '0'; c <= '1'; d <= '0';

        sel <= "00";
        wait for 20 ns;

        sel <= "01";
        wait for 20 ns;

        sel <= "10";
        wait for 20 ns;

        sel <= "11";
        wait for 20 ns;

        -- End simulation
        wait;
    end process;
end sim;
