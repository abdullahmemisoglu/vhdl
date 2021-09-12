library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPI_MODULE is

generic (
		clk_freq 	: integer := 25_000_000;
		sclk_freq	: integer := 1_000_000
		);
port (
	clk_i 		: in STD_LOGIC;
	en_i  		: in STD_LOGIC;
	mosi_data_i : in STD_LOGIC_VECTOR (7 downto 0);
	cs_o 			: out STD_LOGIC;
	sclk_o 		: out STD_LOGIC;
	mosi_o 		: out STD_LOGIC;
	busy 			: out STD_LOGIC
	);
end entity SPI_MODULE;

architecture behaviour of SPI_MODULE is

signal write_reg 	: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal sclk_en   	: STD_LOGIC := '0';
signal sclk			: STD_LOGIC := '0';
signal sclk_prev	: STD_LOGIC := '0';
signal mosi_en 	: STD_LOGIC := '0';
signal miso_en 	: STD_LOGIC := '0';

constant edge_counter_limit : integer := clk_freq / (sclk_freq * 2);
signal edge_cnt : integer range 0 to edge_counter_limit := 0;
signal cnt : integer range 0 to 15 := 0;

type StateType is (idle, transfer);
signal state : StateType := idle;

begin
	process (sclk, sclk_prev)
	begin
		if (sclk = '1' and sclk_prev = '0') then
			miso_en <= '1';
		else
			miso_en <= '0';
		end if;
		if (sclk = '0' and sclk_prev = '1') then
			mosi_en <= '1';
		else
			mosi_en <= '0';
		end if;
	end process;
	
	process (clk_i)
	begin 
		if (rising_edge(clk_i)) then 
			sclk_prev <= sclk;
				case state is
					when idle =>
						cs_o 		<= '1';
						mosi_o 	<= '0';
						sclk_en 	<= '0';
						cnt 		<=  0 ;
						sclk_o 	<= '0';
						busy 		<= '0';
						if (en_i = '1') then
							busy 			<= '1';
							state 		<= transfer;
							sclk_en 		<= '1';
							write_reg 	<= mosi_data_i;
							mosi_o 		<= mosi_data_i(7);
						end if;
					when transfer =>
						busy <= '1';
						cs_o <= '0';
						mosi_o <= write_reg(7);
						if (cnt = 0) then 
							sclk_o <= sclk;
							if (miso_en = '1') then
								cnt <= cnt + 1;
							end if;
						elsif (cnt = 8) then
							sclk_o <= sclk;
							if (mosi_en = '1') then
								if (en_i = '1') then
									write_reg <= mosi_data_i;
									mosi_o <= mosi_data_i(7);
									cnt <= 0;
								else
									cnt <= cnt + 1;
								end if;
							end if;
							if (miso_en = '1') then
								state <= idle;
								cs_o <= '1';
								busy <= '0';
							end if;
						elsif (cnt = 9) then
							if (miso_en = '1') then 
								state <= idle;
								cs_o <= '1';
								busy <= '0';
							end if;
						else
							sclk_o <= sclk;
								if (miso_en = '1') then
									cnt <= cnt + 1;
								end if;
								if (mosi_en = '1') then 
									write_reg (7 downto 1) <= write_reg (6 downto 0);
								end if;
						end if;
				end case;
		end if;
	end process;
end behaviour;
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
		
