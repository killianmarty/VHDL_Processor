----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 01:40:59 PM
-- Design Name: 
-- Module Name: processor_tb - Behavioral
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

entity tb_processor is
end tb_processor;

architecture test of tb_processor is
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';

    -- Clock period
    constant clk_period : time := 10 ns;

    -- Component under test
    component processor
        Port(
            clk : in std_logic;
            rst : in std_logic
        );
    end component;

begin

    -- Instantiate the processor
    uut: processor
        port map (
            clk => clk,
            rst => rst
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the processor
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Run simulation for a while
        wait for 500 ns;

    end process;

end test;
