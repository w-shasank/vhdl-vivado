----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2026 08:24:23 PM
-- Design Name: 
-- Module Name: fsm2_tb - sim
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
entity fsm2_tb is
end fsm2_tb;
architecture sim of fsm2_tb is
    -- Clock period
    constant clk_period : time := 10 ns;
    -- Testbench signals
    signal clk    : std_logic := '0';
    signal clr    : std_logic := '0';
    signal tog_en : std_logic := '0';
    signal y      : std_logic;
    signal output : std_logic;
begin
    -- DUT instantiation
    uut : entity work.fsm2
        port map (
            clk    => clk,
            clr    => clr,
            tog_en => tog_en,
            y      => y,
            output => output
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;
    -- Stimulus process
    stim_process : process
    begin
        -- Apply asynchronous clear
        clr <= '1';
        tog_en <= '0';
        wait for 15 ns;
        -- Release clear
        clr <= '0';
        wait for 20 ns;
        -- Enable toggle → FSM should toggle every clock
        tog_en <= '1';
        wait for 40 ns;
        -- Disable toggle → FSM holds state
        tog_en <= '0';
        wait for 30 ns;
        -- Enable toggle again
        tog_en <= '1';
        wait for 40 ns;

        -- End simulation
        wait;
    end process;

end sim;
