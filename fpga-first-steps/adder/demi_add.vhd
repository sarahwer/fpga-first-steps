library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity demi_add is
  port(a, b: in std_logic; s, cout: out std_logic);
end demi_add;

architecture arch1 of demi_add is
begin
  s <= a xor b;
  cout <= (a and b);
end arch1;
