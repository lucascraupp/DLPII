library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity codec is
	generic
	(
		xe		: std_logic :=	'0';
		valor	: std_logic_vector(7 downto 0) := "01101010"
	);

	port
	(
		pclk	: in std_logic;
		fs		: in std_logic;
		rst	: in std_logic;

		dxa	: out std_logic;
		tsca	: out std_logic
	);
end entity;

architecture pcm of codec is
	signal tx_en, clr_i, clr_b : std_logic;
	signal i : natural range 0 to 7;
	signal b : natural range 0 to 255;
	
	component controle
	generic (xe : std_logic := '0');
	port
	(
		clk	: in std_logic;
		rst	: in std_logic;
		fs		: in std_logic;
		b		: in natural range 0 to 255;

		tx_en	: out std_logic;
		clr_b	: out std_logic
	);
	end component;
	
	component tx
	generic 
	(
		xe		: std_logic :=	'0';
		valor : std_logic_vector := "01101010"
	);
	port
	(
		clk	: in std_logic;
		rst	: in std_logic;
		tx_en	: in std_logic;
		i		: in natural range 0 to 7;

		tsca	: out std_logic;
		dxa	: out std_logic;
		clr_i : out std_logic
	);
	end component;
	
	component contador
	generic 
	(
		N	: natural := 3;
		xe : std_logic := '0'
	);
	port
	(
		rst	: in  std_logic;
		clk	: in  std_logic;

		s		: out natural range 0 to N
	);
	end component;
	
begin
	cntrl: controle
	generic map (xe => xe)
	port map
	(
		clk	=> pclk,
		rst	=> rst,
		fs		=> fs,
		b		=> b,

		tx_en	=> tx_en,
		clr_b	=> clr_b
	);
	
	mod256: contador
	generic map 
	(
		N	=> 255,
		xe	=> xe
	)
	port map
	(
		rst => clr_b,
		clk => pclk,

		s	=> b
	);
	
	transmissao: tx
	generic  map
	(
		xe		=> xe,
		valor => valor
	)
	port map
	(
		clk	=> pclk,
		rst	=> rst,
		tx_en	=> tx_en,
		i		=> i,

		tsca	=> tsca,
		dxa	=> dxa,
		clr_i => clr_i
	);
	
	mod8: contador
	generic map 
	(
		N	=> 7,
		xe => xe
	)
	port map
	(
		rst => clr_i,
		clk => pclk,

		s	=> i
	);
end architecture;