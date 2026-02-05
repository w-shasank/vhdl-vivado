----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2026 05:02:48 PM
-- Design Name: 
-- Module Name: fsm1_tb - sim
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

entity fsm1_tb is
--  Port ( );
end fsm1_tb;

architecture sim of fsm1_tb is
  constant clock_period : time:=10ns;
  signal clk , clr,tog_en : std_logic:='0';
  signal output:std_logic ;
begin
 uut : entity work.fsm1
    port map(clk=>clk,clr=>clr,tog_en=>tog_en,output=>output);
    
     clock_process : process
    begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -------------------------------------------------
        -- Apply asynchronous clear
        -------------------------------------------------
        clr <= '1';
        tog_en <= '0';
        wait for 15 ns;

        -------------------------------------------------
        -- Release clear
        -------------------------------------------------
        clr <= '0';
        wait for 20 ns;

        -------------------------------------------------
        -- Toggle enable ON → FSM should toggle state
        -------------------------------------------------
        tog_en <= '1';
        wait for 40 ns;

        -------------------------------------------------
        -- Disable toggle → FSM should hold state
        -------------------------------------------------
        tog_en <= '0';
        wait for 30 ns;

        -------------------------------------------------
        -- Enable toggle again
        -------------------------------------------------
        tog_en <= '1';
        wait for 40 ns;

        -------------------------------------------------
        -- End simulation
        -------------------------------------------------
        wait;
    end process;

 
end sim;
