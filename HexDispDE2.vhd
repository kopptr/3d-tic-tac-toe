LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY HexDispDE2 IS
	PORT (Number_in: in std_logic_vector(31 downto 0);
			HEXselect: in std_logic_vector(7 downto 0);
		   HEX0: out std_logic_vector(6 downto 0);
			HEX1: out std_logic_vector(6 downto 0);
			HEX2: out std_logic_vector(6 downto 0);
			HEX3: out std_logic_vector(6 downto 0);
			HEX4: out std_logic_vector(6 downto 0);
			HEX5: out std_logic_vector(6 downto 0);
			HEX6: out std_logic_vector(6 downto 0);
			HEX7: out std_logic_vector(6 downto 0));
END HexDispDE2;

architecture BEHAV_DISP of HexDispDE2 is

begin

Process (Number_in)

     begin
				
			  if (HEXselect(0) = '0') then
					 HEX0 <= "1111111";
					 
           elsif (Number_in(3 downto 0) = "0000") then
                HEX0 <= "1000000";

           elsif (Number_in(3 downto 0) = "0001") then
                HEX0 <= "1111001";
                
           elsif (Number_in(3 downto 0) = "0010") then
                HEX0 <= "0100100";
                
           elsif (Number_in(3 downto 0) = "0011") then
                HEX0 <= "0110000";
                
           elsif (Number_in(3 downto 0) = "0100") then
                HEX0 <= "0011001";
                
           elsif (Number_in(3 downto 0) = "0101") then
                HEX0 <= "0010010";
                
           elsif (Number_in(3 downto 0) = "0110") then
                HEX0 <= "0000010";
                
           elsif (Number_in(3 downto 0) = "0111") then
                HEX0 <= "1111000";
                
           elsif (Number_in(3 downto 0) = "1000") then
                HEX0 <= "0000000";                
                
           elsif (Number_in(3 downto 0) = "1001") then
                HEX0 <= "0011000";
                
           elsif (Number_in(3 downto 0) = "1010") then
                HEX0 <= "0001000";
                
           elsif (Number_in(3 downto 0) = "1011") then
                HEX0 <= "0000011";
           
           elsif (Number_in(3 downto 0) = "1100") then
                HEX0 <= "1000110";
                
           elsif (Number_in(3 downto 0) = "1101") then
                HEX0 <= "0100001";
                
           elsif (Number_in(3 downto 0) = "1110") then
                HEX0 <= "0000110";
                
           elsif (Number_in(3 downto 0) = "1111") then
                HEX0 <= "0001110";

           end if;
			  
			  if (HEXselect(1) = '0') then
					 HEX1 <= "1111111";
					 
           elsif (Number_in(7 downto 4) = "0000") then
                HEX1 <= "1000000";
					 
           elsif (Number_in(7 downto 4) = "0001") then
                HEX1 <= "1111001";
                
           elsif (Number_in(7 downto 4) = "0010") then
                HEX1 <= "0100100";
                
           elsif (Number_in(7 downto 4) = "0011") then
                HEX1 <= "0110000";
                
           elsif (Number_in(7 downto 4) = "0100") then
                HEX1 <= "0011001";
                
           elsif (Number_in(7 downto 4) = "0101") then
                HEX1 <= "0010010";
                
           elsif (Number_in(7 downto 4) = "0110") then
                HEX1 <= "0000010";
                
           elsif (Number_in(7 downto 4) = "0111") then
                HEX1 <= "1111000";
                
           elsif (Number_in(7 downto 4) = "1000") then
                HEX1 <= "0000000";                
                
           elsif (Number_in(7 downto 4) = "1001") then
                HEX1 <= "0011000";
                
           elsif (Number_in(7 downto 4) = "1010") then
                HEX1 <= "0001000";
                
           elsif (Number_in(7 downto 4) = "1011") then
                HEX1 <= "0000011";
           
           elsif (Number_in(7 downto 4) = "1100") then
                HEX1 <= "1000110";
                
           elsif (Number_in(7 downto 4) = "1101") then
                HEX1 <= "0100001";
                
           elsif (Number_in(7 downto 4) = "1110") then
                HEX1 <= "0000110";
                
           elsif (Number_in(7 downto 4) = "1111") then
                HEX1 <= "0001110";

           end if;
			  
			  if (HEXselect(2) = '0') then
					 HEX2 <= "1111111";
					 
           elsif (Number_in(11 downto 8) = "0000") then
                HEX2 <= "1000000";
					 
           elsif (Number_in(11 downto 8) = "0001") then
                HEX2 <= "1111001";
                
           elsif (Number_in(11 downto 8) = "0010") then
                HEX2 <= "0100100";
                
           elsif (Number_in(11 downto 8) = "0011") then
                HEX2 <= "0110000";
                
           elsif (Number_in(11 downto 8) = "0100") then
                HEX2 <= "0011001";
                
           elsif (Number_in(11 downto 8) = "0101") then
                HEX2 <= "0010010";
                
           elsif (Number_in(11 downto 8) = "0110") then
                HEX2 <= "0000010";
                
           elsif (Number_in(11 downto 8) = "0111") then
                HEX2 <= "1111000";
                
           elsif (Number_in(11 downto 8) = "1000") then
                HEX2 <= "0000000";                
                
           elsif (Number_in(11 downto 8) = "1001") then
                HEX2 <= "0011000";
                
           elsif (Number_in(11 downto 8) = "1010") then
                HEX2 <= "0001000";
                
           elsif (Number_in(11 downto 8) = "1011") then
                HEX2 <= "0000011";
           
           elsif (Number_in(11 downto 8) = "1100") then
                HEX2 <= "1000110";
                
           elsif (Number_in(11 downto 8) = "1101") then
                HEX2 <= "0100001";
                
           elsif (Number_in(11 downto 8) = "1110") then
                HEX2 <= "0000110";
                
           elsif (Number_in(11 downto 8) = "1111") then
                HEX2 <= "0001110";

           end if;
			  
			  if (HEXselect(3) = '0') then
					 HEX3 <= "1111111";
					 
           elsif (Number_in(15 downto 12) = "0000") then
                HEX3 <= "1000000";
					 
           elsif (Number_in(15 downto 12) = "0001") then
                HEX3 <= "1111001";
                
           elsif (Number_in(15 downto 12) = "0010") then
                HEX3 <= "0100100";
                
           elsif (Number_in(15 downto 12) = "0011") then
                HEX3 <= "0110000";
                
           elsif (Number_in(15 downto 12) = "0100") then
                HEX3 <= "0011001";
                
           elsif (Number_in(15 downto 12) = "0101") then
                HEX3 <= "0010010";
                
           elsif (Number_in(15 downto 12) = "0110") then
                HEX3 <= "0000010";
                
           elsif (Number_in(15 downto 12) = "0111") then
                HEX3 <= "1111000";
                
           elsif (Number_in(15 downto 12) = "1000") then
                HEX3 <= "0000000";                
                
           elsif (Number_in(15 downto 12) = "1001") then
                HEX3 <= "0011000";
                
           elsif (Number_in(15 downto 12) = "1010") then
                HEX3 <= "0001000";
                
           elsif (Number_in(15 downto 12) = "1011") then
                HEX3 <= "0000011";
           
           elsif (Number_in(15 downto 12) = "1100") then
                HEX3 <= "1000110";
                
           elsif (Number_in(15 downto 12) = "1101") then
                HEX3 <= "0100001";
                
           elsif (Number_in(15 downto 12) = "1110") then
                HEX3 <= "0000110";
                
           elsif (Number_in(15 downto 12) = "1111") then
                HEX3 <= "0001110";

           end if;
			  
			  if (HEXselect(4) = '0') then
					 HEX4 <= "1111111";
					 
           elsif (Number_in(19 downto 16) = "0000") then
                HEX4 <= "1000000";
					 
           elsif (Number_in(19 downto 16) = "0001") then
                HEX4 <= "1111001";
                
           elsif (Number_in(19 downto 16) = "0010") then
                HEX4 <= "0100100";
                
           elsif (Number_in(19 downto 16) = "0011") then
                HEX4 <= "0110000";
                
           elsif (Number_in(19 downto 16) = "0100") then
                HEX4 <= "0011001";
                
           elsif (Number_in(19 downto 16) = "0101") then
                HEX4 <= "0010010";
                
           elsif (Number_in(19 downto 16) = "0110") then
                HEX4 <= "0000010";
                
           elsif (Number_in(19 downto 16) = "0111") then
                HEX4 <= "1111000";
                
           elsif (Number_in(19 downto 16) = "1000") then
                HEX4 <= "0000000";                
                
           elsif (Number_in(19 downto 16) = "1001") then
                HEX4 <= "0011000";
                
           elsif (Number_in(19 downto 16) = "1010") then
                HEX4 <= "0001000";
                
           elsif (Number_in(19 downto 16) = "1011") then
                HEX4 <= "0000011";
           
           elsif (Number_in(19 downto 16) = "1100") then
                HEX4 <= "1000110";
                
           elsif (Number_in(19 downto 16) = "1101") then
                HEX4 <= "0100001";
                
           elsif (Number_in(19 downto 16) = "1110") then
                HEX4 <= "0000110";
                
           elsif (Number_in(19 downto 16) = "1111") then
                HEX4 <= "0001110";

           end if;
			  
			  if (HEXselect(5) = '0') then
					 HEX5 <= "1111111";
					 
           elsif (Number_in(23 downto 20) = "0000") then
                HEX5 <= "1000000";
					 
           elsif (Number_in(23 downto 20) = "0001") then
                HEX5 <= "1111001";
                
           elsif (Number_in(23 downto 20) = "0010") then
                HEX5 <= "0100100";
                
           elsif (Number_in(23 downto 20) = "0011") then
                HEX5 <= "0110000";
                
           elsif (Number_in(23 downto 20) = "0100") then
                HEX5 <= "0011001";
                
           elsif (Number_in(23 downto 20) = "0101") then
                HEX5 <= "0010010";
                
           elsif (Number_in(23 downto 20) = "0110") then
                HEX5 <= "0000010";
                
           elsif (Number_in(23 downto 20) = "0111") then
                HEX5 <= "1111000";
                
           elsif (Number_in(23 downto 20) = "1000") then
                HEX5 <= "0000000";                
                
           elsif (Number_in(23 downto 20) = "1001") then
                HEX5 <= "0011000";
                
           elsif (Number_in(23 downto 20) = "1010") then
                HEX5 <= "0001000";
                
           elsif (Number_in(23 downto 20) = "1011") then
                HEX5 <= "0000011";
           
           elsif (Number_in(23 downto 20) = "1100") then
                HEX5 <= "1000110";
                
           elsif (Number_in(23 downto 20) = "1101") then
                HEX5 <= "0100001";
                
           elsif (Number_in(23 downto 20) = "1110") then
                HEX5 <= "0000110";
                
           elsif (Number_in(23 downto 20) = "1111") then
                HEX5 <= "0001110";

           end if;
			  
			  if (HEXselect(6) = '0') then
					 HEX6 <= "1111111";
					 
           elsif (Number_in(27 downto 24) = "0000") then
                HEX6 <= "1000000";
					 
           elsif (Number_in(27 downto 24) = "0001") then
                HEX6 <= "1111001";
                
           elsif (Number_in(27 downto 24) = "0010") then
                HEX6 <= "0100100";
                
           elsif (Number_in(27 downto 24) = "0011") then
                HEX6 <= "0110000";
                
           elsif (Number_in(27 downto 24) = "0100") then
                HEX6 <= "0011001";
                
           elsif (Number_in(27 downto 24) = "0101") then
                HEX6 <= "0010010";
                
           elsif (Number_in(27 downto 24) = "0110") then
                HEX6 <= "0000010";
                
           elsif (Number_in(27 downto 24) = "0111") then
                HEX6 <= "1111000";
                
           elsif (Number_in(27 downto 24) = "1000") then
                HEX6 <= "0000000";                
                
           elsif (Number_in(27 downto 24) = "1001") then
                HEX6 <= "0011000";
                
           elsif (Number_in(27 downto 24) = "1010") then
                HEX6 <= "0001000";
                
           elsif (Number_in(27 downto 24) = "1011") then
                HEX6 <= "0000011";
           
           elsif (Number_in(27 downto 24) = "1100") then
                HEX6 <= "1000110";
                
           elsif (Number_in(27 downto 24) = "1101") then
                HEX6 <= "0100001";
                
           elsif (Number_in(27 downto 24) = "1110") then
                HEX6 <= "0000110";
                
           elsif (Number_in(27 downto 24) = "1111") then
                HEX6 <= "0001110";

           end if;
			  
			  if (HEXselect(7) = '0') then
					 HEX7 <= "1111111";
					 
           elsif (Number_in(31 downto 28) = "0000") then
                HEX7 <= "1000000";
					 
           elsif (Number_in(31 downto 28) = "0001") then
                HEX7 <= "1111001";
                
           elsif (Number_in(31 downto 28) = "0010") then
                HEX7 <= "0100100";
                
           elsif (Number_in(31 downto 28) = "0011") then
                HEX7 <= "0110000";
                
           elsif (Number_in(31 downto 28) = "0100") then
                HEX7 <= "0011001";
                
           elsif (Number_in(31 downto 28) = "0101") then
                HEX7 <= "0010010";
                
           elsif (Number_in(31 downto 28) = "0110") then
                HEX7 <= "0000010";
                
           elsif (Number_in(31 downto 28) = "0111") then
                HEX7 <= "1111000";
                
           elsif (Number_in(31 downto 28) = "1000") then
                HEX7 <= "0000000";                
                
           elsif (Number_in(31 downto 28) = "1001") then
                HEX7 <= "0011000";
                
           elsif (Number_in(31 downto 28) = "1010") then
                HEX7 <= "0001000";
                
           elsif (Number_in(31 downto 28) = "1011") then
                HEX7 <= "0000011";
           
           elsif (Number_in(31 downto 28) = "1100") then
                HEX7 <= "1000110";
                
           elsif (Number_in(31 downto 28) = "1101") then
                HEX7 <= "0100001";
                
           elsif (Number_in(31 downto 28) = "1110") then
                HEX7 <= "0000110";
                
           elsif (Number_in(31 downto 28) = "1111") then
                HEX7 <= "0001110";

           end if;
			  
	end process;

	  

end architecture BEHAV_DISP;