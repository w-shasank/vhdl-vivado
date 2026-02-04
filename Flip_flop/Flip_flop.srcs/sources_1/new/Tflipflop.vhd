----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2026 09:45:43 PM
-- Design Name: 
-- Module Name: Tflipflop - Behavioral
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

entity Tflipflop is
 Port ( T,clk,E : in std_logic;   
        Q: out std_logic);
end Tflipflop;

architecture Behavioral of Tflipflop is

begin
    process 
        begin
             
              if(E = '0') then 
                     Q<='1';
                     
              elsif rising_edge(CLK) then
                     Q<=T;
               end if;
      end process;
         

end Behavioral;
