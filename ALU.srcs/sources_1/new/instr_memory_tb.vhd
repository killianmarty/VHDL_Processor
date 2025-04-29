----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:07:24 AM
-- Design Name: 
-- Module Name: instr_memory_tb - Behavioral
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

entity instr_memory_tb is
end instr_memory_tb;

architecture tb2 of instr_memory_tb is
    signal CLK_tb   : std_logic := '0';
    signal ADDR_tb  : std_logic_vector(7 downto 0);
    signal INSTR_tb  : std_logic_vector(31 downto 0);
begin
    -- Instantiate DUT
    DUT2: entity work.instr_memory(rom)
        port map(
            CLK     => CLK_tb,
            ADDR    => ADDR_tb,
            INSTR   => INSTR_tb
        );

    -- Clock generator
    clk2_proc: process
    begin
        while true loop
            CLK_tb <= '0'; wait for 5 ns;
            CLK_tb <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    stim2_proc: process
    begin
        -- Read at several addresses
        ADDR_tb <= x"00";
        wait for 10 ns;
        ADDR_tb <= x"01";
        wait for 10 ns;
        ADDR_tb <= x"10";
        wait for 10 ns;
        ADDR_tb <= x"FF";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;
end tb2;
