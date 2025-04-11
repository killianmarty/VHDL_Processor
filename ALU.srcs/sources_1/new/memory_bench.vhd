----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2025 11:54:55 AM
-- Design Name: 
-- Module Name: memory_bench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_bench is
    port(
        dat_addr : in  std_logic_vector(7 downto 0);
        dat_in   : in  std_logic_vector(7 downto 0);
        dat_out  : out std_logic_vector(7 downto 0);
        rw       : in  std_logic;
        ins_addr : in  std_logic_vector(7 downto 0);
        ins_out  : out std_logic_vector(7 downto 0);
        rst      : in  std_logic;
        clk      : in  std_logic
    );
end memory_bench;

architecture rtl of memory_bench is
    type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
    type rom_type is array (0 to 255) of std_logic_vector(7 downto 0);
    signal ram : ram_type := (others => (others => '0'));
    signal rom : rom_type := (
        0 => x"00",
        1 => x"01",
        2 => x"02",
        3 => x"03",
        4 => x"04",
        5 => x"05",
        6 => x"06",
        7 => x"07",
        others => x"00"
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ram <= (others => (others => '0'));
            elsif rw = '1' then
                ram(to_integer(unsigned(dat_addr))) <= dat_in;
            end if;
        end if;
    end process;
    dat_out <= ram(to_integer(unsigned(dat_addr)));
    ins_out <= rom(to_integer(unsigned(ins_addr)));
end rtl;

