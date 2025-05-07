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

entity LC is
    Port (
        OP         : in  std_logic_vector(7 downto 0);  -- Opcode de l'instruction
        W   : out std_logic
    );
end LC;

architecture Behavioral of LC is
begin
    process(OP)
    begin
        W <= '0';

        case OP is
            when "00000110" =>  -- AFC
                W <= '1';
                
            when x"05" => --COP
                w <= '1';

            when others =>
                null;
        end case;
    end process;
end Behavioral;
