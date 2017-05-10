library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY NVM IS
 PORT (rst : IN std_logic;
	   address : IN std_logic_vector(11 DOWNTO 0);
	   dataout : OUT std_logic_vector(127 DOWNTO 0));
END NVM;


ARCHITECTURE NVM_ARC OF NVM IS  
TYPE ram_type IS ARRAY(0 TO 4095) of std_logic_vector(127 DOWNTO 0);
     SIGNAL ram : ram_type ;
BEGIN
PROCESS(rst) IS  
BEGIN
	IF rst = '1' then
			ram <= ((others=> (others=>'0')));
   END IF;
END PROCESS;
        dataout <= ram(to_integer(unsigned((address))));
		
END NVM_ARC;
