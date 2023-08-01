library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
	port
	(
		a	: in std_logic_vector(13 downto 0);
		b	: in std_logic_vector(13 downto 0);

		s	: out std_logic_vector(15 downto 0)
	);
end entity;

architecture som_v1 of somador is
	signal a_uns, b_uns : unsigned(15 downto 0);
begin
	a_uns <= resize(unsigned(a), 16);
	b_uns <= resize(unsigned(b), 16);
	
	s <= std_logic_vector(a_uns + b_uns);
end architecture;