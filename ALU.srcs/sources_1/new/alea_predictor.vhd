----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2025 11:29:50 AM
-- Design Name: 
-- Module Name: alea_predictor - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alea_predictor is
    port(
        clock : in std_logic;
        instruction: in std_logic_vector(31 downto 0);
        LIDI, DIEX, EXMEM, MEMRE : in std_logic_vector(7 downto 0);
        LIDI_addr, DIEX_addr, EXMEM_addr, MEMRE_addr : in std_logic_vector(7 downto 0);
        enable_counter : out std_logic
    );
end alea_predictor;

architecture Behavioral of alea_predictor is
begin
    process(clock)
    begin
        if instruction(31 downto 24) = x"05" then
            if (LIDI = x"06" and LIDI_addr = instruction(15 downto 8)) or
               (DIEX = x"06" and DIEX_addr = instruction(15 downto 8)) or
               (EXMEM = x"06" and EXMEM_addr = instruction(15 downto 8)) or
               (MEMRE = x"06" and MEMRE_addr = instruction(15 downto 8)) then
                enable_counter <= '0';
                
            else
                enable_counter <= '1';
            end if;
        else
            enable_counter <= '1';
        end if;
    end process;
end Behavioral;

