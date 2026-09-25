library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- VGA sync/timing generator: divides a 50 MHz input clock down to 25 MHz
-- (the standard 640x480 @ 60 Hz pixel clock), generates HSYNC/VSYNC from
-- horizontal/vertical pixel counters, and drives a simple checkerboard test
-- pattern on RGB so the timing can be verified on a real monitor.
entity clockmodule is
  port(clk50_in : in std_logic;
       red_out   : out std_logic_vector(3 downto 0);
       blue_out  : out std_logic_vector(3 downto 0);
       green_out : out std_logic_vector(3 downto 0);
       hs_out    : out std_logic;
       vs_out    : out std_logic);
end clockmodule;

architecture Behavioral of clockmodule is
  signal clk25 : std_logic := '0';  -- the 25MHz clock
  signal horizontal_counter : std_logic_vector(9 downto 0);
  signal vertical_counter   : std_logic_vector(9 downto 0);
  signal cnt : std_logic_vector(2 downto 0) := (others => '0');
  signal red   : std_logic;
  signal green : std_logic;
  signal blue  : std_logic;
begin

  -- generate a 25MHz clock
  process (clk50_in)
  begin
    if clk50_in'event and clk50_in = '1' then
      if (cnt = 1) then
        clk25 <= not(clk25);
        cnt <= (others => '0');
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;

  process (clk25)
  begin
    if clk25'event and clk25 = '1' then
      if (horizontal_counter >= "0010010000")  -- 144
        and (horizontal_counter < "1100010000")  -- 784
        and (vertical_counter >= "0000100111")   -- 39
        and (vertical_counter < "1000000111")    -- 519
      then
        red   <= horizontal_counter(3) and vertical_counter(3);
        green <= horizontal_counter(4) and vertical_counter(4);
        blue  <= horizontal_counter(5) and vertical_counter(5);
      else
        red   <= '0';
        green <= '0';
        blue  <= '0';
      end if;

      if (horizontal_counter > "0000000000")
        and (horizontal_counter < "0001100001")  -- 96+1
      then
        hs_out <= '0';
      else
        hs_out <= '1';
      end if;

      if (vertical_counter > "0000000000")
        and (vertical_counter < "0000000011")  -- 2+1
      then
        vs_out <= '0';
      else
        vs_out <= '1';
      end if;

      horizontal_counter <= horizontal_counter + "0000000001";
      if (horizontal_counter = "1100100000") then  -- 800
        vertical_counter <= vertical_counter + "0000000001";
        horizontal_counter <= "0000000000";
      end if;
      if (vertical_counter = "1000001001") then  -- 521
        vertical_counter <= "0000000000";
      end if;
    end if;
  end process;

  red_out   <= red & red & red & red;
  green_out <= green & green & green & green;
  blue_out  <= blue & blue & blue & blue;
end Behavioral;
