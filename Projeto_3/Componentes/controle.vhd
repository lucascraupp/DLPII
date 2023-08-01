library ieee;
use ieee.std_logic_1164.all;

entity controle is
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
end entity;

architecture cntrl of controle is
	type state_control is (wt, go, reset);
	signal cntrl_reg, cntrl_next : state_control;
begin
	process(rst, clk) is 
	begin 
		if(rst = '1') then
			cntrl_reg <= wt;
		elsif(clk'event and clk = xe) then
			cntrl_reg <= cntrl_next;
		end if;
	end process;
	
	-- Estado de controle
	process(cntrl_reg, fs, b) is 
	begin 
		-- Valores padrao
		tx_en <= '0';
		clr_b <= '1';
		
		case cntrl_reg is
			when wt =>
				if (fs = '1') then
					cntrl_next <= go;
				else
					cntrl_next <= wt;
				end if;
				
			when go =>
				tx_en <= '1';
				clr_b <= '0';
				
				if (fs = '0') then
					if (b = 0) then
						cntrl_next <= wt;
					else
						cntrl_next <= go;
					end if;
				else
					cntrl_next <= reset;
				end if;
			
			when reset =>
				cntrl_next <= go;
		end case;
	end process;
end architecture;
