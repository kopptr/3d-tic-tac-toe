library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;

package ttt_ram_package is
type ttt_ram is array( integer range 3 downto 0,
						integer range 3 downto 0,
						integer range 3 downto 0 )
							of integer range 2 downto 0;
end package ttt_ram_package;
