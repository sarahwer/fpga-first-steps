library ieee;
use ieee.std_logic_1164.all;

entity afficheur is
  port (E : in std_logic_vector(3 downto 0); s : out std_logic_vector(6 downto 0));
end afficheur;

architecture arch of afficheur is
begin
  process (E)
  begin
    case E is
      when "0000" => s <= "1000000";
      when "0001" => s <= "1111001";
      when "0010" => s <= "0100100";
      when "0011" => s <= "0110000";
      when "0100" => s <= "0011001";
      when "0101" => s <= "0010010";
      when "0110" => s <= "0000010";
      when "0111" => s <= "1111000";
      when "1000" => s <= "0000000";
      when "1001" => s <= "0010000";
      when "1010" => s <= "0001000";
      when "1011" => s <= "0000011";
      when "1100" => s <= "1000110";
      when "1101" => s <= "0000110";
      when "1110" => s <= "0001110";
      when "1111" => s <= "0001110";
      when others => s <= "1111111";
    end case;
  end process;
end arch;
