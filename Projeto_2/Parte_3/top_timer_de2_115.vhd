library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_timer_de2_115 is
  port (
    CLOCK_50 : in std_logic;
    KEY      : in std_logic_vector (0 downto 0);
    HEX0     : out std_logic_vector (6 downto 0);
    HEX1     : out std_logic_vector (6 downto 0);
    HEX2     : out std_logic_vector (6 downto 0);
	 HEX4     : out std_logic_vector (6 downto 0);
	 HEX5     : out std_logic_vector (6 downto 0);
	 HEX6     : out std_logic_vector (6 downto 0);
	 HEX7     : out std_logic_vector (6 downto 0)
  );

end entity;

architecture top_a3_2019_2 of top_timer_de2_115 is
  
  component PLL_500KHz
		PORT
		(
			inclk0	: IN STD_LOGIC  := '0';
			c0			: OUT STD_LOGIC 
		);
	end component;
	
  component timer
	port(
		clk, reset	: in std_logic;
		msU, msT, msC	: out std_logic_vector(3 downto 0);
		secU, secT	: out std_logic_vector(3 downto 0);
		minU, minT	: out std_logic_vector(3 downto 0)
	);
	end component;

  component bcd2ssd
    port (
      BCD : in std_logic_vector (3 downto 0);
      SSD : out std_logic_vector (6 downto 0)
    );
  end component;

  signal minT, minU : std_logic_vector(3 downto 0);
  signal secT, secU : std_logic_vector(3 downto 0);
  signal msC, msT, msU : std_logic_vector(3 downto 0);
  signal reset	: std_logic;
  signal clk_500khz : std_logic;

begin

	reset <= not KEY(0);

	PLL_500Khz_inst : PLL_500KHz 
	PORT MAP (
		inclk0	 => CLOCK_50,
		c0	 => clk_500khz
	);

	t0 : timer
	port map(
		clk	=> clk_500khz, 
		reset => reset,
		msU	=> msU,
		msT	=> msT, 
		msC	=> msC,
		secU	=> secU, 
		secT	=> secT,
		minU	=> minU,
		minT	=> minT
	);

	bcd0 : bcd2ssd
	port map(
	 BCD => msU,
	 SSD => HEX0);
	 
	bcd2 : bcd2ssd
	port map(
	 BCD => msT,
	 SSD => HEX1);
	 
	bcd3 : bcd2ssd
	port map(
	 BCD => msC,
	 SSD => HEX2);
	 
	bcd4 : bcd2ssd
	port map(
	 BCD => secU,
	 SSD => HEX4);

	bcd5 : bcd2ssd
	port map(
	 BCD => secT,
	 SSD => HEX5);

	bcd6 : bcd2ssd
	port map(
	 BCD => minU,
	 SSD => HEX6);

	bcd7 : bcd2ssd
	port map(
	 BCD => minT,
	 SSD => HEX7);
	 
end top_a3_2019_2;