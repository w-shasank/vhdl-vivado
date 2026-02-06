library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_register_tb is
end bit_register_tb;

architecture sim of bit_register_tb is

    constant clock_period : time := 10 ns;

    signal clk : std_logic := '0';
    signal clr : std_logic := '0';
    signal en  : std_logic := '0';
    signal d   : std_logic_vector(7 downto 0) := (others => '0');
    signal q   : std_logic_vector(7 downto 0);

begin

    uut : entity work.registers
        port map (
            clk => clk,
            clr => clr,
            en  => en,
            d   => d,
            q   => q
        );

    clk_process : process
    begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;

    stim_proc : process
    begin
    
        clr <= '1';
        en  <= '0';
        d   <= "10101010";
        wait for 15 ns;

        clr <= '0';
        wait for 10 ns;

        en <= '1';
        d  <= "11001100";
        wait for 20 ns; 

        d <= "00110011";
        wait for 20 ns; 
        
        en <= '0';
        d  <= "11111111";
        wait for 20 ns;
        
        en <= '1';
        wait for 20 ns;

        wait;
    end process;

end sim;
