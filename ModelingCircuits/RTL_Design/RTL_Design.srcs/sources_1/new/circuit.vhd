----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 12:44:57 PM
-- Design Name: 
-- Module Name: circuit - Behavioral
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

entity circuit is
 Port ( a,b,c : in std_logic_vector(7 downto 0);
         sl1 , sl2 , clk : in std_logic;
         rax, rbx : out std_logic_vector(7 downto 0));
end circuit;

architecture Behavioral of circuit is
 signal do1, do2 : std_logic :='0';
 signal muxO : std_logic_vector(7 downto 0) :=(others =>'0');
 
begin
decoder1: entity work.decoder
 port map(a=> sl1, f(0)=>do1 , f(1)=>do2);
 
mux1 : entity work.mux  
 port map( a=>b , b=> c ,sel=>sl2,y=> muxO );


reg1: entity work.registers
    port map(a=>a , clk =>clk ,ld=>do1 , y=>rax);
    

reg2: entity work.registers
    port map(a=>muxO , clk =>clk ,ld=>do2 , y=>rbx);
     

end Behavioral;
