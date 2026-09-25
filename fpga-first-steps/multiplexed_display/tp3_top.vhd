library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;

-- Top-level: adds two 4-bit numbers (add4, from ../adder/) and time-division
-- multiplexes the two operands, the sum, and the carry-out across a single
-- shared 7-segment digit (one physical display, four digit-select strobes
-- AN0..AN3 driven in sequence from a free-running counter).
entity tp3 is
  port(clkin : in std_logic;
       a, b  : in std_logic_vector(3 downto 0);
       cin   : in std_logic;
       AN3, AN2, AN1, AN0 : inout std_logic;
       aff   : out std_logic_vector(6 downto 0));
end tp3;

architecture arch1 of tp3 is
  component afficheur
    port(E : in std_logic_vector(3 downto 0); s : out std_logic_vector(6 downto 0));
  end component;
  component add4
    port(a, b : in std_logic_vector(3 downto 0); cin : in std_logic;
         s : out std_logic_vector(3 downto 0); cout : out std_logic);
  end component;

  signal ctr : std_logic_vector(6 downto 0);
  signal a_7, b_7, s_7, c_7 : std_logic_vector(6 downto 0);
  signal c : std_logic;
  signal c_int, s : std_logic_vector(3 downto 0);
begin
  v1: afficheur port map(a, a_7);
  v2: afficheur port map(b, b_7);
  u1: add4 port map(a, b, cin, s, c);
  c_int <= "000" & c;
  v3: afficheur port map(s, s_7);
  v4: afficheur port map(c_int, c_7);

  process(clkin)
  begin
    if (clkin'event and clkin = '1') then
      if (ctr = "0000000") then
        if (AN0 = '0') then
          AN0 <= '1'; aff <= a_7; AN1 <= '0';
        elsif (AN1 = '0') then
          AN1 <= '1'; aff <= b_7; AN2 <= '0';
        elsif (AN2 = '0') then
          AN2 <= '1'; aff <= s_7; AN3 <= '0';
        elsif (AN3 = '0') then
          AN3 <= '1'; aff <= c_7; AN0 <= '0';
        end if;
      end if;
      ctr <= ctr + "0000001";
      if (ctr > "1000000") then
        ctr <= "0000000";
      end if;
    end if;
  end process;
end arch1;
