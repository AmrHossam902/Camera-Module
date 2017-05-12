LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY CacheMemory IS
 PORT (clk, rst, write_en : IN std_logic;
	   address : IN std_logic_vector(7 DOWNTO 0);
		datain : IN std_logic_vector(7 DOWNTO 0);
	   dataout : OUT std_logic_vector(7 DOWNTO 0));
END CacheMemory;



ARCHITECTURE CacheMemory_ARC OF CacheMemory IS  
TYPE ram_type IS ARRAY(0 TO 255) of std_logic_vector(7 DOWNTO 0);
     SIGNAL ram : ram_type ;
BEGIN
PROCESS(clk) IS  
BEGIN
	IF rst = '1' then
			ram <= ((others=> (others=>'0')));
    elsif clk'event and clk='1' THEN   
          IF write_en = '1' THEN        	
			ram(to_integer(unsigned((address)))) <= datain;  
          END IF;
   END IF;
END PROCESS;
        dataout <= ram(to_integer(unsigned((address))));
		
END CacheMemory_ARC;