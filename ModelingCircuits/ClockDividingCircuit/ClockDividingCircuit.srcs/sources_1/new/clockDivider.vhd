----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 06:15:31 PM
-- Design Name: 
-- Module Name: clockDivider - Behavioral
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

entity clockDivider is
  Port ( div_en : in std_logic;
         clk:in std_logic;
          sclk : out std_logic );
end clockDivider;

architecture Behavioral of clockDivider is
  signal stage_clocks : std_logic_vector(0 to 6);
    signal d_inputs   : std_logic_vector(0 to 5);
begin
stage_clocks(0)<= clk;
 
  gen : for i in 0 to 5  generate
         d_inputs(i) <= not stage_clocks(i+1);

        d_ff : entity work.d_ff
            port map(
               div_en => d_inputs(i),     
            clk    => stage_clocks(i),    
            sclk   => stage_clocks(i+1)  );
  end generate gen;
  
sclk<= stage_clocks(6);

end Behavioral;
