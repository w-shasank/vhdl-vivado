----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 12:48:13 PM
-- Design Name: 
-- Module Name: registers - structural
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

entity registers is
  Port ( A :in std_logic_vector(7 downto 0);
         clk: in std_logic;
         ld : in std_logic;
         Y : out std_logic_vector(7 downto 0));
end registers;

architecture structural of registers is

begin
        process(clk)
            begin
                if(falling_edge(clk)) then 
                    if(ld = '1') then
                        y <= A;
                     end if;
                 end if ;
            end process ;

end structural;
