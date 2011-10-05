library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.ttt_ram_package.all;
use work.eCLOCK;

entity ttt_board is
port (
	color_enable	:in std_logic;
	x_col			:in integer range 3 downto 0;
	y_col			:in integer range 3 downto 0;
	z_col			:in integer range 3 downto 0;
	color			:out std_logic_vector(2 downto 0);
	
	x_up			:in integer range 3 downto 0;
	y_up			:in integer range 3 downto 0;
	z_up			:in integer range 3 downto 0;
	place_edge		: in std_logic;
	cursor_o		:out integer range 2 downto 0;
	
	CLOCK_50 : in std_logic;
	CLR		 : in std_logic;
	p1_turn	: out std_logic;
	
	board		: out ttt_ram
	);
	
	
end entity ttt_board;

architecture rw of ttt_board is

	signal grid : ttt_ram;

	signal	cursor_clk	: std_logic;
	signal turn : std_logic := '0'; -- 1 for P1, 0 for P2

begin
	cursor_blink : eCLOCK
	generic map( count => 24999999, dc_count =>12499999 )
	port map(
		CLOCK_50MHz => CLOCK_50,
		eCLOCK => cursor_clk
	);

	process(CLOCK_50)
	begin			
	if CLR = '1' then
		for i in 3 downto 0 loop
			for j in 3 downto 0 loop
				for k in 3 downto 0 loop
					grid(i,j,k) <= 0;
				end loop;
			end loop;
		end loop;
		turn <= '1';
	else
		if rising_edge(CLOCK_50) then
			if place_edge = '1' and grid(x_up,y_up,z_up) = 0 then
				if turn = '1' then
					grid(x_up,y_up,z_up) <= 1;
				else
					grid(x_up,y_up,z_up) <= 2;
				end if;
				turn <= not turn;
			end if;
		end if;
--		
		if color_enable = '1' then
			if x_up = x_col and y_up = y_col and z_up = z_col
				and cursor_clk = '1'
			then
				color <= "110"; -- Yellow if the cursor is blinking
			else
				case grid( x_col, y_col, z_col) is
					when 0 =>
						color <= "111"; -- blank
					when 1 =>
						color <= "100"; -- P1 is red
					when 2 =>
						color <= "010"; -- P2 is green
					when others =>
						color <= "000";
				end case;
			end if;
		end if;
	end if;
	end process;

	p1_turn <= not turn;
	cursor_o <= grid(x_up,y_up,z_up);
	board <= grid;
	
end architecture rw;
