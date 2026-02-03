----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2026 04:21:23 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
  Port ( a : in signed(3 downto 0);
         b: in signed(3 downto 0);
         sel :in std_logic_vector(2 downto 0);
         out_alu : out signed(3 downto 0)  );
end alu;

architecture Behavioral of alu is

begin
    main : process(a,b,sel) 
        begin
            case sel is 
                when "000" =>
                    out_alu <= a + b;
                 when "001" =>
                    out_alu<= a -b;
                 when "010"=>
                     out_alu <= a - 1;
                 when "011"=>
                      out_alu <= b - 1;
                 when "100"=>
                       out_alu <= a and b ;
                 when "101"=>
                        out_alu <= a or b;
                 when "110" =>
                        out_alu <= not a;
                 when "111" =>
                        out_alu <= a xor b;
                  when others =>
                            NULL;
              end case ;
     end process main;
                                              
end Behavioral;
