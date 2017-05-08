library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nbit_mux2x1 is
		Generic(n: Integer :=8);
     port(
         input1, input2: in STD_LOGIC_VECTOR(n-1 downto 0);
         s0 : in std_logic;
         output : out STD_LOGIC_VECTOR(n-1 downto 0));
end nbit_mux2x1;

architecture nbit_mux2x1_arc of nbit_mux2x1 is
begin
    output <= input1 when s0 = '0' else
              input2 when s0 = '1';
end nbit_mux2x1;
