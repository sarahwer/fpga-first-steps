library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity add4 is
  port(a, b: in std_logic_vector(3 downto 0);
       cin: in std_logic;
       s: out std_logic_vector(3 downto 0);
       cout: out std_logic);
end add4;

architecture arch1 of add4 is
  component add1
    port(a, b, cin: in std_logic; s, cout: out std_logic);
  end component;
  signal n: std_logic_vector(2 downto 0);
begin
  p1: add1 port map (a(0), b(0), cin,  s(0), n(0));
  p2: add1 port map (a(1), b(1), n(0), s(1), n(1));
  p3: add1 port map (a(2), b(2), n(1), s(2), n(2));
  p4: add1 port map (a(3), b(3), n(2), s(3), cout);
end arch1;
