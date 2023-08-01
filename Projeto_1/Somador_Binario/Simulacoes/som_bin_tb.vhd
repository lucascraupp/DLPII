-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity som_bin_tb is
end;

architecture bench of som_bin_tb is

  component som_bin
  	generic(N : natural := 14);
  	port
  	(
  		a	: in std_logic_vector(N-1 downto 0);
  		b	: in std_logic_vector(N-1 downto 0);
  		clk, rst	: in std_logic;
  		bcd0, bcd1, bcd2, bcd3, bcd4	: out std_logic_vector(3 downto 0)
  	);
  end component;

  signal a: std_logic_vector(13 downto 0);
  signal b: std_logic_vector(13 downto 0);
  signal clk, rst: std_logic;
  signal bcd0, bcd1, bcd2, bcd3, bcd4: std_logic_vector(3 downto 0);
  constant period: time := 20 ns;
  constant s_per : time := 0.01 ns;
  signal encerra : std_logic;
  signal s : std_logic_vector(14 downto 0);

begin

	-- Insert values for generic parameters !!
	uut: som_bin generic map (N   =>  14)
						port map (a    => a,
									 b    => b,
									 clk  => clk,
									 rst  => rst,
									 bcd0 => bcd0,
									 bcd1 => bcd1,
									 bcd2 => bcd2,
									 bcd3 => bcd3,
									 bcd4 => bcd4 );

	rst <= '1', '0' after period/2;
	
	process
	begin
		clk <= '0';
		wait for period/100;
		clk <= '1';
		wait for period/100;
		
		if encerra = '1' then
			wait;
		end if;
	end process;
	
	stimulus: process
	begin  
		encerra <= '0';
		a <= "00000000000000";
		b <= "00000000000000";
		s <= "000000000000000";

		wait for s_per;
		s <= std_logic_vector(resize(unsigned(a), 15) + resize(unsigned(b), 15));
		
		wait for period;
		
		assert ((bcd0 = "0000") and (bcd1 = "0000") and (bcd2 = "0000") and (bcd3 = "0000") and (bcd4 = "0000"));
		report "Falha nas somas de 0+0" severity error;
		
		a <= "00010001010111";
		b <= "00010001010111";
		
		wait for s_per;
		s <= std_logic_vector(resize(unsigned(a), 15) + resize(unsigned(b), 15));

		wait for period;
		
		assert ((bcd0 = "0010") and (bcd1 = "0010") and (bcd2 = "0010") and (bcd3 = "0010") and (bcd4 = "0000"));
		report "Falha nas somas de 1111+1111" severity error;
		
		a <= "10011100001111";
		
		wait for s_per;
		s <= std_logic_vector(resize(unsigned(a), 15) + resize(unsigned(b), 15));
				
		wait for period;

		assert ((bcd0 = "0000") and (bcd1 = "0001") and (bcd2 = "0001") and (bcd3 = "0001") and (bcd4 = "0001"));
		report "Falha nas somas de 9999 + 1111" severity error;
		
		a <= "00010001010111";
		b <= "10011100001111";
		
		wait for s_per;
		s <= std_logic_vector(resize(unsigned(a), 15) + resize(unsigned(b), 15));
										 
		wait for period;
		
		assert ((bcd0 = "0000") and (bcd1 = "0001") and (bcd2 = "0001") and (bcd3 = "0001") and (bcd4 = "0001"));
		report "Falha nas somas de 1111 + 9999" severity error;
		
		a <= "10011100001111";
		
		wait for s_per;
		s <= std_logic_vector(resize(unsigned(a), 15) + resize(unsigned(b), 15));
											
		wait for period;
	
		assert ((bcd0 = "1000") and (bcd1 = "1001") and (bcd2 = "1001") and (bcd3 = "1001") and (bcd4 = "0001"));
		report "Falha nas somas de 9999 + 9999" severity error;
		
		encerra <= '1';
		
		wait;
	end process;
end;