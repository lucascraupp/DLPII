library ieee;
use ieee.std_logic_1164.all;

entity som_bin is
	port
	(
		a	: in std_logic_vector(13 downto 0);
		b	: in std_logic_vector(13 downto 0);
		clk, rst : in std_logic;

		bcd0, bcd1, bcd2, bcd3, bcd4	: out std_logic_vector(3 downto 0)
	);
end entity;

architecture som_v1 of som_bin is
	signal s_aux : std_logic_vector(15 downto 0);
	
	component somador is
	port
	(
		a	: in std_logic_vector(13 downto 0);
		b	: in std_logic_vector(13 downto 0);

		s	: out std_logic_vector(15 downto 0)
	);
	end component;
	
	component bin2bcd is
		generic(N: positive := 16);
		port(
		  clk, reset: in std_logic;
		  binary_in: in std_logic_vector(N-1 downto 0);
		  bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
		);
end component;
begin
	
	Som : somador
		port map
		(
			a	=> a,
			b	=> b,

			s	=> s_aux
		);
		
	Conv : bin2bcd
		generic map(N => 16)
		port map(
		  clk 		=> clk,
		  reset		=> rst,
		  binary_in	=> s_aux,
		  
		  bcd0		=> bcd0,
		  bcd1		=> bcd1,
		  bcd2		=> bcd2,
		  bcd3		=> bcd3,
		  bcd4		=> bcd4
		);

end architecture;
