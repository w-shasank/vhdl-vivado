----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 11:40:16 AM
-- Design Name: 
-- Module Name: half_adder_tb - Behavioral
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

entity half_adder_tb is
--  Port ( );
end half_adder_tb;

architecture Behavioral of half_adder_tb is
     signal a,b : STD_LOGIC:='0';
     signal carry ,sum : std_logic ;
begin
    uut:entity work.half_adder
    port map(a=>a, b=>b, carry => carry , sum =>sum);
   
   --test process
  process
    begin
         a <= '0'; b <= '0'; wait for 200 ns;

        -- Test case 2: a=0, b=1
        a <= '0'; b <= '1'; wait for 200 ns;

        -- Test case 3: a=1, b=0
        a <= '1'; b <= '0'; wait for 200 ns;

        -- Test case 4: a=1, b=1
        a <= '1'; b <= '1'; wait for 200 ns;
        
     wait ;
   end process;

end Behavioral;
