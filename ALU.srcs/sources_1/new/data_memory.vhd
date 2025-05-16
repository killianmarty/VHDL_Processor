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
        CLK : in std_logic;
        RW     : in  std_logic;
        ADDR   : in  std_logic_vector(7 downto 0);
        IN_DATA: in  std_logic_vector(7 downto 0);
        OUT_DATA: out std_logic_vector(7 downto 0)
    );
end data_memory;

architecture rtl of data_memory is
    type mem_t is array (0 to 255) of std_logic_vector(7 downto 0);
    signal RAM : mem_t := (
        others => x"00"
    );
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RW = '0' then
                RAM(to_integer(unsigned(ADDR))) <= IN_DATA;
                OUT_DATA <= (others => '0');
            else
                OUT_DATA <= RAM(to_integer(unsigned(ADDR)));
            end if;
        end if;
    end process;

end rtl;