----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 11:02:39 AM
-- Design Name: 
-- Module Name: pipeline - Behavioral
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

entity pipeline is
    Port (
        clk   : in  std_logic;
        flush   : in  std_logic;
        enable: in std_logic;
        A_in  : in  std_logic_vector(7 downto 0);
        B_in  : in  std_logic_vector(7 downto 0);
        C_in  : in  std_logic_vector(7 downto 0);
        OP_in : in  std_logic_vector(7 downto 0);
        A_out : out std_logic_vector(7 downto 0);
        B_out : out std_logic_vector(7 downto 0);
        C_out : out std_logic_vector(7 downto 0);
        OP_out: out std_logic_vector(7 downto 0)
    );
end pipeline;

architecture Behavioral of pipeline is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if flush = '1' then
                A_out  <= (others => '0');
                B_out  <= (others => '0');
                C_out  <= (others => '0');
                OP_out <= (others => '0');
            elsif enable='1' then
                A_out  <= A_in;
                B_out  <= B_in;
                C_out  <= C_in;
                OP_out <= OP_in;
            end if;
        end if;
    end process;
end Behavioral;