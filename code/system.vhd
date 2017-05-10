library ieee;
use ieee.std_logic_1164.all;

entity system is
	port(clk, rst, start, motor_done: in std_logic;
		 nvm_input_address: in std_logic_vector(11 downto 0);
		 done, motor_move : out std_logic;
		 motor_direction: out std_logic_vector(0 downto 0));
end system;


architecture system_ARC of system is

--camera component
component CameraModule is
	port(clk, rst, start, motor_done : in std_logic;
		 nvm_input_address: in std_logic_vector(11 downto 0);
		 nvm_input_data: in std_logic_vector(127 downto 0);
		 nvm_output_address: out std_logic_vector(11 downto 0);
		 motor_direction : out std_logic_vector(0 downto 0);
		 motor_move, done : out std_logic);
end component;

-- NVM
component NVM IS
 PORT (rst : IN std_logic;
	   address : IN std_logic_vector(11 DOWNTO 0);
	   dataout : OUT std_logic_vector(127 DOWNTO 0));
END component;

-- signals
signal nvm_data: std_logic_vector(127 downto 0);
signal nvm_address: std_logic_vector(11 downto 0); 


begin

camera_module: CameraModule port map(clk, rst, start, motor_done, nvm_input_address, nvm_data, nvm_address, motor_direction, motor_move, done);
nvm_module :  NVM port map(rst, nvm_address, nvm_data);
end system_ARC;

