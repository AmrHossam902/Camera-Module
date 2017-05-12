library ieee;
use ieee.std_logic_1164.all;


entity inc_dec_module is
	port(A, amount:in std_logic_vector(7 downto 0);
		 inc_dec:in std_logic;
		 output:out std_logic_vector(7 downto 0));
end inc_dec_module;


architecture inc_dec_module_ARC of inc_dec_module is

component nbit_adder IS
       GENERIC (n : integer := 16);
PORT(a,b : IN std_logic_vector(n-1  DOWNTO 0);
             cin : IN std_logic;  
            add_out : OUT std_logic_vector(n-1 DOWNTO 0));
END component;

signal amount_to_adder: std_logic_vector(7 downto 0);

begin

amount_to_adder <= amount when inc_dec = '0'
	else		not amount;

u: nbit_adder generic map(8) port map(A, amount_to_adder, inc_dec, output);	

end inc_dec_module_ARC;

