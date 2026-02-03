----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2026 04:38:31 PM
-- Design Name: 
-- Module Name: alu_tb - sim
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tb is
--  Port ( );
end alu_tb;

architecture sim of alu_tb is
    
    signal a, b     : signed(3 downto 0) := (others => '0');
    signal sel      : std_logic_vector(2 downto 0) := "000";
    signal out_alu  : signed(3 downto 0);

    begin 
    
    uut:entity work.alu
        port map(a=>a,b=>b,sel=>sel,out_alu=>out_alu);

        stim_proc : process
    begin
  
        a <= "0011";  
        b <= "0010";  
        sel <= "000";
        wait for 200 ns;

        sel <= "001"; 
        wait for 200 ns;

        sel <= "010";
        wait for 200 ns;

        sel <= "011";
        wait for 200 ns;

        sel <= "100";
        wait for 200 ns;

        sel <= "101";
        wait for 200 ns;

        sel <= "110";
        wait for 200 ns;

        sel <= "111";
        wait for 200 ns;

--lets check it for negative numbers also 
        a <= "1101"; 
        b <= "0011";  
        sel <= "000"; 
        wait for 200 ns;

        sel <= "001";
        wait for 200 ns;

        wait; 
    end process;

end sim;

