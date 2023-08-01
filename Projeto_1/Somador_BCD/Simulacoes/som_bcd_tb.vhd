-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity som_bcd_tb is
end;

architecture bench of som_bcd_tb is

  component som_bcd
  	generic(N : natural := 4);
  	port
  	(
  		a	: in	std_logic_vector(4*N-1 downto 0);
  		b	: in	std_logic_vector(4*N-1 downto 0);
  		s 	: out std_logic_vector(5*N-1 downto 0)
  	);
  end component;

  signal a: std_logic_vector(15 downto 0);
  signal b: std_logic_vector(15 downto 0);
  signal s: std_logic_vector(19 downto 0);
  constant period: time := 20 ns;

begin

	-- Insert values for generic parameters !!
	uut: som_bcd generic map ( N => 4)
              port map ( a => a,
                         b => b,
                         s => s );

	stimulus: process
	begin
		  
		a <= "0000000000000000";		-- Valores da entrada A (0,0,0,0)
		b <= "0000000000000000";		-- Valores da entrada B (0,0,0,0)						
		
		wait for period;
		
		assert (S = "00000000000000000000");	-- Resultado S (0,0,0,0,0) 
		report "Falha nas somas de 0+0" severity error;
		
		
		a <= "0001000100010001";	-- Valores da entrada A (1,1,1,1)
		b <= "0001000100010001";	-- Valores da entrada B (1,1,1,1)
										 
		wait for period;
		
		assert (S = "00000010001000100010");	-- Resultado S (0,2,2,2,2)
		report "Falha nas somas de 1+1" severity error;
		
		
		a <= "1001100110011001";	-- Valores da entrada A (9,9,9,9)
				
		wait for period;
		
		assert (S = "00010000000000000000");	-- Resultado S (1,0,0,0,0) 
		report "Falha nas somas de 9 + 1" severity error;
		
		
		a <= "0001000100010001";	-- Valores da entrada A (1,1,1,1)
		b <= "1001100110011001";	-- Valores da entrada B (9,9,9,9)
										 
		wait for period;
		
		assert (S = "00010000000000000000");	-- Resultado S (1,0,0,0,0) 
		report "Falha nas somas de 1 + 9" severity error;
		
		
		a <= "1001100110011001";	-- Valores da entrada A (9,9,9,9)
											
		wait for period;
		
		assert (S = "00011001100110011000");	-- Resultado S (1,9,9,9,8)
		report "Falha nas somas de 9 + 9" severity error;
			
		wait;
	end process;
end;