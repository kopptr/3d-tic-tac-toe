library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity vga_controller is
	port(
		CLOCK_50	: in std_logic;
		red_i		: in std_logic_vector( 9 downto 0 );
		green_i		: in std_logic_vector( 9 downto 0 );
		blue_i		: in std_logic_vector( 9 downto 0 );

		red_o		: out std_logic_vector( 9 downto 0 );
		green_o		: out std_logic_vector( 9 downto 0 );
		blue_o		: out std_logic_vector( 9 downto 0 );
		
		vgA_clk	: out std_logic;
		vga_blank : out std_logic;
		vga_sync : out std_logic;
		hs_o		: out std_logic;
		vs_o		: out std_logic;

		-- Indexing starts from top-left corner.
		-- X moves right, Y moves down.
		X_index		: out integer range 639 downto 0 ;
		Y_index		: out integer range 479 downto 0 ;
		refresh_clock	: out std_logic
	);
end entity vga_controller;

architecture bmp of vga_controller is

	signal CLOCK_25 : std_logic;
	signal h_count : integer range 800 downto 0;
	signal v_count : integer range 521 downto 0;

begin

vga_clk <= CLOCK_25;
vga_blank <= '1';
vga_sync <= '1';

	clock_25MHz : eCLOCK
	generic map( count => 1, dc_count => 0	)
	port map(
		CLOCK_50MHz => CLOCK_50,
		eCLOCK => CLOCK_25 );

	refresh_clock <= CLOCK_25;

	process( CLOCK_25 )
	begin
			if rising_edge( CLOCK_25 ) then
				if h_count >= 144 and h_count < 784
				and v_count >= 39 and v_count < 519
				then
					red_o <= red_i;
					green_o <= green_i;
					blue_o <= blue_i;
					X_index <= (h_count - 144);
					Y_index <= (v_count - 39);
				else
					red_o <= "0000000000";
					green_o <= "0000000000";
					blue_o <= "0000000000";
				end if;

				if h_count > 0 and h_count < 97 then
					hs_o <= '0';
				else
					hs_o <= '1';
				end if;

				if v_count > 0 and v_count < 3 then
					vs_o <= '0';
				else
					vs_o <= '1';
				end if;

				h_count <= h_count + 1;
				if h_count = 800 then
					v_count <= v_count + 1;
					h_count <= 0;
				end if;

				if v_count = 521 then
					v_count <= 0;
				end if;
		end if;
	end process;
end architecture bmp;

