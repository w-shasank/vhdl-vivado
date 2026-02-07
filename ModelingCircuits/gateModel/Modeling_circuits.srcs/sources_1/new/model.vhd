----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 09:54:37 AM
-- Design Name: 
-- Module Name: model - Behavioral
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

entity model is
  Port ( a: in std_logic;
         b,c : in std_logic;
         F :out std_logic);
end model;

architecture Behavioral of model is
  signal andA , andB :  std_logic;
    signal nota, notb, notc : std_logic;
begin
   nota <= not a;
  notb <= not b;
  notc <= not c;

   and1: entity work.and_gates
   port map(a=>a , b=>notb, y =>andA);
   
   and2: entity work.and_gates
   port map(a=>nota , b=>notc ,y => andB);
   
   
   or1: entity work.or_gate
   port map(a=>andA,b=>andB,y=>F);
end Behavioral;
