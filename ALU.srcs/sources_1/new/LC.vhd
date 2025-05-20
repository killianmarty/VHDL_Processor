----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 01:29:50 PM
-- Design Name: 
-- Module Name: LC - Behavioral
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

entity RE_LC is
    Port (
        OP         : in  std_logic_vector(7 downto 0);  -- Opcode de l'instruction
        W   : out std_logic
    );
end RE_LC;

architecture Behavioral of RE_LC is
begin
    process(OP)
    begin
        W <= '0';

        case OP is
            when x"06" =>  -- AFC
                W <= '1';
            when x"05" => --COP
                W <= '1';
            when x"01" => --ADD
                W <= '1';
            when x"02" => --MUL
                W <= '1';
            when x"03" => --SOU
                W <= '1';
            when x"04" => --DIV
                W <= '1'; 
            when x"10" => --LOAD
                W <= '1';
            when x"0A" => --INF
                W <= '1';
            when x"0B" => --SUP
                W <= '1';
            when x"0C" => --EQ
                W <= '1';
            when x"0D" => --NEQ
                W <= '1';
            when x"0F" => --RCOP
                W <= '1';
                
            when others =>
                null;
        end case;
    end process;
end Behavioral;
