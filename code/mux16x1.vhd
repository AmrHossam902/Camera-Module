library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux16x1 is
     port(
         x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 : in STD_LOGIC_VECTOR(7 downto 0);
         sel : in STD_LOGIC_VECTOR(3 downto 0);
         y : out STD_LOGIC_VECTOR(7 downto 0)
         );
end mux16x1;

architecture multiplexer16_1_arc of mux16x1 is
begin
   
    y <=    x0 when (sel="0000") else
            x1 when (sel="0001") else
            x2 when (sel="0010") else
            x3 when (sel="0011") else
            x4 when (sel="0100") else
            x5 when (sel="0101") else
            x6 when (sel="0110") else
            x7 when (sel="0111") else
			x8 when (sel="1000") else
            x9 when (sel="1001") else
            x10 when (sel="1010") else
            x11 when (sel="1011") else
            x12 when (sel="1100") else
            x13 when (sel="1101") else
            x14 when (sel="1110") else
			x15 ;
			

end multiplexer16_1_arc;