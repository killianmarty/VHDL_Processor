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
1 => x"06000200",
2 => x"11ff0000",
3 => x"1000ff00",
4 => x"05010000",
5 => x"11000000",
6 => x"06000300",
7 => x"11ff0000",
8 => x"1000ff00",
9 => x"05010000",
10 => x"11010000",
11 => x"10000000",
12 => x"10010100",
13 => x"01000001",
14 => x"11ff0000",
15 => x"1000ff00",
16 => x"05010000",
17 => x"11020000",
18 => x"06000100",
19 => x"11ff0000",
20 => x"1000ff00",
21 => x"05010000",
22 => x"11030000",
23 => x"06000000",
24 => x"11ff0000",
25 => x"1000ff00",
26 => x"05010000",
27 => x"11040000",
28 => x"06000500",
29 => x"11fe0000",
30 => x"10000200",
31 => x"1001fe00",
32 => x"0c000001",
33 => x"11ff0000",
34 => x"1000ff00",
35 => x"082a0000",
36 => x"06000200",
37 => x"11ff0000",
38 => x"1000ff00",
39 => x"05010000",
40 => x"11030000",
41 => x"072f0000",
42 => x"06000300",
43 => x"11ff0000",
44 => x"1000ff00",
45 => x"05010000",
46 => x"11030000",
47 => x"06000a00",
48 => x"11fe0000",
49 => x"10000400",
50 => x"1001fe00",
51 => x"0a000001",
52 => x"11ff0000",
53 => x"1000ff00",
54 => x"08510000",
55 => x"06000100",
56 => x"11ff0000",
57 => x"10000400",
58 => x"1001ff00",
59 => x"01000001",
60 => x"11040000",
61 => x"06000400",
62 => x"11fe0000",
63 => x"1000fe00",
64 => x"10010400",
65 => x"01000001",
66 => x"11fe0000",
67 => x"10000000",
68 => x"1001fe00",
69 => x"0a000001",
70 => x"11ff0000",
71 => x"1000ff00",
72 => x"08500000",
73 => x"06000100",
74 => x"11ff0000",
75 => x"10000000",
76 => x"1001ff00",
77 => x"01000001",
78 => x"11000000",
79 => x"073d0000",
80 => x"072f0000",
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