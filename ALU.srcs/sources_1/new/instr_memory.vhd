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
    constant ROM_CONTENT : rom_t := (
       0 => x"00000000",
1 => x"060f0200",
2 => x"05000f00",
3 => x"060f0300",
4 => x"05010f00",
5 => x"010f0001",
6 => x"05020f00",
7 => x"060f0100",
8 => x"05030f00",
9 => x"060f0000",
10 => x"05040f00",
11 => x"060e0500",
12 => x"0c0f020e",
13 => x"08110f00",
14 => x"060f0200",
15 => x"05030f00",
16 => x"07130000",
17 => x"060f0300",
18 => x"05030f00",
19 => x"060f0000",
20 => x"05050f00",
21 => x"060e0a00",
22 => x"0a0f050e",
23 => x"081f0f00",
24 => x"071c0000",
25 => x"060e0100",
26 => x"0105050e",
27 => x"07150000",
28 => x"060e0100",
29 => x"0104040e",
30 => x"07190000",
31 => x"00000000",
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