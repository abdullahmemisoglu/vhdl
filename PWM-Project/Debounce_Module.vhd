library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debounce_Module is

	port( i_Clk 	: in STD_LOGIC;
			i_Switch : in STD_LOGIC := '1';
			o_Switch : out STD_LOGIC := '1'
		 );
end entity Debounce_Module;

architecture behaviour of Debounce_Module is 

	constant c_Debounce_Limit 	: integer := 50_000;
	signal clk_counter 			: integer range 0 to c_Debounce_Limit := 0;
	signal deb_button_signal 	: STD_LOGIC;
	signal r1 : STD_LOGIC;
	signal r2 : STD_LOGIC;
	
	type StateType is (button_to_R1, R1_to_R2);
	signal State : StateType := button_to_R1;
	
begin 

	process (i_Clk)
	begin
	
		if(rising_edge(i_Clk)) then
			r1 <= i_Switch;
			r2 <= r1;
			if(r2 = r1) then 
				clk_counter <= clk_counter + 1;
			else
				clk_counter <= 0;
			end if;
			
			if (clk_counter = c_Debounce_Limit) then
				deb_button_signal <= r2;
				clk_counter 		<= 0;
			end if;
		end if;
	end process;
o_Switch <= deb_button_signal;
end architecture behaviour;
	