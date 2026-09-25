library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity add1 is
  port(a, b, cin: in std_logic; s, cout: out std_logic);
end add1;

architecture arch1 of add1 is
begin
  s <= a xor b xor cin;
  cout <= (a and b) or (a and cin) or (b and cin);
end arch1;
