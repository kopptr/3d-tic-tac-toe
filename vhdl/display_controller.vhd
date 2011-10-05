library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity display_controller is
	port(
		clk		: std_logic;

		-- From vga_controller
		X_addr	: in integer range 639 downto 0;
		Y_addr	: in integer range 479 downto 0;
	
		-- From game_logic, format RBG
		color_i	: in std_logic_vector( 2 downto 0 );

		-- To game_logic
		x_o		: out std_logic_vector( 1 downto 0 );
		y_o		: out std_logic_vector( 1 downto 0 );
		z_o		: out std_logic_vector( 1 downto 0 );

		-- To vga_controller
		r_o		: out std_logic;
		g_o		: out std_logic;
		b_o		: out std_logic;
		
		-- Flash the winner's color
		flash_en	: in std_logic;
		flash_col : in std_logic
		);
end entity display_controller;

architecture fourDtictactoe of display_controller is

constant buf : integer :=8;
constant X_cell : integer := 150;
constant Y_cell : integer := 110;
signal background : std_logic_vector(2 downto 0) := "000"; --rgb
constant buffcolor : std_logic_vector(2 downto 0) := "001"; --rgb
constant sbuf : integer :=6;
constant X_space : integer := 30;
constant Y_space : integer := 20; --DOES NOT COME OUT EVEN.  Make sure to add a pixel at the top and bottom to correct

begin

	process( clk )
	begin
		if rising_edge( clk ) then
			-- If winning flash
			if flash_en = '1' then
				if flash_col = '1' then
					background <= "100";
				else
					background <= "010";
				end if;
			else
				background <= "000";
			end if;

				-- Left Buffer zone	
				if X_addr < buf then
					r_o <= background(2);--buffcolor(2);
					g_o <= background(1);--buffcolor(1);
					b_o <= background(0);--buffcolor(0);
					--r_o <= buffcolor(2);
					--g_o <= buffcolor(1);
					--b_o <= buffcolor(0);

				-- Layer 1 (z = 0)
				elsif X_addr < X_cell + buf then
					z_o <= "00";
					if Y_addr < buf then --cell buffer
						r_o <= background(2);--buffcolor(2);
						g_o <= background(1);--buffcolor(1);
						b_o <= background(0);--buffcolor(0);
					elsif Y_addr < Y_cell + buf then --Board
						if X_addr < buf + sbuf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);						
						elsif X_addr < X_space + sbuf + buf then -- col 0
							x_o <= "00";
							if Y_addr < sbuf + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + buf then --(0,0,0)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + buf then --(0,1,0)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + buf then -- (0,2,0)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + buf then --(0,3,0)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;						
						elsif X_addr < X_space + (2 * sbuf) + buf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (2 * X_space) + (2 * sbuf) + buf then -- col 1
							x_o <= "01";
							if Y_addr < sbuf + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + buf then --(1,0,0)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + buf then --(1,1,0)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + buf then --(1,2,0)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + buf then --(1,3,0)
								y_o <="11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (2 * X_space) + (3 * sbuf) + buf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (3 * X_space) + (3 * sbuf) + buf then --col 2
							x_o <= "10";
							if Y_addr < sbuf + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + buf then -- (2,0,0)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + buf then --(2,1,0)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + buf then --(2,2,0)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + buf then --(2,3,0)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (3 * X_space) + (4 * sbuf) + buf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (4 * X_space) + (4 * sbuf) + buf then --col 3
							x_o <= "11";
							if Y_addr < sbuf + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + buf then --(3,0,0)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + buf then --(3,1,0)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + buf then --(3,2,0)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + buf then --(3,3,0)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + buf then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (4 * X_space) + (5 * sbuf) + buf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						end if;
					elsif Y_addr < Y_cell + (2 * buf) then --buffer
						r_o <= background(2);--buffcolor(2);
						g_o <= background(1);--buffcolor(1);
						b_o <= background(0);--buffcolor(0);
					else -- background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					end if;

				-- Buffer between 1 and 2
				elsif X_addr < X_cell + (2 * buf) then
					r_o <= background(2);--buffcolor(2);
					g_o <= background(1);--buffcolor(1);
					b_o <= background(0);--buffcolor(0);

				-- Layer 2 (z = 1)
				elsif X_addr < (2 * X_cell) + (2 * buf) then
					z_o <= "01";
					if Y_addr < Y_cell + buf then --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);				
					elsif Y_addr < Y_cell + (2 * buf) then --buffer
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					elsif Y_addr < (2* Y_cell) + (2 * buf) then --Board
						if X_addr < X_cell + (2 * buf) + sbuf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);						
						elsif X_addr < X_space + sbuf + X_cell + (2 * buf) then --col 0
							x_o <= "00";
							if Y_addr < sbuf + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + Y_cell + (2 * buf) then --(0,0,1)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + Y_cell + (2 * buf) then --(0,1,1)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --(0,2,1)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --(0,3,1)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < X_space + (2 * sbuf) + X_cell + (2 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (2 * X_space) + (2 * sbuf) + X_cell + (2 * buf) then --col 1
							x_o <= "01";
							if Y_addr < sbuf + Y_cell+(2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + Y_cell + (2 * buf) then --(1,0,1)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + Y_cell + (2 * buf) then --(1,1,1)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --(1,2,1)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --(1,3,1)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (2 * X_space) + (3 * sbuf) + X_cell + (2 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (3 * X_space) + (3 * sbuf) + X_cell + (2 * buf) then --col 2
							x_o <= "10";
							if Y_addr < sbuf + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + Y_cell + (2 * buf) then --(2,0,1)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + Y_cell + (2 * buf) then --(2,1,1)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --(2,2,1)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --(2,3,1)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (3 * X_space) + (4 * sbuf) + X_cell + (2 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (4 * X_space) + (4 * sbuf) + X_cell + (2 * buf) then --col 3
							x_o <= "11";
							if Y_addr < sbuf + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + Y_cell + (2 * buf) then --(3,0,1)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + Y_cell + (2 * buf) then --(3,1,1)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + Y_cell + (2 * buf) then --(3,2,1)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + Y_cell + (2 * buf) then --(3,3,1)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + Y_cell + (2 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (4 * X_space) + (5 * sbuf) + X_cell + (2 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						end if;
					elsif Y_addr < (2* Y_cell) + (3 * buf) then --buffer
						r_o <= background(2);--buffcolor(2);
						g_o <= background(1);--buffcolor(1);
						b_o <= background(0);--buffcolor(0);
					else --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					end if;

				-- Buffer between 2 and 3
				elsif X_addr < (2 * X_cell) + (3 * buf) then
					r_o <= background(2);
					g_o <= background(1);
					b_o <= background(0);

				-- Layer 3 (z = 2)
				elsif X_addr < (3 * X_cell) + (3 * buf) then
					z_o <= "10";
					if Y_addr < (2 * Y_cell) + (2 * buf) then --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);				
					elsif Y_addr < (2 * Y_cell) + (3 * buf) then --buffer
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);				
					elsif Y_addr < (3 * Y_cell) + (3 * buf) then --Board
						if X_addr < (2 * X_cell) + (3 * buf) + sbuf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);						
						elsif X_addr < X_space + sbuf + (2 * X_cell) + (3 * buf) then --col 0
							x_o <= "00";
							if Y_addr < sbuf + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (2 * Y_cell) + (3 * buf) then --(0,0,2)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --(0,1,2)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --(0,2,2)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --(0,3,2)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < X_space + (2 * sbuf) + (2 * X_cell) + (3 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (2 * X_space) + (2 * sbuf) + (2 * X_cell) + (3 * buf) then --col 1
							x_o <= "01";
							if Y_addr < sbuf + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (2 * Y_cell) + (3 * buf) then --(1,0,2)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --(1,1,2)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --(1,2,2)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --(1,3,2)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (2 * X_space) + (3 * sbuf) + (2 * X_cell) + (3 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (3 * X_space) + (3 * sbuf) + (2 * X_cell) + (3 * buf) then --col 2
							x_o <= "10";
							if Y_addr < sbuf + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (2 * Y_cell) + (3 * buf) then --(2,0,2)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --(2,1,2)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --(2,2,2)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --(2,3,2)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (3 * X_space) + (4 * sbuf) + (2 * X_cell) + (3 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (4 * X_space) + (4 * sbuf) + (2 * X_cell) + (3 * buf) then --col 3
							x_o <= "11";
							if Y_addr < sbuf + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (2 * Y_cell) + (3 * buf) then --(3,0,2)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (2 * Y_cell) + (3 * buf) then --(3,1,2)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (2 * Y_cell) + (3 * buf) then --(3,2,2)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (2 * Y_cell) + (3 * buf) then --(3,3,2)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (2 * Y_cell) + (3 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (4 * X_space) + (5 * sbuf) + (2 * X_cell) + (3 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						end if;
					elsif Y_addr < (3 * Y_cell) + (4 * buf) then --buffer
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					else --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					end if;
				-- Buffer between 3 and 4
				elsif X_addr < (3 * X_cell) + (4 * buf) then
					r_o <= background(2);
					g_o <= background(1);
					b_o <= background(0);

				-- Layer 4 (z = 3)
				elsif X_addr < (4 * X_cell) + (4 * buf) then
					z_o <= "11";
					if Y_addr < (3 * Y_cell) + (3 * buf) then --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);		
					elsif Y_addr < (3 * Y_cell) + (4 * buf) then --buffer
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					elsif Y_addr < (4 * Y_cell) + (4 * buf) then --Board
						if X_addr < (3 * X_cell) + (4 * buf) + sbuf then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);						
						elsif X_addr < X_space + sbuf + (3 * X_cell) + (4 * buf) then --col 0
							x_o <= "00";
							if Y_addr < sbuf + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (3 * Y_cell) + (4 * buf) then --(0,0,3)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --(0,1,3)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --(0,2,3)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --(0,3,3)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < X_space + (2 * sbuf) + (3 * X_cell) + (4 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (2 * X_space) + (2 * sbuf) + (3 * X_cell) + (4 * buf) then --col 1
							x_o <= "01";
							if Y_addr < sbuf + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (3 * Y_cell) + (4 * buf) then --(1,0,3)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --(1,1,3)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --(1,2,3)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --(1,3,3)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (2 * X_space) + (3 * sbuf) + (3 * X_cell) + (4 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (3 * X_space) + (3 * sbuf) + (3 * X_cell) + (4 * buf) then --col 2
							x_o <= "10";
							if Y_addr < sbuf + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (3 * Y_cell) + (4 * buf) then --(2,0,3)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --(2,1,3)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --(2,2,3)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --(2,3,3)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (3 * X_space) + (4 * sbuf) + (3 * X_cell) + (4 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						elsif X_addr < (4 * X_space) + (4 * sbuf) + (3 * X_cell) + (4 * buf) then --col 3
							x_o <= "11";
							if Y_addr < sbuf + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < Y_space + sbuf + (3 * Y_cell) + (4 * buf) then --(3,0,3)
								y_o <= "00";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < Y_space + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (2 * Y_space) + (2 * sbuf) + (3 * Y_cell) + (4 * buf) then --(3,1,3)
								y_o <= "01";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (2 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (3 * Y_space) + (3 * sbuf) + (3 * Y_cell) + (4 * buf) then --(3,2,3)
								y_o <= "10";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (3 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							elsif Y_addr < (4 * Y_space) + (4 * sbuf) + (3 * Y_cell) + (4 * buf) then --(3,3,3)
								y_o <= "11";
								r_o <= color_i(2);
								g_o <= color_i(1);
								b_o <= color_i(0);
							elsif Y_addr < (4 * Y_space) + (5 * sbuf) + (3 * Y_cell) + (4 * buf) then --space buffer
								r_o <= buffcolor(2);
								g_o <= buffcolor(1);
								b_o <= buffcolor(0);
							end if;
						elsif X_addr < (4 * X_space) + (5 * sbuf) + (3 * X_cell) + (4 * buf) then --space buffer
							r_o <= buffcolor(2);
							g_o <= buffcolor(1);
							b_o <= buffcolor(0);
						end if;
					elsif Y_addr < (4 * Y_cell) + (5 * buf) then --buffer
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					else --background
						r_o <= background(2);
						g_o <= background(1);
						b_o <= background(0);
					end if;
					
				-- Right buffer
				else -- X_addr < (4 * X_cell) + (5 * buf) then
				r_o <= background(2);
				g_o <= background(1);
				b_o <= background(0);

			end if;	
		end if;
	end process;

end architecture fourDtictactoe;


