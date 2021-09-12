library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_SPI_PROJECT is 
generic (
		clk_freq : integer := 25_000_000;
		sclk_freq: integer := 1_000_000
		);
end entity TB_SPI_PROJECT;

architecture tb of TB_SPI_PROJECT is 

component SPI_MODULE is
generic (
		clk_freq : integer := 25_000_000;
		sclk_freq: integer := 1_000_000
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
end component SPI_MODULE;

signal clk  : STD_LOGIC := '0';
signal en_i : STD_LOGIC := '0';
signal mosi_data_i : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal cs_o 	: STD_LOGIC;
signal sclk_o 	: STD_LOGIC;
signal mosi_o 	: STD_LOGIC;
signal busy 	: STD_LOGIC;

constant clk_period 	: time := 40 ns;
constant sclk_period : time := 1000 ns;
signal spi_signal : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal spi_w 		: STD_LOGIC := '0';
signal spi_w_done : STD_LOGIC := '0';

begin

wire : SPI_MODULE

port map (
		clk_i 		=> clk, 
		en_i  		=> en_i,
		mosi_data_i => mosi_data_i,
		cs_o 			=> cs_o, 
		sclk_o 		=> sclk_o,
		mosi_o 		=> mosi_o,
		busy 			=> busy
		);

process
begin
	clk <= '0';
	wait for clk_period / 2;
	clk <= '1';
	wait for clk_period / 2;
end process;

process
begin
	wait until rising_edge(spi_w);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	wait until falling_edge(sclk_o);
	
	spi_w_done <= '1';
	wait for 1ps;
	spi_w_done <= '0';
end process;

process 
begin

	wait until (busy = '0');
	en_i <= '1';
	mosi_data_i <= x"AB";
	spi_w <= '1';
	wait until rising_edge(spi_w_done);
	spi_w <= '0';
	en_i <= '0';
	
	wait until (busy = '0');
	en_i <= '1';
	mosi_data_i <= x"0A";
	spi_w <= '1';
	wait until rising_edge(spi_w_done);
	spi_w <= '0';
	en_i <= '0';
	
	wait until (busy = '0');
	en_i <= '1';
	mosi_data_i <= x"B0";
	spi_w <= '1';
	wait until rising_edge(spi_w_done);
	spi_w <= '0';
	en_i <= '0';	
	
	wait until (busy = '0');
	en_i <= '1';
	mosi_data_i <= x"23";
	spi_w <= '1';
	wait until rising_edge(spi_w_done);
	spi_w <= '0';
	en_i <= '0';	
	
	wait until (busy = '0');
	en_i <= '1';
	mosi_data_i <= x"31";
	spi_w <= '1';
	wait until rising_edge(spi_w_done);
	spi_w <= '0';
	en_i <= '0';
	
	wait for 4 ms;
end process;
end tb;