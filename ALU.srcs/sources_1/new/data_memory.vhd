----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:03:11 AM
-- Design Name: 
-- Module Name: data_memory - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port(
        CLK    : in  std_logic;
        RST    : in  std_logic;
        RW     : in  std_logic; -- '1' = read, '0' = write
        ADDR   : in  std_logic_vector(7 downto 0);
        IN_DATA: in  std_logic_vector(7 downto 0);
        OUT_DATA: out std_logic_vector(7 downto 0)
    );
end data_memory;

architecture rtl of data_memory is
    type mem_t is array (255 downto 0) of std_logic_vector(7 downto 0);
    signal RAM : mem_t := (others => (others => '0'));
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                RAM <= (others => (others => '0'));  -- synchronous reset
            elsif RW = '0' then
                RAM(to_integer(unsigned(ADDR))) <= IN_DATA;
            end if;
            -- read always provides data on next clock
            OUT_DATA <= RAM(to_integer(unsigned(ADDR)));
        end if;
    end process;
end rtl;