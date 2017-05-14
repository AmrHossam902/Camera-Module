library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity DMA is 
port (
		clk,rst: IN std_logic;
		start_DMA: IN std_logic;
		Data_in: IN std_logic_vector(127 downto 0); --NVM data
		NVM_addr_in: IN std_logic_vector(11 downto 0); -- NVM address from cache
		zero, one: in std_logic;
		write_signal,Ack: OUT std_logic; --,Row_Done,Rows_Done 
		Data_out: OUT std_logic_vector(7 downto 0); -- out to cache
		cache_addr: OUT std_logic_vector(7 downto 0); 
		NVM_addr_out: OUT std_logic_vector(11 downto 0) --out to NVM
		
);
end DMA;

architecture DMA_ARC of DMA is 

COMPONENT nbit_Register IS
  Generic(n: integer := 16);
	PORT( Clk,rst, enable : IN std_logic;
		  d, rst_value: IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT nbit_adder IS
       GENERIC (n : integer := 16);
PORT(a,b : IN std_logic_vector(n-1  DOWNTO 0);
             cin : IN std_logic;  
            add_out : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT nbit_mux2x1 is
		Generic(n: Integer :=8);
     port(
         input1, input2: in STD_LOGIC_VECTOR(n-1 downto 0);
         s0 : in std_logic;
         output : out STD_LOGIC_VECTOR(n-1 downto 0));
end COMPONENT;

COMPONENT mux16x1 is
     port(
         x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15 : in STD_LOGIC_VECTOR(7 downto 0);
         sel : in STD_LOGIC_VECTOR(3 downto 0);
         y : out STD_LOGIC_VECTOR(7 downto 0)
         );
end COMPONENT;
COMPONENT DMACU is
   port(
      clk, reset,start_DMA,Rows_Done,Row_Done: in std_logic;
      signals: out std_logic_vector(5 downto 0)
    );
end COMPONENT;
-- declare signals if needed 
signal cache_adder_out:std_logic_vector(7 downto 0);
signal cache_address_out:std_logic_vector(7 downto 0);
signal NVM_adder_out:std_logic_vector(11 downto 0);
signal NVM_address_Mux_out:std_logic_vector(11 downto 0);
signal NVM_address_out:std_logic_vector(11 downto 0);
signal row_done:std_logic;
signal rows_done, delayed_rows_done :std_logic;
signal signals:std_logic_vector(5 downto 0);
signal zeros: std_logic_vector(11 downto 0);
signal amount16: std_logic_vector(11 downto 0);
signal rows_done_v: std_logic_vector(1 downto 0);
signal delayed_rows_done_v : std_logic_vector(0 downto 0);

begin
	row_done<= cache_address_out(0)  AND cache_address_out(1) AND cache_address_out(2) AND cache_address_out(3);
	rows_done<= cache_address_out(4) AND cache_address_out(5) AND cache_address_out(6) AND cache_address_out(7);
	write_signal<=signals(5);
	Ack<=signals(0);
	cache_addr<=cache_address_out;
	NVM_addr_out<=NVM_address_out;
	
	zeros <= zero&zero&zero&zero&zero&zero&zero&zero&zero&zero&zero&zero;
	amount16 <= zero&zero&zero&zero&zero&zero&zero& one &zero&zero&zero&zero;
	
	rows_done_v <= zero&rows_done;
	delayed_rows_done <= delayed_rows_done_v(0);
	

	controlUnit: DMACU PORT MAP(clk,rst,start_DMA, delayed_rows_done ,row_done,signals);
	R_delayed_rows_done: nbit_Register generic map(1) port map(clk, signals(1), one, rows_done_v(0 downto 0), zeros(0 downto 0), delayed_rows_done_v(0 downto 0));
	R_Cache_addr: nbit_register GENERIC MAP (8) port map (clk,signals(1),signals(2),cache_adder_out,zeros(7 downto 0),cache_address_out);   
	R_NVM_addr: nbit_register GENERIC MAP (12) port map (clk,signals(1),signals(3),NVM_address_Mux_out, zeros ,NVM_address_out) ;
	u1: nbit_adder GENERIC MAP (8)PORT MAP(cache_address_out,zeros(7 downto 0) , one ,cache_adder_out);
	u2: nbit_adder GENERIC MAP (12) PORT MAP(NVM_address_out, amount16 , zero ,NVM_adder_out);

	u3: mux16x1 PORT MAP(  Data_in(127 downto 120),  Data_in(119 downto 112), Data_in(111 downto 104),Data_in(103 downto 96),
						    Data_in(95 downto 88), Data_in(87 downto 80), Data_in(79 downto 72), Data_in(71 downto 64), 
						    Data_in(63 downto 56), Data_in(55 downto 48), Data_in(47 downto 40), Data_in(39 downto 32),  
						    Data_in(31 downto 24), Data_in(23 downto 16), Data_in(15 downto 8), Data_in(7 downto 0),
						    cache_address_out(3 downto 0),Data_out);
						 
	u4: nbit_mux2x1 GENERIC MAP (12) PORT MAP(NVM_adder_out, NVM_addr_in,signals(4),NVM_address_Mux_out);
end DMA_ARC;
