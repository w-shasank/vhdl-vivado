library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_flipflop_tb is
end t_flipflop_tb;

architecture sim of t_flipflop_tb is
    constant clock_period : time := 10 ns;
    signal T, clk, E : std_logic := '0';
    signal Q : std_logic;
begin

    -- DUT
    uut: entity work.Tflipflop
        port map( T => T, clk => clk, E => E, Q => Q );

    -- Clock
    clock : process
    begin
        wait for 1 ns;  -- optional initial offset
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;

    -- Enable
    enable : process
    begin
        E <= '0';
        wait for 10 ns;
        E <= '1';
        wait for 40 ns; -- hold enable high
        wait;
    end process;

    -- Stimulus
    stimulation: process
    begin
        T <= '0';
        wait for 10 ns;
        T <= '1';
        wait for 10 ns;
        T <= '0';
        wait for 10 ns;
        T <= '1';
        wait for 10 ns;
        wait;
    end process;

end sim;