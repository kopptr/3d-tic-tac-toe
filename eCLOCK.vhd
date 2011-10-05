library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity eCLOCK is
	generic( count : integer := 49999999; dc_count : integer := 24999999 );
	port(
		    CLOCK_50MHz :in std_logic;
		    eCLOCK   	:out std_logic);
end eCLOCK;

architecture counterclock of eCLOCK is
	signal num: integer range 0 to count;
	signal dc : integer range 0 to dc_count;
begin
	process(CLOCK_50MHz)
	begin
		if rising_edge(CLOCK_50MHz) then
			if num = count then
				num <= 0;
				dc <= 0;
				eCLOCK <= '1';
				
			elsif dc = dc_count then
			dc <= 0;
			eCLOCK <= '0';
			num <= num + 1;
		else
			num <= num + 1;
			dc <= dc + 1;
		end if;
	end if;
end process;
end architecture counterclock;
