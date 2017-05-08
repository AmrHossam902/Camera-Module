library ieee;
use ieee.std_logic_1164.all;

entity module is
	port( clk, rst, ack, start, move_done: in std_logic;
		  nvm_address_in: in std_logic_vector(11 downto 0);
		  cache_data_in:in std_logic_vector(7 downto 0);
		  cache_address_out: out std_logic_vector(7 downto 0); 
		  move, start_dma, done: out std_logic;
		  direction: out std_logic_vector(0 downto 0);
		  nvm_address_out: out std_logic_vector(11 downto 0));
end module;


architecture module_ARC of module is

-- components

-- REGISTER
component nbit_Register IS
  Generic(n: integer := 16);
	PORT( Clk,rst, enable : IN std_logic;
		  d, rst_value: IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
end component;

-- ADDER
component nbit_adder IS
       GENERIC (n : integer := 16);
PORT(a,b : IN std_logic_vector(n-1  DOWNTO 0);
             cin : IN std_logic;  
            add_out : OUT std_logic_vector(n-1 DOWNTO 0));
END component;

-- 3X1 MUX
component nbit_mux3x1 is
		Generic(n: Integer :=8);
     port(
         input1, input2, input3: in STD_LOGIC_VECTOR(n-1 downto 0);
         s : in std_logic_vector(1 downto 0);
         output : out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- incrementer decrementer
component inc_dec_module is
	port(A, amount:in std_logic_vector(7 downto 0);
		 inc_dec:in std_logic;
		 output:out std_logic_vector(7 downto 0));
end component;

-- 2x1 MUX
component nbit_mux2x1 is
		Generic(n: Integer :=8);
     port(
         input1, input2: in STD_LOGIC_VECTOR(n-1 downto 0);
         s0 : in std_logic;
         output : out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- SUB Module
component sub
	port(A, B: in std_logic_vector(17 downto 0);
	     sub_value: out std_logic_vector(17 downto 0));
end component;

-- CU module
component module_CU is
	port(input:in std_logic_vector(5 downto 0);
		 signals:out std_logic_vector(13 downto 0);
		 clk, rst_sig:in std_logic);
end component;

-- cache address selector component 
component selectData is
   port(
      inc_dec: in std_logic;
	  s: in std_logic_vector(1 downto 0);
	  address:in std_logic_vector(7 downto 0);
      func: out std_logic
    );
end component;

-----------------------------------SIGNALS---------------------------------------
signal  pixel_value, sub_module_value, bus_value : std_logic_vector(17 downto 0);
signal diff_value, current_cont_value, prev_cont_value: std_logic_vector(17 downto 0);
signal Addout_value, add_module_value, prev_cont_bar , comp_fake_value: std_logic_vector(17 downto 0);
signal address_value, plus_minus1_value, plus_minus16_value, mux1_value: std_logic_vector(7 downto 0);
signal comp_bit, finish, mux1_sel: std_logic;
signal direc_value, direc_value_bar: std_logic_vector(0 downto 0);

--control unit signals
signal mux2_sel : std_logic_vector(1 downto 0);
signal inc_dec, address_enable, current_cont_enable, pixel_enable: std_logic;
signal prev_cont_enable, Addout_enable, diff_enable, nvm_address_enable: std_logic;
signal failure_count_enable: std_logic;
signal failure_count_value : std_logic_vector(0 downto 0);
signal CU_in_signals: std_logic_vector(5 downto 0);
signal CU_out_signals: std_logic_vector(13 downto 0);



begin

--registers
pixel_reg: nbit_Register generic map(18) port map(clk, rst, pixel_enable, bus_value, (others => '0'), pixel_value);
diff_reg: nbit_Register generic map(18) port map(clk, rst, diff_enable, sub_module_value, (others => '0'), diff_value);
Addout_reg: nbit_Register generic map(18) port map(clk, rst, Addout_enable, add_module_value, (others => '0'), Addout_value);
curr_cont_reg: nbit_Register generic map(18) port map(clk, rst, current_cont_enable, Addout_value, (others => '0'), current_cont_value);
prev_cont_reg: nbit_Register generic map(18) port map(clk, rst, prev_cont_enable, current_cont_value, (others => '0'), prev_cont_value);
Address_reg: nbit_Register generic map(8) port map(clk, rst, address_enable, plus_minus1_value, (others => '0'), address_value);
nvm_address_reg: nbit_Register generic map(12) port map (clk, rst, nvm_address_enable, nvm_address_in, (others => '0'), nvm_address_out);
direc_reg: nbit_Register generic map(1) port map(clk, rst, comp_bit, direc_value_bar, "0", direc_value);
fail_count_reg: nbit_Register generic map(1) port map(clk, rst, failure_count_enable, "1", "0",failure_count_value);


-- muxes
mux2: nbit_mux3x1 generic map(8) port map(address_value, plus_minus1_value, plus_minus16_value, mux2_sel, cache_address_out);
mux1: nbit_mux2x1 generic map(8) port map((others => '0'), cache_data_in, mux1_sel, mux1_value);
mux1_sel_block: selectData port map(inc_dec, mux2_sel, address_value, mux1_sel); 

-- modules
-- subtractor
submodule: sub port map(pixel_value, bus_value, sub_module_value);

--adder
addmodule: nbit_adder generic map(18) port map(current_cont_value ,diff_value, '0', add_module_value);

-- comparator
prev_cont_bar <= not prev_cont_value;
compmodule: nbit_adder generic map(18) port map(current_cont_value, prev_cont_bar, '1', comp_fake_value);
comp_bit <= comp_fake_value(16);

-- Incrementrs decrementers
plusMinus1: inc_dec_module port map(address_value, x"01", inc_dec, plus_minus1_value);
plusMinus16: inc_dec_module port map(address_value, x"10", inc_dec, plus_minus16_value);

--CU
CU_in_signals <= failure_count_value & comp_bit &  move_done & start & ack & finish;
modCU: module_CU port map(CU_in_signals, CU_out_signals, clk, rst);

mux2_sel <= CU_out_signals(13 downto 12);
inc_dec <= CU_out_signals(11);
address_enable <= CU_out_signals(10);
current_cont_enable <= CU_out_signals(9);
pixel_enable <= CU_out_signals(8);
prev_cont_enable<= CU_out_signals(7);
Addout_enable <= CU_out_signals(6);
diff_enable <= CU_out_signals(5);
nvm_address_enable <= CU_out_signals(4);
failure_count_enable <= CU_out_signals(0);

--output signals
direction <= direc_value;
move <= CU_out_signals(3);
start_dma <= CU_out_signals(2);
done <= CU_out_signals(1);

--intermediate signals
direc_value_bar <= not direc_value;
bus_value <= "0000000000" & mux1_value;
finish <= address_value(7) and address_value(6) and
		  address_value(5) and address_value(4) and
	      address_value(3) and address_value(2) and
		  address_value(1) and address_value(0);
end module_ARC;
