 library ieee;
USE ieee.std_logic_1164.all ;
use work.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NEScontroller is
	port( 
			CLOCK_50 	: in stD_logic;
			A				: out std_logic;
			B				: out std_logic;
			Select_but	: out std_logic;
			Start			: out std_logic;
			up				: out std_logic;
			down			: out std_logic;
			left			: out std_logic;
			right			: out std_logic;
			GPIO_1: inout std_logic_vector(35 downto 0));
end entity NEScontroller;

architecture Main of NEScontroller is
	signal sigX : std_logic_vector(7 downto 0);
	signal sigY : std_logic_vector(7 downto 0);
	signal clock_sig : stD_logic;
	signal latch_sig : stD_logic;
	signal falling_latch	: std_logic_vector(1 downto 0);
	signal rising_clock	: std_logic_vector(1 downto 0);
	signal data		:std_logic;
	signal shiftdata	:std_logic_vector(7 downto 0);
	signal num: integer range 0 to 8;
	begin	
	
latch : eCLOCK
	generic map( count => 850000, dc_count => 800000	)
	port map(
					CLOCK_50MHz => CLOCK_50,
					eCLOCK => latch_sig );
					
clock : eCLOCK
	generic map( count => 500, dc_count => 200	)
	port map(
					CLOCK_50MHz => CLOCK_50,
					eCLOCK => clock_sig );

		process(CLOCK_50)
			begin
			if rising_edge(CLOCK_50) then
				rising_clock(0) <= rising_clock(1);
				rising_clock(1) <= clock_sig;
				falling_latch(0) <= falling_latch(1);
				falling_latch(1) <= latch_sig;
				if rising_clock(1) = '1' and rising_clock(0) = '0' and num < 8 then
					shiftdata(0)	<= shiftdata(1);	--A
					shiftdata(1)	<= shiftdata(2);	--B
					shiftdata(2)	<= shiftdata(3);	--Select
					shiftdata(3)	<= shiftdata(4);	--Start
					shiftdata(4)	<= shiftdata(5);	--Up
					shiftdata(5)	<= shiftdata(6);	--Down
					shiftdata(6)	<= shiftdata(7);	--Left
					shiftdata(7)	<= data;				--Right
					num <= num+1;
				elsif num = 8 then
					A 				<=	shiftdata(0);
					B 				<=	shiftdata(1);
					Select_but 	<=	shiftdata(2);
					Start 		<=	shiftdata(3);
					up 			<=	shiftdata(4);
					down 			<=	shiftdata(5);
					left 			<=	shiftdata(6);
					right 		<=	shiftdata(7);
				end if;
				if falling_latch(0) = '1' and falling_latch(1) = '0' then
					num <= 0;
				end if;
				
			end if;
		end process;
		GPIO_1(16) <=clock_sig; --pulse the clock
		GPIO_1(14) <= latch_sig;	--latch the buttons
		data			<= GPIO_1(18);
		
	
end architecture Main;
