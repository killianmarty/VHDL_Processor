----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:06:30 AM
-- Design Name: 
-- Module Name: data_memory_tb - Behavioral
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

entity data_memory_tb is
end data_memory_tb;

architecture tb of data_memory_tb is
    signal CLK_tb    : std_logic := '0';
    signal RST_tb    : std_logic := '0';
    signal RW_tb     : std_logic;
    signal ADDR_tb   : std_logic_vector(7 downto 0);
    signal IN_DATA_tb: std_logic_vector(7 downto 0);
    signal OUT_DATA_tb: std_logic_vector(7 downto 0);
begin
    -- Instantiate DUT
    DUT: entity work.data_memory(rtl)
        port map(
            CLK     => CLK_tb,
            RST     => RST_tb,
            RW      => RW_tb,
            ADDR    => ADDR_tb,
            IN_DATA => IN_DATA_tb,
            OUT_DATA=> OUT_DATA_tb
        );

    -- Clock generator
    clk_proc: process
    begin
        while true loop
            CLK_tb <= '0'; wait for 5 ns;
            CLK_tb <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Reset memory
        RST_tb <= '1'; RW_tb <= '1'; ADDR_tb <= (others => '0'); IN_DATA_tb <= (others => '0');
        wait for 10 ns;
        RST_tb <= '0';
        wait for 10 ns;

        -- Write 0xAA to address 0x10
        RW_tb <= '0'; ADDR_tb <= x"10"; IN_DATA_tb <= x"AA";
        wait for 10 ns;

        -- Read back at 0x10
        RW_tb <= '1'; ADDR_tb <= x"10";
        wait for 10 ns;

        -- Write 0x55 to address 0x20
        RW_tb <= '0'; ADDR_tb <= x"20"; IN_DATA_tb <= x"55";
        wait for 10 ns;

        -- Read back at 0x20
        RW_tb <= '1'; ADDR_tb <= x"20";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;
end tb;