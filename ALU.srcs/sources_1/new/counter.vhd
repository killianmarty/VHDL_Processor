----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2025 11:01:12 PM
-- Design Name: 
-- Module Name: 4bit_counter - Behavioral
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.all;


entity counter is
    Port ( enable : in STD_LOGIC;
           direction: in STD_LOGIC;
           clear: in STD_LOGIC;
           clock : in STD_LOGIC;
           value : inout STD_LOGIC_VECTOR(7 downto 0));
end counter;

architecture Behavioral of counter is
begin
    process(clock, clear, direction)
    begin
    if clear = '1' then
        if direction = '1' then
            value <= "00000000";
        else
            value <= "11111111";
        end if;
    elsif rising_edge(clock) then
        if enable = '1' then
            if direction = '1' then
                value <= value + 1;
            else
                value <= value - 1;
            end if;
        end if;
    end if;
    end process;
end Behavioral;