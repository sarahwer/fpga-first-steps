library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity chen is
port (clk:in std_logic;qout:out std_logic_vector(3 downto 0));
end chen;
architecture arch of chen is
signal q:std_logic_vector(3 downto 0):="0111";
begin
cheni:process(clk)
variable t:integer range 0 to 9;
begin
if (clk'event and clk='1') then
q(0)<=not q(0);
if (t<9) then
t:=t+1;
else
t:=0;
q(2)<=q(1);
q(3)<=q(2);
q(1)<=q(3);
end if;
end if;
end process;
qout<=q;
end arch;