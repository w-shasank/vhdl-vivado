----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 10:10:09 AM
-- Design Name: 
-- Module Name: model_tb - sim
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

entity model_tb is
--  Port ( );
end model_tb;

architecture sim of model_tb is
 signal a,b,c:std_logic :='0';
 signal F :std_logic;
begin
 uut: entity work.model
    port map( a=>a,b=>b,c=>c,f=>f);
    
   stim_proc: process
        begin   
     a <= '0'; b <= '0'; c <= '0';
    wait for 10 ns;
    a <= '1'; b <= '0'; c <= '0';
    wait for 10 ns;
    a <= '0'; b <= '1'; c <= '0';
    wait for 10 ns;
    a <= '1'; b <= '1'; c <= '1';
    wait for 10 ns;

 
   end process stim_proc;

end sim;
