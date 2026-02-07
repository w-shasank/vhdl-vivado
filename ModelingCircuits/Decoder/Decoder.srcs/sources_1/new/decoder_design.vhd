----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 10:44:31 AM
-- Design Name: 
-- Module Name: decoder_design - Behavioral
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



entity decoder_design is
   Port ( a,b,c : in std_logic;
           y : out std_logic );
end decoder_design;

architecture Behavioral of decoder_design is
 signal f : std_logic_vector(7 downto 0);
begin
  decode : entity work.decoder
    port map( a=>a , b=>b ,  c=>c , f=>f);
   
  or1 : entity work.or_gate
        port map(a=>f(0), b=>f(1),c=>f(3) , d=>f(4), y => y);

end Behavioral;
