----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2026 05:53:11 PM
-- Design Name: 
-- Module Name: registers - Behavioral
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


--for an 8 bit register
entity registers is
   Port (
        clk : in std_logic;
        clr : in std_logic;
        en  : in std_logic;
        d   : in std_logic_vector(7 downto 0);
        q   : out std_logic_vector(7 downto 0)
 );
end registers;

architecture Behavioral of registers is
        
        component d_flipflop
            port (
            clk : in std_logic;
            clr : in std_logic;
            en  : in std_logic;
            d   : in std_logic;
            q   : out std_logic);
        end component;
begin
--used the generate loop for creating repeated structures
    gen_ff : for i in 0 to 7 generate
            ff_i :d_flipflop
                port map(
                clk => clk,
                clr => clr,
                en  => en,
                d   => d(i),
                q   => q(i));
     end generate;

end Behavioral;
