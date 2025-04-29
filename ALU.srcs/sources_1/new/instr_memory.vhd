----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:04:37 AM
-- Design Name: 
-- Module Name: instr_memory - Behavioral
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

entity instr_memory is
    port(
        CLK     : in  std_logic;
        ADDR    : in  std_logic_vector(7 downto 0);
        INSTR   : out std_logic_vector(31 downto 0)
    );
end instr_memory;

architecture rom of instr_memory is
    type rom_t is array (255 downto 0) of std_logic_vector(31 downto 0);
    -- Example program: fill with NOP (0x0000)
    constant ROM_CONTENT : rom_t := (
        0 => x"1234",
        1 => x"ABCD",
        2 => x"0001",
        16 => x"DEAD",
        255 => x"BEEF",
        others => x"0000"
    );
    signal ROM : rom_t := ROM_CONTENT;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            INSTR <= ROM(to_integer(unsigned(ADDR)));
        end if;
    end process;
end rom;