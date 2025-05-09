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
    
    function in_opcode_set(value : std_logic_vector(7 downto 0)) return boolean is
    begin
        return (value = x"05" or value = x"01" or value = x"02" or value = x"03" or value = x"04" or value = x"0A" or value = x"0B" or value = x"0C" or value = x"0D" or value = x"11" or value = x"08");
    end function;

    function in_mem_access_set(value : std_logic_vector(7 downto 0)) return boolean is
    begin
        return (value = x"06" or value = x"01" or value = x"02" or value = x"03" or value = x"04" or value = x"10" or value = x"0A" or value = x"0B" or value = x"0C" or value = x"0D");
    end function;

begin
    process(clock)
    begin
        
        if in_opcode_set(instruction(31 downto 24)) then
            if (in_mem_access_set(LIDI) and 
                ((LIDI_addr = instruction(15 downto 8)) or (LIDI_addr = instruction(7 downto 0)))) or
        
               (in_mem_access_set(DIEX) and 
                ((DIEX_addr = instruction(15 downto 8)) or (DIEX_addr = instruction(7 downto 0)))) or
        
               (in_mem_access_set(EXMEM) and 
                ((EXMEM_addr = instruction(15 downto 8)) or (EXMEM_addr = instruction(7 downto 0)))) or
        
               (in_mem_access_set(MEMRE) and 
                ((MEMRE_addr = instruction(15 downto 8)) or (MEMRE_addr = instruction(7 downto 0)))) then
        
                enable_counter <= '0';
            else
                enable_counter <= '1';
            end if;
        else
            enable_counter <= '1';
        end if; 
        
    end process;
end Behavioral;


