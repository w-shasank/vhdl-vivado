----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2026 12:46:13 PM
-- Design Name: 
-- Module Name: mux - structural
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

entity mux is
  Port (
    a, b : in  std_logic_vector(7 downto 0);
    sel  : in  std_logic;
    y    : out std_logic_vector(7 downto 0)
  );
end mux;

architecture structural of mux is
begin
  y <= a when sel = '1' else b;
end structural;

