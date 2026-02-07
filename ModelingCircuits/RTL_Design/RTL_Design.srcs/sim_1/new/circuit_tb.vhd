library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuit_tb is
end circuit_tb;

architecture sim of circuit_tb is

  signal a, b, c : std_logic_vector(7 downto 0) := (others => '0');
  signal sl1, sl2, clk : std_logic := '0';
  signal rax, rbx : std_logic_vector(7 downto 0);

  constant clk_period : time := 10 ns;

begin

  -- Instantiate DUT
  uut: entity work.circuit
    port map (
      a   => a,
      b   => b,
      c   => c,
      sl1 => sl1,
      sl2 => sl2,
      clk => clk,
      rax => rax,
      rbx => rbx
    );

  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
    end loop;
  end process;

  stim_proc : process
  begin
    -- Initial values
    a   <= x"12";
    b   <= x"34";
    c   <= x"56";
    sl1 <= '0';
    sl2 <= '0';
    wait for clk_period;

    sl1 <= '0';      -- select reg1
    wait for clk_period;

    sl1 <= '1';      -- select reg2
    sl2 <= '0';      -- mux -> b
    wait for clk_period;

    c   <= x"AA";
    sl2 <= '1';      -- mux -> c
    wait for clk_period;

    a   <= x"FF";
    sl1 <= '0';      -- select reg1
    wait for clk_period;

    wait for 20 ns;

  end process;

end sim;