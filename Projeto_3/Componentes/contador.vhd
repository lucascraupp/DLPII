library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
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
end entity;

architecture cont of contador is
	signal r_reg, r_next : natural range 0 to N;
begin
	process(rst, clk) is  
	begin 
		if(rst = '1') then
			r_reg <= N;
		elsif(clk'event and clk = xe) then
			r_reg <= r_next;
		end if;
	end process;
	
	r_next <= N when r_reg = 0 else
				 r_reg - 1;
	
	s <= r_reg;
end architecture;