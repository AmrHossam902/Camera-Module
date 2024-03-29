library ieee;
use ieee.std_logic_1164.all;

entity module_CU is
	port(input:in std_logic_vector(5 downto 0);
		 signals:out std_logic_vector(16 downto 0);
		 state_out: out std_logic_vector(4 downto 0);
		 clk, rst_sig:in std_logic);
end module_CU;

architecture module_CU_ARC of module_CU is
type state_type is (RST, IDLE, LD_MAT, LD_PIV, LD_RIGHT, ADD_DIFF1, LD_TOP,
					ADD_DIFF2, LD_LEFT, ADD_DIFF3, LD_BOTTOM, ADD_DIFF4, 
					SAVE_DIFF4, COMPARE, CHK_END, MOVE_MTR, SAVE_CURRENT_CONT, END_ALGO, FAIL_en);
signal current_state : state_type;

-- Input signals
signal move_done, start, ack, finish, comp_value: std_logic;
signal failure_count_value: std_logic;
  
begin

failure_count_value <= input(5);
comp_value <= input(4);
move_done <= input(3);
start <= input(2);
ack <= input(1);
finish <= input(0);

process(clk, start, ack, finish, comp_value, failure_count_value, move_done)
begin
	if(clk'event and clk = '1') then
		if(rst_sig = '1') then
			current_state <= RST;
		elsif(current_state = RST) then
			current_state <= IDLE;
		elsif(current_state = IDLE and start = '1') then
			current_state <= LD_MAT;
		elsif(current_state = LD_MAT and ack = '1') then
			current_state <= LD_PIV;
		elsif(current_state = LD_PIV) then
			current_state <= LD_RIGHT;
		elsif(current_state = LD_RIGHT) then
			current_state <= ADD_DIFF1;
		elsif(current_state = ADD_DIFF1) then
			current_state <= LD_TOP;
		elsif(current_state = LD_TOP) then
			current_state <= ADD_DIFF2;
		elsif(current_state = ADD_DIFF2) then
			current_state <= LD_LEFT;
		elsif(current_state = LD_LEFT) then
			current_state <= ADD_DIFF3;
		elsif(current_state = ADD_DIFF3) then
			current_state <= LD_BOTTOM;
		elsif(current_state = LD_BOTTOM) then
			current_state <= ADD_DIFF4;
		elsif(current_state = ADD_DIFF4) then
			current_state <= SAVE_DIFF4;
		elsif(current_state = SAVE_DIFF4 and finish = '0') then
			current_state <= LD_PIV;
		elsif(current_state = SAVE_DIFF4 and finish = '1') then
			current_state <= COMPARE;
		elsif(current_state = COMPARE and comp_value = '1') then
			current_state <= CHK_END;
		elsif(current_state = COMPARE and comp_value = '0') then
			current_state <= FAIL_en;
		elsif(current_state = FAIL_en) then
			current_state <= MOVE_MTR;
		elsif(current_state = CHK_END and failure_count_value = '1') then
			current_state <= END_ALGO;
		elsif(current_state = CHK_END and failure_count_value = '0') then
			current_state <= MOVE_MTR;
		elsif(current_state = MOVE_MTR and move_done = '1') then
			current_state <= SAVE_CURRENT_CONT;
		elsif(current_state = SAVE_CURRENT_CONT) then
			current_state <= LD_MAT;
		elsif(current_state = END_ALGO) then
			current_state <= RST;
		end if;
	end if;
end process;


process(current_state)
begin
	if(current_state = RST) then
		signals <= "01100000000000000";
		state_out<= "00000";
	elsif(current_state = IDLE) then
		signals <= "00000000000000000";
		state_out<= "00001";
	elsif(current_state = LD_MAT) then
		signals <= "00000000000010100";
		state_out<= "00010";
	elsif(current_state = LD_PIV) then
		signals <= "00000000100000000";
		state_out<= "00011";
	elsif(current_state = LD_RIGHT) then
		signals <= "00001000000100000";
		state_out<= "00100";
	elsif(current_state = ADD_DIFF1) then
		signals <= "00000000001000000";
		state_out<= "00101";
	elsif(current_state = LD_TOP) then
		signals <= "00010101000100000";
		state_out<= "00110";
	elsif(current_state = ADD_DIFF2) then
		signals <= "00000000001000000";
		state_out<= "00111";
	elsif(current_state = LD_LEFT) then
		signals <= "00001101000100000";
		state_out<= "01000";
	elsif(current_state = ADD_DIFF3) then
		signals <= "00000000001000000";
		state_out<= "01001";
	elsif(current_state = LD_BOTTOM) then
		signals <= "00010001000100000";
		state_out<= "01010";
	elsif(current_state = ADD_DIFF4) then
		signals <= "00000010001000000";
		state_out<= "01011";
	elsif(current_state = SAVE_DIFF4) then
		signals <= "00000001000000000";
		state_out<= "01100";
	elsif(current_state = COMPARE) then
		signals <= "00000000000000000";
		state_out<= "01101";
	elsif(current_state = CHK_END) then
		signals <= "10000000000000001";
		state_out<= "01110";
	elsif(current_state = MOVE_MTR) then
		signals <= "00000000000001000";
		state_out<= "01111";
	elsif(current_state = END_ALGO) then
		signals <= "00000000000000010";
		state_out<= "10000";
	elsif(current_state = SAVE_CURRENT_CONT) then
		signals <= "01000000010000000";
		state_out<= "10001";
	elsif(current_state = FAIL_en) then
		signals <= "00000000000000001";
		state_out<= "10010";
	else
		signals <= "00000000000000000";
		state_out<= "11111";
	end if;
end process;	
	
end module_CU_ARC;
