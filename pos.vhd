library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity pos is
	port(
		CLK		: in std_logic;
		x_neg	: in std_logic;
		x_pos	: in std_logic;
		y_neg	: in std_logic;
		y_pos	: in std_logic;
		z_neg	: in std_logic;
		z_pos	: in std_logic;
		
		x_out : out integer range 3 downto 0;
		y_out : out integer range 3 downto 0;
		z_out : out integer range 3 downto 0
	);
end entity pos;

architecture move of pos is

	signal x_plus : std_logic;
	signal x_minus : std_logic;
	signal y_plus : std_logic;
	signal y_minus : std_logic;
	signal z_plus : std_logic;
	signal z_minus : std_logic;
	
	signal x : integer range 2 downto 0;
	signal y : integer range 2 downto 0;
	signal z : integer range 2 downto 0;

begin

	process( CLK )
	begin
		if rising_edge( CLK ) then
			if x_plus = '1' then
				x <= x + 1;
			elsif x_minus = '1' then
				x <= x - 1;
			elsif y_plus = '1' then
				y <= y + 1;
			elsif y_minus = '1' then
				y <= y - 1;
			elsif z_plus = '1' then
				z <= z + 1;
			elsif z_minus = '1' then
				z <= z - 1;
			end if;
		end if;
	end process;
	
	x_out <= x;
	y_out <= y;
	z_out <= z;

	xp_button : edge_detector
	port map(
		CLK => CLK,
		sig => x_pos,
		edge => x_plus
	);
	xm_button : edge_detector
	port map(
		CLK => CLK,
		sig => x_neg,
		edge => x_minus
	);
	yp_button : edge_detector
	port map(
		CLK => CLK,
		sig => y_pos,
		edge => y_plus
	);
	ym_button : edge_detector
	port map(
		CLK => CLK,
		sig => y_neg,
		edge => y_minus
	);
	zp_button : edge_detector
	port map(
		CLK => CLK,
		sig => z_pos,
		edge => z_plus
	);
	zm_button : edge_detector
	port map(
		CLK => CLK,
		sig => z_neg,
		edge => z_minus
	);
end architecture move;

