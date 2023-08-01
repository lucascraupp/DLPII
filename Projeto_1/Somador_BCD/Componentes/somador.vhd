library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
	generic(N : natural := 4);

	port
	(
		a		: in  std_logic_vector(N-1 downto 0);
		b		: in  std_logic_vector(N-1 downto 0);
		cin	: in	std_logic;

		s		: out std_logic_vector(N-1 downto 0);
		cout	: out std_logic
	);
end entity;

architecture som_v1 of somador is
	signal a_uns, b_uns, cin_uns, som, s_uns : unsigned(N downto 0);
begin

	a_uns <= resize(unsigned(a), N+1);
	b_uns <= resize(unsigned(b), N+1);
	cin_uns <= (0 => cin, others => '0');
	
	som <= a_uns + b_uns + cin_uns;
	
	cout <= '1' when som > 9 else '0';
	
	s_uns <= som - "1010" when som > 9 else som;
	
	s <= std_logic_vector(resize(s_uns, N));

end architecture;