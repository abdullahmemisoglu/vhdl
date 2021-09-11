library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_Project is 
	port( CLK 			: in STD_LOGIC;
			Inc_Button 	: in STD_LOGIC;
			Dec_Button 	: in STD_LOGIC;
			LEDs 			: out STD_LOGIC_VECTOR (4 downto 0)
			);
end entity PWM_Project;

architecture behaviour of PWM_Project is

constant CLK_FREQ : integer := 25_000_000;
constant PWM_FREQ : integer := 10_000;
constant Cnt_max  : integer := CLK_FREQ/PWM_FREQ;

type StateType is (DUTY00, DUTY25, DUTY50, DUTY75, DUTY100);
signal State: StateType := DUTY00;

signal cnt : integer := 0;
signal debounced_inc_button 				: STD_LOGIC := '1';
signal debounced_dec_button 				: STD_LOGIC := '1';
signal previous_debounced_inc_button 	: STD_LOGIC := '1';
signal previous_debounced_dec_button 	: STD_LOGIC := '1';
signal is_inc_falling : STD_LOGIC := '1';
signal is_dec_falling : STD_LOGIC := '1';
signal LED_signal 	 : STD_LOGIC := '1';
signal rst 				 : STD_LOGIC := '1';
signal cnt_rst 		 : integer range 0 to 251 := 0;

component Debounce_Module is
	port( i_Clk 	 : in STD_LOGIC;
			i_Switch : in STD_LOGIC;
			o_Switch  : out STD_LOGIC
			);
end component Debounce_Module;

begin 

	process (CLK)
	begin
		if (cnt_rst < 250) then
			rst <= '1';
			cnt_rst <= cnt_rst + 1;
		else
			rst <= '0';
			cnt_rst <= 251;
		end if;
	end process;
	
	process (CLK)
	begin 
		if (rising_edge(CLK)) then 
			if (rst = '1') then
				cnt <= 0;
				State <= DUTY00;
			else
				previous_debounced_inc_button <= debounced_inc_button;
				previous_debounced_dec_button <= debounced_dec_button;
				if (debounced_inc_button = '0' and previous_debounced_inc_button = '1') then
					is_inc_falling <= '0';
				elsif (debounced_dec_button = '0' and previous_debounced_dec_button = '1') then
					is_dec_falling <= '0';
				else
					is_inc_falling <= '1';
					is_dec_falling <= '1';
				end if;
				
				case State is
					when DUTY00 =>
						LED_signal <= '1';
						if (cnt = Cnt_max) then 
							cnt <= 0;
						elsif (is_dec_falling = '0') then
							cnt <= 0;
							State <= DUTY00;
						elsif (is_inc_falling = '0') then
							cnt <= 0;
							State <= DUTY25;
						else
							cnt <= cnt + 1;
							State <= DUTY00;
						end if;
						
					when DUTY25 =>
						
						if (cnt = Cnt_max) then 
							cnt <= 0;
						elsif (is_dec_falling = '0') then
							cnt <= 0;
							State <= DUTY00;
						elsif (is_inc_falling = '0') then
							cnt <= 0;
							State <= DUTY50;
						elsif (cnt < (Cnt_max / 4)) then
							LED_signal <= '0';
							cnt <= cnt + 1;
						else
							LED_signal <= '1';
							cnt <= cnt + 1;
							State <= DUTY25;
						end if;
						
					when DUTY50 =>
						
						if (cnt = Cnt_max) then 
							cnt <= 0;
						elsif (is_dec_falling = '0') then
							cnt <= 0;
							State <= DUTY25;
						elsif (is_inc_falling = '0') then
							cnt <= 0;
							State <= DUTY75;
						elsif (cnt < (Cnt_max / 2)) then
							LED_signal <= '0';
							cnt <= cnt + 1;
						else
							LED_signal <= '1';
							cnt <= cnt + 1;
							State <= DUTY50;
						end if;						
	
					when DUTY75 =>
						
						if (cnt = Cnt_max) then 
							cnt <= 0;
						elsif (is_dec_falling = '0') then
							cnt <= 0;
							State <= DUTY50;
						elsif (is_inc_falling = '0') then
							cnt <= 0;
							State <= DUTY100;
						elsif (cnt < (3*Cnt_max / 4)) then
							LED_signal <= '0';
							cnt <= cnt + 1;
						else
							LED_signal <= '1';
							cnt <= cnt + 1;
							State <= DUTY75;
						end if;	

					when DUTY100 =>
						LED_signal <= '0';
						if (cnt = Cnt_max) then 
							cnt <= 0;
						elsif (is_dec_falling = '0') then
							cnt <= 0;
							State <= DUTY75;
						elsif (is_inc_falling = '0') then
							cnt <= 0;
							State <= DUTY100;
						else
							cnt <= cnt + 1;
							State <= DUTY100;
						end if;
					when others =>
						State <= DUTY00;
				end case;
			end if;
		end if;
	end process;
	
	LEDs(0) <= LED_signal;
	LEDs(1) <= LED_signal;
	LEDs(2) <= LED_signal;
	LEDs(3) <= LED_signal;
	LEDs(4) <= LED_signal;
	
Inc : Debounce_Module
	port map (
		i_Clk => CLK,
		i_Switch => Inc_Button,
		o_Switch => debounced_inc_button
		);
Dec : Debounce_Module
	port map (
		i_Clk => CLK,
		i_Switch => Dec_Button,
		o_Switch => debounced_dec_button
		);

end architecture behaviour;

















