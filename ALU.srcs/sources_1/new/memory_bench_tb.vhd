----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2025 11:57:25 AM
-- Design Name: 
-- Module Name: memory_bench_tb - Behavioral
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

entity memory_bench_tb is
end memory_bench_tb;

architecture behavior of memory_bench_tb is
    component memory_bench is
        port(
            dat_addr : in  std_logic_vector(7 downto 0);
            dat_in   : in  std_logic_vector(7 downto 0);
            dat_out  : out std_logic_vector(7 downto 0);
            rw       : in  std_logic;
            ins_addr : in  std_logic_vector(7 downto 0);
            ins_out  : out std_logic_vector(7 downto 0);
            rst      : in  std_logic;
            clk      : in  std_logic
        );
    end component;
    
    signal dat_addr : std_logic_vector(7 downto 0) := (others => '0');
    signal dat_in   : std_logic_vector(7 downto 0) := (others => '0');
    signal dat_out  : std_logic_vector(7 downto 0);
    signal rw       : std_logic := '0';
    signal ins_addr : std_logic_vector(7 downto 0) := (others => '0');
    signal ins_out  : std_logic_vector(7 downto 0);
    signal rst      : std_logic := '0';
    signal clk      : std_logic := '0';
begin
    uut: memory_bench port map(
        dat_addr => dat_addr,
        dat_in   => dat_in,
        dat_out  => dat_out,
        rw       => rw,
        ins_addr => ins_addr,
        ins_out  => ins_out,
        rst      => rst,
        clk      => clk
    );
    
    clk_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    stim_proc: process
    begin
        rst <= '1';
        rw  <= '0';
        dat_addr <= (others => '0');
        dat_in <= (others => '0');
        ins_addr <= (others => '0');
        wait for 20 ns;
        
        rst <= '0';
        wait for 10 ns;
        
        rw <= '1';
        dat_addr <= "00001010";
        dat_in <= x"AA";
        wait for 10 ns;
        
        rw <= '0';
        wait for 10 ns;
        
        dat_addr <= "00001010";
        wait for 10 ns;
        
        ins_addr <= "00000010";
        wait for 10 ns;
        
        ins_addr <= "00000011";
        wait for 10 ns;
        
        wait;
    end process;
end behavior;
