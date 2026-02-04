----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2026 08:52:32 PM
-- Design Name: 
-- Module Name: flipFlop - Behavioral
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
-- arithmetic functions with Signed or Unigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Port specifications of d - flipflop
entity flipFlop is
Port ( D: in std_logic;
       clk :in std_logic;
       Q :out std_logic );
end flipFlop;


--architectural descriotion of the d -flipflop
architecture Behavioral of flipFlop is

begin
 --process for behaviourak modeling
 operation : process(clk)
                begin
                    if rising_edge(clk) then
                           Q<=D;
                           end if;
                end process operation;
                
end Behavioral;
