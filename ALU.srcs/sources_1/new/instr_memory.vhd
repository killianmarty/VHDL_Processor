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
        ENABLED : in std_logic;
        INSTR   : out std_logic_vector(31 downto 0);
        INSTR_NEXT : out std_logic_vector(31 downto 0)
    );
end instr_memory;

architecture rom of instr_memory is
    type rom_t is array (255 downto 0) of std_logic_vector(31 downto 0);
    -- Example program: fill with NOP (0x0000)
    constant ROM_CONTENT : rom_t := (
        1 => x"06011200",
        2 => x"0602AB00",
        3 => x"05030200",
        4 => x"01030102",
        10 => x"02030102",
        13 => x"03030102",
        others => x"00000000"
    );
    signal ROM : rom_t := ROM_CONTENT;
    signal enabled_prev : std_logic := '1';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            enabled_prev <= ENABLED;
        end if;
    end process;

    INSTR <= ROM(to_integer(unsigned(ADDR))) when enabled_prev = '1' else x"00000000";
    INSTR_NEXT <= ROM(to_integer(unsigned(ADDR)+1));
    
end rom;