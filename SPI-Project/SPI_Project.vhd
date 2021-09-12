library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_Project is 
generic (
		cnt_max : integer := 15);
port (
	clk 		: in STD_LOGIC;
	cs_o 		: out STD_LOGIC;
	sclk_o 	: out STD_LOGIC;
	mosi_o 	: out STD_LOGIC
	);
end entity SPI_Project;

architecture behaviour of SPI_Project is

signal mosi_data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal enable    : STD_LOGIC := '0';
signal busy 	  : STD_LOGIC;
signal cnt 		  : integer range 0 to cnt_max := 0;
signal once 	  : STD_LOGIC := '1';

component SPI_MODULE is
port (
	clk_i 		: in STD_LOGIC;
	en_i  		: in STD_LOGIC;
	mosi_data_i : in STD_LOGIC_VECTOR (7 downto 0);
	cs_o 			: out STD_LOGIC;
	sclk_o 		: out STD_LOGIC;
	mosi_o 		: out STD_LOGIC;
	busy 			: out STD_LOGIC
	);
end component SPI_MODULE;
begin 
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (busy = '0') then
				if (once = '1') then
					enable <= '1';
					mosi_data <= STD_LOGIC_VECTOR (UNSIGNED(mosi_data) + 1);
					cnt <= 0;
					once <= '0';
				end if;
			else
				enable <= '0';
				once <= '1';
			end if;
		end if;
	end process;
SPI : SPI_MODULE
	port map (
			clk_i 		=> clk, 
			en_i  		=> enable,
			mosi_data_i => mosi_data,
			cs_o 			=> cs_o, 
			sclk_o 		=> sclk_o,
			mosi_o 		=> mosi_o,
			busy 			=> busy
			);
end architecture behaviour;