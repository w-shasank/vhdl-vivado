library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Port (
        clk_in  : in  std_logic;   -- 100 MHz
        reset   : in  std_logic;
        clk_out : out std_logic    -- ~1 Hz
    );
end clock_divider;
architecture Behavioral of clock_divider is
    -- For 100MHz to 1Hz: 
    constant DIV_COUNT : unsigned(25 downto 0) := to_unsigned(50_000_000 - 1, 26);
    signal count       : unsigned(25 downto 0) := (others => '0');
    signal clk_reg     : std_logic := '0';
begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if reset = '0' then
                count   <= (others => '0');
                clk_reg <= '0';
            elsif count = DIV_COUNT then
                count   <= (others => '0');
                clk_reg <= not clk_reg; -- This flip creates the pulse
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;

end Behavioral;