library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.ttt_ram_package.all;


entity Win_Check is
	port (
			CLOCK	:	std_logic;
			board	:	in ttt_ram;
			win	:	out std_logic;
			draw	:	out std_logic
		 );
end entity;

architecture four_x_four of Win_Check is
begin
	process(CLOCK)
	begin
      win <= '0';
		draw <= '1';
		for i in 3 downto 0 loop
			for j in 3 downto 0 loop
				if	(-- straight in Z
					board(i,j,0) /= 0 and board(i,j,0) = board(i,j,1) and
					board(i,j,0) = board(i,j,2) and board(i,j,0) = board(i,j,3)
					) or ( -- straight in Y
					board(i,0,j) /= 0 and board(i,0,j) = board(i,1,j) and
					board(i,0,j) = board(i,2,j) and board(i,0,j) = board(i,3,j)
					) or (-- straight in X
					board(0,i,j) /= 0 and board(0,i,j) = board(1,i,j) and
					board(0,i,j) = board(2,i,j) and board(0,i,j) = board(3,i,j)
					) or ( -- diagonal with fixed z -- negative slope
					board(0,0,i) /= 0 and board(0,0,i) = board(1,1,i) and
					board(0,0,i) = board(2,2,i) and board(0,0,i) = board(3,3,i)
					) or ( -- diagonal with fixed z -- positive slope
					board(0,3,i) /= 0 and board(0,3,i) = board(1,2,i) and
					board(0,3,i) = board(2,1,i) and board(0,3,i) = board(3,0,i)
					) or ( -- diagonal with fixed y -- negative slope
					board(0,i,0) /= 0 and board(0,i,0) = board(1,i,1) and
					board(0,i,0) = board(2,i,2) and board(0,i,0) = board(3,i,3)
					) or ( -- diagonal with fixed y -- positive slope
					board(0,i,3) /= 0 and board(0,i,3) = board(1,i,2) and
					board(0,i,3) = board(2,i,1) and board(0,i,3) = board(3,i,0)
					) or ( -- diagonal with fixed x -- negative slope
					board(i,0,0) /= 0 and board(i,0,0) = board(i,1,1) and
					board(i,0,0) = board(i,2,2) and board(i,0,0) = board(i,3,3)
					) or ( -- diagonal with fixed x -- positive slope
					board(i,0,3) /= 0 and board(i,0,3) = board(i,1,2) and
					board(i,0,3) = board(i,2,1) and board(i,0,3) = board(i,3,0)
					) or ( -- diagonal across x,y,z
					board(0,0,0) /= 0 and board(0,0,0) = board(1,1,1) and
					board(0,0,0) = board(2,2,2) and board(0,0,0) = board(3,3,3)
					) or ( -- diagonal across x,y,z
					board(3,3,0) /= 0 and board(3,3,0) = board(2,2,1) and
					board(3,3,0) = board(1,1,2) and board(3,3,0) = board(0,0,3)
					) or ( -- diagonal across x,y,z
					board(0,3,0) /= 0 and board(0,3,0) = board(1,2,1) and
					board(0,3,0) = board(2,1,2) and board(0,3,0) = board(3,0,3)
					) or ( -- diagonal across x,y,z
					board(3,0,0) /= 0 and board(3,0,0) = board(2,1,1) and
					board(3,0,0) = board(1,2,2) and board(3,0,0) = board(0,3,3)
					)
				then
					win <= '1';
				end if;
			end loop;
		end loop;
		
		for i in 3 downto 0 loop
			for j in 3 downto 0 loop
				for k in 3 downto 0 loop
					if board(i,j,k) = 0 then
						draw <= '0';
					end if;
				end loop;
			end loop;
		end loop;
	end process;
end architecture four_x_four;
