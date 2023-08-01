library ieee;
use ieee.std_logic_1164.all;

entity tx is
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
end entity;

architecture transmissao of tx is
	type state_tx is (idle, first, remaining);
	signal tx_reg, tx_next : state_tx;
begin
	process(rst, clk) is 
	begin 
		if(rst = '1') then
			tx_reg <= idle;
		elsif(clk'event and clk = xe) then
			tx_reg <= tx_next;
		end if;
	end process;

	-- Estado de transmissao
	process(tx_reg, tx_en, i) is 
	begin 
		-- Valores padrao
		tsca	<= '1';
		dxa	<= '1';
		clr_i <= '1';
				
		case tx_reg is
			when idle =>
				if (tx_en = '1') then
					tx_next <= first;
				else
					tx_next <= idle;
				end if;
				
			when first =>
				tsca	<= '0';
				dxa	<= valor(i);
				clr_i <= '0';
				
				if (tx_en = '1') then
					tx_next <= remaining;
				else
					tx_next <= idle;
				end if;
				
			when remaining =>
				tsca	<= '0';
				dxa	<= valor(i);
				clr_i <= '0';
				
				if (tx_en = '1') then
					if (i = 0) then
						tx_next <= first;
					else
						tx_next <= remaining;
					end if;
				else
					tx_next <= idle;
				end if;
		end case;
	end process;
end architecture;