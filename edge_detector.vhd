library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity edge_detector is
	port(
		CLK : in std_logic;
		sig : in std_logic;
		edge : out std_logic
	);
end entity edge_detector;

architecture threebuf of edge_detector is
	signal shift_reg : stD_logic_vector( 2 downto 0 );
begin

	process( CLK )
	begin
		if rising_edge( CLK ) then
			shift_reg(2) <= shift_Reg(1);
			shift_reg(1) <= shift_Reg(0);
			shift_reg(0) <= sig;
		end if;
	end process;

	edge <= not shift_reg(2) and shift_reg(1);
end architecture threebuf;
			
