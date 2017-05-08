library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity DMACU is
   port(
      clk, reset,start_DMA,Rows_Done,Row_Done: in std_logic;
      signals: out std_logic_vector(5 downto 0)
    );
end DMACU;

architecture DMACU_ARC of DMACU is 

	type state_type is (rst,idle,ld_addr,write_st,inc_NVM_addr,send_ACK);
	signal state: state_type;
	begin
	state_proc : process(clk,reset)
	begin
		if reset='1' then
			state<=rst;
		elsif (clk'event AND clk='1') then
		
			case state is 
					when rst=>
								state<=idle;
					when idle=>
							if start_DMA='1' then
								state<=ld_addr;
							else 
								state<= state;
							end if;
					when ld_addr=>
							 state<=write_st;
					when write_st=>
							  if Row_Done='1' then 
								state<=inc_NVM_addr;
							   else
							   state<= state;
							   end if;
					when inc_NVM_addr=>
								if Rows_Done='1' then
									state<=send_ACK;
								else 
									state<= write_st;
								end if;
					when send_ACK=>
									state<= rst;
			end case;
		end if;
	end process;
	
	output_proc: process(state)
	begin
		case state is
		--signals -- write , s0, NVM En,Cache En, rst, ack
			when rst=>
					signals<="000010";
			when idle=>
					signals<="000000";
			when ld_addr=>
					signals<="011000";
			when write_st=>
					signals<="100100";					
			when inc_NVM_addr=>
					signals<="001000";
			when send_ACK=>
					signals<="000001";					
		end case;
	end process;
end DMACU_ARC;