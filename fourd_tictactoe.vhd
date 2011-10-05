library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ttt_ram_package.all;
use work.NESController;
use work.pos;
use work.ttt_board;
use work.display_controller;
use work.vga_controller;
use work.edge_detector;
use work.HexDispDE2;
use work.Win_Check;
use work.SRAM_interface;

entity fourd_tictactoe is
	port(
		-- Debugging
			LEDG : out std_logic_vector(8 downto 0);
			LEDR : out std_logic_vector(17 downto 0);
			KEY : in stD_logic_vector(0 downto 0);

			CLOCK_50 : in std_logic;
			VGA_R : out std_logic_vector(9 downto 0);
			VGA_B : out std_logic_vector(9 downto 0);
			VGA_G : out std_logic_vector(9 downto 0);
			VGA_BLANK : out std_logic;
			VGA_SYNC : out std_logic;
			VGA_CLK	: out std_logic;
			VGA_HS : out std_logic;
			VGA_VS : out std_logic;
			HEX0	: out std_logic_vector( 6 downto 0);
			HEX1	: out std_logic_vector( 6 downto 0);
			HEX2	: out std_logic_vector( 6 downto 0);
			HEX3	: out std_logic_vector( 6 downto 0);
			HEX4	: out std_logic_vector( 6 downto 0);
			HEX5	: out std_logic_vector( 6 downto 0);
			HEX6	: out std_logic_vector( 6 downto 0);
			HEX7	: out std_logic_vector( 6 downto 0);
			GPIO_1: inout std_logic_vector(35 downto 0);
			SRAM_ADDR	: OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
			SRAM_DQ  	: INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			SRAM_OE_N	: OUT STD_LOGIC;
			SRAM_WE_N	: OUT STD_LOGIC;
			SRAM_CE_N	: OUT STD_LOGIC;
			SRAM_UB_N	: OUT STD_LOGIC;
			SRAM_LB_N	: OUT STD_LOGIC
		);
end entity fourd_tictactoe;


architecture ttt of fourd_tictactoe is

	signal CLOCK_25 : stD_logic;
	signal x_addr : integer range 639 downto 0;
	signal y_addr : integer range 479 downto 0;
	signal segx	: std_logic_vector( 1 downto 0 );
	signal segy	: std_logic_vector( 1 downto 0 );
	signal segz	: std_logic_vector( 1 downto 0 );
	signal cursorx	: integer range 3 downto 0;
	signal cursory	: integer range 3 downto 0;
	signal cursorz	: integer range 3 downto 0;
	signal r : std_logic;
	signal g : std_logic;
	signal b : std_logic;
	signal color_v : stD_logic_vector( 2 downto 0 );

	signal slow_clock : std_logic;

	-- Buttons
	signal A_b : std_logic;
	signal B_b : std_logic;
	signal up_b : std_logic;
	signal down_b : std_logic;
	signal left_b : std_logic;
	signal right_b : std_logic;
	signal start_b : std_logic;
	signal select_b : std_logic;

	signal start_edge : std_logic;
	signal p1_turn : std_logic;
	signal board	: ttt_ram;
	signal win : std_logic;

	signal score_edge : stD_logic;
	signal draw : std_logic;

	signal p1_score_o : std_logic_vector(7 downto 0);
	signal p2_score_o : std_logic_vector(7 downto 0);
	-- Wins
	signal p1_wins : integer range 255 downto 0 := 0;
	signal p2_wins : integer range 255 downto 0 := 0;

begin

	-- System Inputs
	nes : NESController
	port map(
				CLOCK_50 => CLOCK_50,
				A => A_b,
				B => B_b,
				Select_but => select_b,
				Start => start_b,
				up => down_b, -- These seem reversed,
				down => up_b, -- but I promise they are correct.
				left => left_b,
				right => right_b,
				GPIO_1 => GPIO_1
			);

	cursor : pos
	port map(
				CLK => CLOCK_50,
				x_neg => left_b,
				x_pos => right_b,
				y_neg => down_b,
				y_pos => up_b,
				z_neg => B_b,
				z_pos => A_b,

				x_out => cursorx,
				y_out => cursory,
				z_out => cursorz
			);

	-- Logic
	Board_RAM : ttt_board
	port map(
				CLOCK_50 => CLOCK_50,
				color_enable => '1',
				x_col => conv_integer(segx),
				y_col => conv_integer(segy),
				z_col => conv_integer(segz),
				color => color_v,
				x_up => cursorx,
				y_up => cursory,
				z_up => cursorz,
		--cursor_o => ,
				p1_turn => p1_turn,
				CLR => (not KEY(0)) or (not select_b),
				place_edge => start_edge and (not win),
				board => board
			);

	-- System Outputs
	TTT_board : display_controller
	port map (
				 clk => CLOCK_50,
				 X_addr => x_addr,
				 Y_addr => y_addr,
				 color_i => color_v,
				 x_o => segx,
				 y_o => segy,
				 z_o => segz,
				 r_o => r,
				 g_o => g,
				 b_o => b,
				 flash_en => win,
				 flash_col => p1_turn
			 );

	VGA : vga_controller
	port map (
				 CLOCK_50 => CLOCK_50,
				 red_i	=> r&r&r&r&r&r&r&r&r&r,
				 green_i => g&g&g&g&g&g&g&g&g&g,
				 blue_i => b&b&b&b&b&b&b&b&b&b,
				 red_o => VGA_R,
				 green_o => VGA_G,
				 blue_o => VGA_B,
				 hs_o => VGA_HS,
				 vs_o => VGA_VS,
				 vga_clk => VGA_CLK,
				 vga_sync => VGA_SYNC,
				 vga_blank => VGA_BLANK,
				 X_index => x_addr,
				 Y_index => y_addr,
				 refresh_clock => CLOCK_25
			 );

	startbtn : edge_detector
	port map(
				CLK => CLOCK_50,
				sig => start_b,
				edge => start_edge
			);

	win_edge : edge_detector
	port map(
				CLK => slow_clock,
				sig => win,
				edge => score_edge
			);

	disps : HexDispDE2
	port map(
		Number_in => "00000001" & conv_std_logic_vector(p1_wins,8) &
					"00000010" & conv_std_logic_vector(p2_wins,8),
		HEXselect => "11111111",
		HEX0 => HEX0,
		HEX1 => HEX1,
		HEX2 => HEX2,
		HEX4 => HEX4,
		HEX5 => HEX5,
		HEX6 => HEX6
	);

	Winners : Win_Check
	port map(
		CLOCK => CLOCK_50,
		board => board,
		win => win,
		draw => draw
	);

	score : SRAM_interface
	port map(
				iCLK => CLOCK_50,
				p1 => p1_turn,
				clear => not KEY(0),
				enable => score_edge,
				p1_score => p1_score_o,
				oCLK => slow_clock,
				p2_score => p2_score_o,
				SRAM_ADDR => SRAM_ADDR,
				SRAM_DQ => SRAM_DQ,
				SRAM_OE_N => SRAM_OE_N,
				SRAM_WE_N => SRAM_WE_N,
				SRAM_CE_N => SRAM_CE_N,
				SRAM_UB_N => SRAM_UB_N,
				SRAM_LB_N => SRAM_LB_N
			);

	p1_wins <= conv_integer( p1_score_o );
	p2_wins <= conv_integer( p2_score_o);

	LEDG(7 downto 0) <= (others=>(p1_turn and not win));
	LEDR(7 downto 0) <= (others=> (not p1_turn and not win));

	HEX7 <= "0001100";
	HEX3 <= "0001100";
	LEDG(8) <= win;
	LEDR(17) <= draw;
end architecture ttt;
