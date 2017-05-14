library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY NVM IS
 PORT ( clk , rst : IN std_logic;
	   address : IN std_logic_vector(11 DOWNTO 0);
	   dataout : OUT std_logic_vector(127 DOWNTO 0));
END NVM;


ARCHITECTURE NVM_ARC OF NVM IS  
BEGIN
		
END NVM_ARC;
