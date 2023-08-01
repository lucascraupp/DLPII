library ieee;
use ieee.std_logic_1164.all;

entity som_bcd is
	generic(N : natural := 4);

	port
	(
		a	: in	std_logic_vector(4*N-1 downto 0);
		b	: in	std_logic_vector(4*N-1 downto 0);
		s 	: out std_logic_vector(5*N-1 downto 0)
	);
end entity;

architecture ap_gen of som_bcd is
	signal cin : std_logic_vector(N downto 0);
	signal a_aux, b_aux: std_logic_vector(a'range);

	component somador is
		generic(N : natural := 4);

		port
		(
			a		: in  std_logic_vector(N-1 downto 0);
			b		: in  std_logic_vector(N-1 downto 0);
			cin	: in	std_logic;

			s		: out std_logic_vector(N-1 downto 0);
			cout	: out std_logic
		);
	end component;
begin
	a_aux		<= a;
	b_aux		<= b;
	cin(0)	<= '0';

		N_somadores: 
		for i in 0 to N-1 generate
			Som : somador
				generic map(N => 4)
				port map
				(
					a		=>	a_aux((4*i+3) downto 4*i),
					b		=> b_aux((4*i+3) downto 4*i),
					cin	=>	cin(i),

					s		=> s((4*i+3) downto 4*i),
					cout	=> cin(i+1)
				);
		end generate;

		s(5*N-1 downto 5*N-4) <= (5*N-4 => cin(N), others => '0');
end architecture;