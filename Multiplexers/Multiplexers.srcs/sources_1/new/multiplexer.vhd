----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 09:01:11 PM
-- Design Name: 
-- Module Name: multiplexer - mux
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

entity multiplexer is
    Port ( a,b,c,d : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           mx_out : out STD_LOGIC);
end multiplexer;

architecture mux of multiplexer is

begin

  with sel select
      mx_out <= a when "00",
                b when "01",
                c when "10",
                d when "11",
                '0' when others;

end mux;
