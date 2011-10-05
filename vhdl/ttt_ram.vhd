library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.ttt_ram_package.all;
use work.all;

entity ttt_ram is
port (
	color_enable	:in std_logic;
	x_col			:in std_logic_vector(1 downto 0);
	y_col			:in std_logic_vector(1 downto 0);
	z_col			:in std_logic_vector(1 downto 0);
	color		:out std_logic_vector(2 downto 0);
	
	x_up			:in std_logic_vector(1 downto 0);
	y_up			:in std_logic_vector(1 downto 0);
	z_up			:in std_logic_vector(1 downto 0);
	place_edge		: in std_logic;
	cursor_o		:out std_logic_vector(1 downto 0);
	
	CLOCK_50 : in stD_logic;
	CLR		 : in std_logic;

	p1_turn	: out std_logic
	);
	
	
end entity ttt_ram;

architecture rw of ttt_ram is
	signal	grid		: std_logic_vector(0 to 127) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
	signal	up_clk	: std_logic;
	signal turn : std_logic := '0'; -- 1 for P1, 0 for P2

begin
	uper : eCLOCK
	generic map( count => 24999999, dc_count =>12499999 )
	port map(
		CLOCK_50MHz => CLOCK_50,
		eCLOCK => up_clk
	);

	process(CLOCK_50)
	begin			
	if CLR = '1' then
		grid <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
		turn <= '1';
	else
		if rising_edge(CLOCK_50) then
			if place_edge = '1' and grid(CONV_INTEGER(x_up&y_up&z_up)*2 to (CONV_INTEGER(x_up&y_up&z_up)*2)+1) = "00" then
				if turn = '1'then
					grid(CONV_INTEGER(x_up&y_up&z_up)*2 to (CONV_INTEGER(x_up&y_up&z_up)*2)+1)<= "01";
					turn <= not turn;
				else
					grid(CONV_INTEGER(x_up&y_up&z_up)*2 to (CONV_INTEGER(x_up&y_up&z_up)*2)+1)<= "10";
					turn <= not turn;
				end if;
			end if;
		end if;
		
		if color_enable = '1' then
			if x_up = x_col and y_up = y_col and z_up = z_col and up_clk = '1' then
				color <= "110";
			else
				case grid( (CONV_INTEGER(x_col&y_col&z_col) * 2) to (CONV_INTEGER(x_col&y_col&z_col) * 2)+1) is
					when "00" =>
						color <= "111"; -- blank
					when "01" =>
						color <= "100";
					when "10" =>
						color <= "010";
					when "11" =>
						color <= "000"; -- unimplemented
				end case;
			end if;
		end if;
	end if;
	end process;

	p1_turn <= turn;

	cursor_o <= grid( (CONV_INTEGER(x_up&y_up&z_up) * 2) to (CONV_INTEGER(x_up&y_up&z_up) * 2)+1);
	
end architecture rw;
