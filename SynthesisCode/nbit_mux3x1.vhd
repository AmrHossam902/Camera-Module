library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nbit_mux3x1 is
		Generic(n: Integer :=8);
     port(
         input1, input2, input3: in STD_LOGIC_VECTOR(n-1 downto 0);
         s : in std_logic_vector(1 downto 0);
         output : out STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_mux3x1;

architecture nbit_mux3x1_arc of nbit_mux3x1 is
begin
    output <= input1 when s = "00" else
              input2 when s = "01" else
	      input3; 
end nbit_mux3x1_arc;
