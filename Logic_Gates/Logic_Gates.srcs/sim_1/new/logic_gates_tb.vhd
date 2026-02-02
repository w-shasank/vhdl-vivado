----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 09:46:24 AM
-- Design Name: 
-- Module Name: logic_gates_tb - sim
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_gates_tb is
-- Testbenches usually have no ports
end logic_gates_tb;

architecture sim of logic_gates_tb is
    -- Signals to connect to UUT
    signal a, b : std_logic := '0';
    signal y0, y1, y2 : std_logic;
begin
    -- Instantiate the design under test
    uut: entity work.logic_gates
        port map (
            a => a,
            b => b,
            y0 => y0,
            y1 => y1,
            y2 => y2
        );

    -- Test process
    process
    begin
        -- Test case 1: a=0, b=0
        a <= '0'; b <= '0'; wait for 200 ns;

        -- Test case 2: a=0, b=1
        a <= '0'; b <= '1'; wait for 200 ns;

        -- Test case 3: a=1, b=0
        a <= '1'; b <= '0'; wait for 200 ns;

        -- Test case 4: a=1, b=1
        a <= '1'; b <= '1'; wait for 200 ns;

        -- End simulation
        wait;
    end process;

end sim;
