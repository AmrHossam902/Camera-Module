library ieee;
use ieee.std_logic_1164.all;

entity sub is
	port(A, B: in std_logic_vector(17 downto 0);
	     zero, one: in std_logic;
	     sub_value: out std_logic_vector(17 downto 0));
end sub;

architecture sub_ARC of sub is

--components 

-- ADDER
component nbit_adder IS
       GENERIC (n : integer := 16);
PORT(a,b : IN std_logic_vector(n-1  DOWNTO 0);
             cin: IN std_logic;  
            add_out : OUT std_logic_vector(n-1 DOWNTO 0));
END component;

-- 2X1 MUX
-- nbit_mux2x1 is
		-- Generic(n: Integer :=8);
     -- port(
         -- input1, input2: in STD_LOGIC_VECTOR(n-1 downto 0);
         -- s0 : in std_logic;
         -- output : out STD_LOGIC_VECTOR(n-1 downto 0));
-- end component;


--signals
signal B_bar : std_logic_vector(17 downto 0);
signal Adder1_value, Adder2_value,Adder1_value_bar : std_logic_vector(17 downto 0);
signal zeros: std_logic_vector(17 downto 0);
begin

zeros <= zero &zero &zero &zero &zero &zero &zero &zero &zero &zero &zero &zero &zero &
	zero &zero &zero &zero &zero;
	
Adder1_sub: nbit_adder generic map(18) port map(A, B_bar, one, Adder1_value);
Adder2_sub: nbit_adder generic map(18) port map(Adder1_value_bar, zeros, one, Adder2_value);	

B_bar <= not B;
Adder1_value_bar <= not Adder1_value;

sub_value <= Adder2_value when Adder1_value(16) = '1'
else		Adder1_value;


 	
end sub_ARC;
