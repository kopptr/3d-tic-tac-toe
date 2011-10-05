library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use work.all;


entity SRAM_interface is
	port(
		    iCLK	: in std_logic;
		    p1		: in std_logic;
		    enable	: in std_logic;
			 clear	: in std_logic;
		    oCLK 	: OUT STD_LOGIC;
		    p1_score	: OUT STD_LOGIC_VECTOR(7 downto 0);
		    p2_score	: OUT STD_LOGIC_VECTOR(7 downto 0);

		    SRAM_ADDR	: OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
		    SRAM_DQ  	: INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		    SRAM_OE_N	: OUT STD_LOGIC;
		    SRAM_WE_N	: OUT STD_LOGIC;
		    SRAM_CE_N	: OUT STD_LOGIC;
		    SRAM_UB_N	: OUT STD_LOGIC;
		    SRAM_LB_N	: OUT STD_LOGIC
	    );
END entity SRAM_interface;

architecture theram of SRAM_interface is

signal slow_clock : std_logic;
signal counter : integer range 2 downto 0 := 0;
signal write_new_score : std_logic := '0';
signal con_read	:std_logic;
signal con_write	:std_logic;
signal p1_half		:std_logic_vector(7 downto 0);
signal p2_half		:std_logic_vector(7 downto 0);
signal p1_score_S	:std_logic_vector(7 downto 0);
signal p2_score_S	:std_logic_vector(7 downto 0);
signal foo : std_logic;

begin
	SRAM : SRAM_16bit_512k
	port map(
			iCLK =>iCLK,
			iREAD	=>con_read,
			iWRITE	=>con_write,
			iADDR => "000000000000000000",
			iDATA => p1_half & p2_half,
			UB_N => '1',
			LB_N => '1',

			oDATA(15 downto 8) => p1_score_S,
			oDATA(7 downto 0 ) => p2_score_S,
			oCLK => slow_clock,

			SRAM_ADDR => SRAM_ADDR,
			SRAM_DQ => SRAM_DQ,
			SRAM_OE_N => SRAM_OE_N,
			SRAM_WE_N => SRAM_WE_N,
			SRAM_CE_N => SRAM_CE_N,
			SRAM_UB_N => SRAM_UB_N,
			SRAM_LB_N => SRAM_LB_N
		);

	oCLK <= slow_clock;

	process( slow_clock )
	begin
		if rising_edge(slow_clock) then
			if clear = '1' then
				con_read <= '0';
				con_write <= '1';
				p1_half <= "00000000";
				p2_half <= "00000000";
				write_new_score <= '0';
			elsif write_new_score = '1' then
					if counter = 0 then
						con_read <= '1';
						con_write <= '0';
						counter <= 1;
					elsif counter = 1 then
						con_write <= '1';
						con_read <= '0';
						if p1 = '1' then
							p1_half <= p1_half + 1;
						else
							p2_half <= p2_half + 1;
						end if;
						counter <= 2;
					else
						p1_score<= p1_half;
						p2_score<= p2_half;
						con_read <= '1';
						con_write <= '0';
						write_new_score <= '0';
					end if;
			elsif enable = '1' then
				write_new_score <='1';
				counter <= 0;
			else
				con_read <= '1';
				con_write <= '0';
				write_new_score <= '0';
				p1_score<= p1_half;
				p2_score<= p2_half;
			end if;
		end if;
	end process;
end architecture theram;


