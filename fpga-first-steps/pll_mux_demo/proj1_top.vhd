library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity counter is
port (clock: in std_logic;
counter_out: out std_logic_vector(31 downto 0));
end counter;
architecture A_counter of counter is
signal counter: std_logic_vector(31 downto 0):=(others=>'0');
begin
count:process(clock)
begin
if (clock'event and clock='1') then
counter<=counter+'1';
end if;
end process;
counter_out<=counter;
end A_counter;