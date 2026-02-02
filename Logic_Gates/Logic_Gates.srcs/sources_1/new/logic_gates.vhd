----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 09:37:13 AM
-- Design Name: 
-- Module Name: logic_gates - gates
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

entity logic_gates is
    Port ( a,b : in STD_LOGIC;
           y0,y1,y2 : out STD_LOGIC);
end logic_gates;

architecture gates of logic_gates is

begin

    y0<= a and b;
    y1<= a or b;
    y2<= not(a and b);
    
end gates;
