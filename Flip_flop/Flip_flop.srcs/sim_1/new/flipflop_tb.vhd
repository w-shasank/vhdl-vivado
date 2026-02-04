----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2026 08:58:41 PM
-- Design Name: 
-- Module Name: flipflop_tb - sim
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

    
    entity flipflop_tb is
    --  Port ( );
    end flipflop_tb;
    
    architecture sim of flipflop_tb is
        constant clock_period :time := 10ns;
        signal D,clk : std_logic:='0';
        signal Q : std_logic ;
    begin
            uut:entity work.flipFlop
             port map(q=>q,clk=>clk,d=>d);
          
         
          --process for the clock gneration
          clock:process
                begin     
                 clk<='0';
                 wait for clock_period/2;
                 
                 clk<='1';
                 wait for clock_period/2;
                 
          end process clock ;
        -- process for the input value generation
          input : process   
                begin
                   D <= '0';
                   wait for 12 ns; 

                  D <= '1';
                  wait for 20 ns;

                  D <= '0';
                  wait for 20 ns;

                  D <= '1';
                  wait for 20 ns;
          end process input;
    end sim;
