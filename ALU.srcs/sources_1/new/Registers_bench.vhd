----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2025 11:25:20 AM
-- Design Name: 
-- Module Name: Registers_bench - Behavioral
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


entity Registers_bench is
    port (
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        W    : in  std_logic_vector(7 downto 0);
        WE   : in  std_logic;
        DATA : in  std_logic_vector(7 downto 0);
        RST  : in  std_logic;                     
        CLK  : in  std_logic;                   
        QA   : out std_logic_vector(7 downto 0);
        QB   : out std_logic_vector(7 downto 0)
    );
end Registers_bench;


architecture rtl of Registers_bench is
    type regfile_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal regfile : regfile_type := (others => (others => '0'));

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                regfile <= (others => (others => '0'));
            elsif WE = '1' then
                regfile(to_integer(unsigned(W))) <= DATA;
            end if;
        end if;
    end process;

    QA <= DATA when (WE = '1' and W = A) 
           else regfile(to_integer(unsigned(A)));

    QB <= DATA when (WE = '1' and W = B) 
           else regfile(to_integer(unsigned(B)));

end rtl;
