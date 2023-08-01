--=============================
-- Listing 9.5 timer
--=============================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity timer is
   port(
      clk, reset	: in std_logic;
		msU, msT, msC	: out std_logic_vector(3 downto 0);
      secU, secT	: out std_logic_vector(3 downto 0);
		minU, minT	: out std_logic_vector(3 downto 0)
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
  
  signal msU_reg, msT_reg, msC_reg : unsigned(3 downto 0);
  signal msU_next, msT_next, msC_next : unsigned(3 downto 0);
  
  signal sU_reg, sT_reg	: unsigned(3 downto 0);
  signal sU_next, sT_next	: unsigned(3 downto 0);
  
  signal mU_reg, mT_reg: unsigned(3 downto 0);
  signal mU_next, mT_next: unsigned(3 downto 0);
  
  signal msU_en, msT_en, msC_en	: std_logic;
  signal sU_en, sT_en	: std_logic;
  signal mU_en, mT_en	: std_logic;
begin
  -- register
  process(clk,reset)
  begin
     if (reset='1') then
        r_reg <= (others=>'0');
		  
		  msU_reg <= (others=>'0');
		  msT_reg <= (others=>'0');
		  msC_reg <= (others=>'0');
		  
        sU_reg <= (others=>'0');
		  sT_reg <= (others=>'0');
		  
        mU_reg <= (others=>'0');
		  mT_reg <= (others=>'0');
     elsif (clk'event and clk='1') then
        r_reg <= r_next;
		  
		  msU_reg <= msU_next;
		  msT_reg <= msT_next;
		  msC_reg <= msC_next;
		  
        sU_reg <= sU_next;
		  sT_reg <= sT_next;
		  
        mU_reg <= mU_next;
		  mT_reg <= mT_next;
     end if;
  end process;
	-- next-state logic/output logic for mod-500 counter  
	r_next <= (others=>'0') when r_reg=499 else
				r_reg + 1;

	msU_en <= '1' when r_reg = 499 else
			     '0';
	
	msU_next <= (others => '0') when (msU_reg = 9 and msU_en = '1') else
					 msU_reg + 1 when msU_en = '1' else
					 msU_reg;
					 
	msT_en <= '1' when (msU_reg = 9 and msU_en = '1') else
				  '0';
	
	msT_next <= (others => '0') when (msT_reg = 9 and msT_en = '1') else
					 msT_reg + 1 when msT_en = '1' else
					 msT_reg;
	
	msC_en <= '1' when (msT_reg = 9 and msT_en = '1') else
				  '0';
				  
	msC_next <= (others => '0') when (msC_reg = 9 and msC_en = '1') else
					 msC_reg + 1 when msC_en = '1' else
					 msC_reg;
				  
	sU_en <= '1' when (msC_reg = 9 and msC_en = '1') else 
				'0';
				
	sU_next <= (others => '0') when (sU_reg = 9 and sU_en = '1') else
				  sU_reg + 1 when sU_en = '1' else
				  sU_reg;
				  
	sT_en <= '1' when (sU_reg = 9 and sU_en = '1') else 
				'0';
				
	sT_next <= (others => '0') when (sT_reg = 5 and sT_en = '1') else
				  sT_reg + 1 when sT_en = '1' else
				  sT_reg;
	
	mU_en <= '1' when (sT_reg = 5 and sT_en = '1') else
			   '0';
	
	mU_next <= (others => '0') when (mU_reg = 9 and mU_en = '1') else
				  mU_reg + 1 when mU_en = '1' else
				  mU_reg;
				  
	mT_en <= '1' when (mU_reg = 9 and mU_en = '1') else
			   '0';
				
	mT_next <= (others => '0') when (mT_reg = 5 and mT_en = '1') else
				  mT_reg + 1 when mT_en = '1' else
				  mT_reg;

	-- output logic
	msU <= std_logic_vector(msU_reg);
	msT <= std_logic_vector(msT_reg);
	msC <= std_logic_vector(msC_reg);
	
	secU <= std_logic_vector(sU_reg);
	secT <= std_logic_vector(sT_reg);
	
	minU <= std_logic_vector(mU_reg);
	minT <= std_logic_vector(mT_reg);
end single_clock_arch;
