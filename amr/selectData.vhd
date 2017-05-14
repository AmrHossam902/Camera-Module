library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selectData is
   port(
      inc_dec: in std_logic;
	  s: in std_logic_vector(1 downto 0);
	  address:in std_logic_vector(7 downto 0);
      func: out std_logic
    );
end selectData;

architecture selectData_ARC of selectData is
begin
	process(address,s,inc_dec)
	begin
	--first row
	if address(7 downto 4)="0000" then
				--first column
				if address(3 downto 0)="0000" AND ((s="10" AND inc_dec='1') OR (s="01" AND inc_dec='1'))then
					func<='0';
				--last column
				elsif address(3 downto 0)="1111"  AND ((s="10" AND inc_dec='1') OR (s="01" AND inc_dec='0')) then
					func<='0';
				-- any column else
				elsif  s="10" AND inc_dec='1' then
					func<='0';
				else 
					func<='1';					
				end if;
	--lasr row	
	elsif address(7 downto 4)="1111" then
				--first column
				if address(3 downto 0)="0000"  AND ((s="10" AND inc_dec='0') OR (s="01" AND inc_dec='1')) then
					func<='0';
				--last column
				elsif address(3 downto 0)="1111" AND ((s="10" AND inc_dec='0') OR (s="01" AND inc_dec='0'))  then
					func<='0';
				-- any column else
				elsif s="10" AND inc_dec='0' then
					func<='0';
				else 
					func<='1';
				end if;
	-- any row else
	else 
				--first column
				if address(3 downto 0)="0000" AND (s="01" AND inc_dec='1') then
					func<='0';
				--last column
				elsif address(3 downto 0)="1111"  AND (s="01" AND inc_dec='0')then
					func<='0';
				-- any column else
				else 
					func<='1';
				end if;
		end if;
	end process;
end selectData_ARC;