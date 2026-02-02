library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture sim of full_adder_tb is
    -- Signals to connect to the Full Adder
    signal a, b, c : std_logic := '0';
    signal sum, carry : std_logic;
begin
    -- Instantiate the Full Adder
    uut: entity work.full_adder
        port map(
            a => a,
            b => b,
            c => c,
            sum => sum,
            carry => carry
        );

    -- Test process: cycle through all 8 input combinations
    process
    begin
        -- a=0, b=0
        a <= '0'; b <= '0'; c <= '0'; wait for 100 ns;
        a <= '0'; b <= '0'; c <= '1'; wait for 100 ns;
        a <= '0'; b <= '1'; c <= '0'; wait for 100 ns;
        a <= '0'; b <= '1'; c <= '1'; wait for 100 ns;
        a <= '1'; b <= '0'; c <= '0'; wait for 100 ns;
        a <= '1'; b <= '0'; c <= '1'; wait for 100 ns;
        a <= '1'; b <= '1'; c <= '0'; wait for 100 ns;
        a <= '1'; b <= '1'; c <= '1'; wait for 100 ns;

        -- End simulation
        wait;
    end process;

end sim;
