--=============================
-- Listing 9.5 timer
--=============================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity timer is
   port(
      clk, reset: in std_logic;
		ms	: out std_logic_vector(9 downto 0);
      sec, min: out std_logic_vector(5 downto 0)
   );
end timer;

-- architecture multi_clock_arch of timer is
--    signal r_reg: unsigned(25 downto 0);
--    signal r_next: unsigned(25 downto 0);
--    signal s_reg, m_reg: unsigned(5 downto 0);
--    signal s_next, m_next: unsigned(5 downto 0);
--    signal sclk, mclk: std_logic;
-- begin
--    -- register
--    process(clk,reset)
--    begin
--       if (reset='1') then
--          r_reg <= (others=>'0');
--       elsif (clk'event and clk='1') then
--          r_reg <= r_next;
--       end if;
--    end process;
--    -- next-state logic
--    r_next <= (others=>'0') when r_reg=499 else
--              r_reg + 1;
--    -- output logic
--    sclk <= '0' when r_reg < 25000000 else
--            '1';
--    -- second divider
--    process(sclk,reset)
--    begin
--       if (reset='1') then
--          s_reg <= (others=>'0');
--       elsif (sclk'event and sclk='1') then
--          s_reg <= s_next;
--       end if;
--    end process;
--    -- next-state logic
--    s_next <= (others=>'0') when s_reg=59 else
--              s_reg + 1;
--    -- output logic
--    mclk <= '0' when s_reg < 30 else
--            '1';
--    sec <= std_logic_vector(s_reg);
--    -- minute divider
--    process(mclk,reset)
--    begin
--       if (reset='1') then
--          m_reg <= (others=>'0');
--       elsif (mclk'event and mclk='1') then
--          m_reg <= m_next;
--       end if;
--    end process;
--    -- next-state logic
--    m_next <= (others=>'0') when m_reg=59 else
--              m_reg + 1;
--    -- output logic
--    min <= std_logic_vector(m_reg);
-- end multi_clock_arch;


----=============================
---- Listing 9.6
----=============================
architecture single_clock_arch of timer is
  signal r_reg: unsigned(8 downto 0);
  signal r_next: unsigned(8 downto 0);
  signal ms_reg : unsigned(9 downto 0);
  signal ms_next : unsigned(9 downto 0);
  signal s_reg, m_reg: unsigned(5 downto 0);
  signal s_next, m_next: unsigned(5 downto 0);
  signal ms_en, s_en, m_en: std_logic;
begin
  -- register
  process(clk,reset)
  begin
     if (reset='1') then
        r_reg <= (others=>'0');
		  ms_reg <= (others=>'0');
        s_reg <= (others=>'0');
        m_reg <= (others=>'0');
     elsif (clk'event and clk='1') then
        r_reg <= r_next;
		  ms_reg <= ms_next;
        s_reg <= s_next;
        m_reg <= m_next;
     end if;
  end process;
  -- next-state logic/output logic for mod-500 counter  
  r_next <= (others=>'0') when r_reg=499 else
            r_reg + 1;
  
  ms_en <= '1' when r_reg = 499 else
          '0';		 
  -- next state logic/output logic for msliseconds divider
  ms_next <= (others => '0') when (ms_reg = 999 and ms_en = '1') else
				  ms_reg + 1 when ms_en = '1' else ms_reg;
				  
  s_en <= '1' when ms_reg = 999 and ms_en = '1' else '0';
  -- next state logic/output logic for second divider
  s_next <= (others=>'0') when (s_reg=59 and s_en='1') else
            s_reg + 1     when s_en='1' else
            s_reg;
				
  m_en <= '1' when s_reg=59 and s_en='1' else
          '0';
  -- next-state logic for minute divider
  m_next <= (others=>'0') when (m_reg=59 and m_en='1') else
            m_reg + 1     when m_en='1' else
            m_reg;
  
  -- output logic
  ms <= std_logic_vector(ms_reg);
  sec <= std_logic_vector(s_reg);
  min <= std_logic_vector(m_reg);
end single_clock_arch;
