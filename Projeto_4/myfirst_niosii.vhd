--Author: Roberto de Matos

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY myfirst_niosii IS 
	PORT
	(
		CLOCK_50	:	IN		STD_LOGIC;
		SW			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
		KEY0	   :	IN 	STD_LOGIC;
		OP			:	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		ENTER		:	IN		STD_LOGIC;
		
		LEDR		:	OUT	STD_LOGIC_VECTOR(15 downto 0);
		LEDG 	   :	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		LCD_DATA	:	INOUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		LCD_ON	:	OUT	STD_LOGIC;
		LCD_BLON	: 	OUT	STD_LOGIC;
		LCD_EN	:	OUT	STD_LOGIC;
		LCD_RS	:	OUT 	STD_LOGIC;
		LCD_RW	:	OUT	STD_LOGIC
	);
END myfirst_niosii;

ARCHITECTURE system OF myfirst_niosii IS 		
	component nios2_first_cpu is
		port (
			clk_clk        : in    std_logic                     := 'X';             -- clk
			enter_export   : in    std_logic                     := 'X';             -- export
			lcd_DATA       : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- DATA
			lcd_ON         : out   std_logic;                                        -- ON
			lcd_BLON       : out   std_logic;                                        -- BLON
			lcd_EN         : out   std_logic;                                        -- EN
			lcd_RS         : out   std_logic;                                        -- RS
			lcd_RW         : out   std_logic;                                        -- RW
			led_pio_export : out   std_logic_vector(7 downto 0);                     -- export
			led_r_export   : out   std_logic_vector(15 downto 0);                    -- export
			reset_reset_n  : in    std_logic                     := 'X';             -- reset_n
			sw_export      : in    std_logic_vector(15 downto 0) := (others => 'X')  -- export
		);
	end component nios2_first_cpu;
	
begin		
		u0 : component nios2_first_cpu
		port map (
			clk_clk        => clock_50,
			enter_export   => enter,
			lcd_DATA       => lcd_data,
			lcd_ON         => lcd_on,
			lcd_BLON       => lcd_blon,
			lcd_EN         => lcd_en,
			lcd_RS         => lcd_rs,
			lcd_RW         => lcd_rw,
			led_pio_export => ledG,
			led_r_export   => ledR,
			reset_reset_n  => key0,
			sw_export      => sw
		);

end system;

















