----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2026 11:50:27 AM
-- Design Name: 
-- Module Name: full_adder - FA
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

entity full_adder is
  Port ( a,b,c : in std_logic;
         carry ,sum : out std_logic );
end full_adder;

architecture FA of full_adder is    
signal s1,c1,s2,c2:std_logic;

component half_adder
 port(
       a,b : in std_logic;
       sum,carry : out std_logic);
end component;

begin
--Instantiating first half adder :: a +b
HA1: half_adder
    port map( a=>a ,b=>b ,sum=>s1 ,carry=>c1);
    
--instantiating second half adder :: s1+c
HA2: half_adder
    port map(a=>s1,b=>c, sum =>sum , carry=>c2);


carry<=c1 or c2;
 
end FA;
