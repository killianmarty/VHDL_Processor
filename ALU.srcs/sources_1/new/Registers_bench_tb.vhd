----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2025 11:34:01 AM
-- Design Name: 
-- Module Name: Registers_bench_tb - Behavioral
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

entity Registers_bench_tb is
end Registers_bench_tb;

architecture test of Registers_bench_tb is

    component Registers_bench is
        port (
            A    : in  std_logic_vector(3 downto 0);
            B    : in  std_logic_vector(3 downto 0);
            W    : in  std_logic_vector(3 downto 0);
            WE   : in  std_logic;
            DATA : in  std_logic_vector(7 downto 0);
            RST  : in  std_logic;
            CLK  : in  std_logic;
            QA   : out std_logic_vector(7 downto 0);
            QB   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal A, B, W       : std_logic_vector(3 downto 0);
    signal WE            : std_logic;
    signal DATA          : std_logic_vector(7 downto 0);
    signal RST, CLK      : std_logic;
    signal QA, QB        : std_logic_vector(7 downto 0);

begin

    -- Instance du module Registers_bench
    UUT: Registers_bench
        port map (
            A    => A,
            B    => B,
            W    => W,
            WE   => WE,
            DATA => DATA,
            RST  => RST,
            CLK  => CLK,
            QA   => QA,
            QB   => QB
        );

    ----------------------------------------------------------------------------
    -- Génération d'horloge : période de 10 ns
    ----------------------------------------------------------------------------
    clock_process : process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;

    ----------------------------------------------------------------------------
    -- Process de stimuli pour tester l'écriture, la lecture et le bypass
    ----------------------------------------------------------------------------
    stim_proc: process
    begin
        -- Initialisation et reset
        RST <= '1';
        WE  <= '0';
        A   <= "0000";
        B   <= "0001";
        W   <= "0000";
        DATA <= (others => '0');
        wait for 20 ns;

        -- Fin du reset
        RST <= '0';
        wait for 10 ns;

        ----------------------------------------------------------------------------
        -- Test 1 : Écriture dans registre 0 (adresse "0000"), DATA = 0x55
        -- On active le bypass en mettant A = W ("0000")
        ----------------------------------------------------------------------------
        W    <= "0000";
        DATA <= x"55";
        WE   <= '1';
        A    <= "0000";  -- bypass sur QA
        B    <= "0001";  -- lecture d'un autre registre (reste 0)
        wait for 10 ns;

        -- Fin de l'écriture
        WE <= '0';
        wait for 10 ns;

        ----------------------------------------------------------------------------
        -- Lecture classique : On lit registre 0 et 1
        ----------------------------------------------------------------------------
        A <= "0000";  -- devrait être 0x55
        B <= "0001";  -- toujours 0x00
        wait for 10 ns;

        ----------------------------------------------------------------------------
        -- Test 2 : Écriture dans registre 1 (adresse "0001"), DATA = 0xAA
        -- On active le bypass sur QB en mettant B = W ("0001")
        ----------------------------------------------------------------------------
        W    <= "0001";
        DATA <= x"AA";
        WE   <= '1';
        A    <= "0000";  -- lecture classique sur QA
        B    <= "0001";  -- bypass sur QB
        wait for 10 ns;

        -- Fin de l'écriture
        WE <= '0';
        wait for 10 ns;

        ----------------------------------------------------------------------------
        -- Lecture classique : On lit les registres 0 et 1
        ----------------------------------------------------------------------------
        A <= "0000";  -- doit lire 0x55
        B <= "0001";  -- doit lire 0xAA
        wait for 10 ns;
        
        ----------------------------------------------------------------------------
        -- Test 3 : Lecture de registres non écrits (ex : adresses "0010" et "0011")
        ----------------------------------------------------------------------------
        A <= "0010";  -- jamais écrit → 0x00
        B <= "0011";  -- jamais écrit → 0x00
        wait for 10 ns;

        wait;
    end process;

end architecture;
