----------------------------------------------------------------------------------
-- Company: Air INSA
-- Engineer: Killian MARTY
-- 
-- Create Date: 03/03/2025 08:22:28 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ALU IS
    PORT (
        A, B : IN std_logic_vector(7 DOWNTO 0);
        Op   : IN std_logic_vector(2 DOWNTO 0);
        S    : OUT std_logic_vector(7 DOWNTO 0);
        C, O, N, Z : OUT std_logic
    );
END ALU;

ARCHITECTURE Behavior OF ALU IS
    SIGNAL S_temp : std_logic_vector(15 DOWNTO 0) := (others => '0');
BEGIN
  
    with Op select S_temp <=
        (x"00" & A) + (x"00" & B) when "000",
        (x"00" & A) - (x"00" & B) when "001",
        (A) * (B) when "010",
        (x"00" & A) AND (x"00" & B) when "011",
        (x"00" & A) OR (x"00" & B) when "100",
        (x"00" & A) XOR (x"00" & B) when "101",
        x"00" & (NOT A) when "110",
        (others=>'0')  when others;
         
    Z <= '1' when S_temp(7 downto 0)=x"00" else '0';
    C <= S_temp(8) when Op="000" else '0';
    N <= S_temp(8) when Op="001" else '0';
    O <= '1' when (Op="010" and S_temp(15 DOWNTO 8) /= x"00") else '0';
    
    S <= S_temp(7 downto 0);
    
END Behavior;





LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE test OF ALU_tb IS
    SIGNAL A, B, S : std_logic_vector(7 DOWNTO 0);
    SIGNAL Op       : std_logic_vector(2 DOWNTO 0);
    SIGNAL C, O, N, Z : std_logic;

    COMPONENT ALU
        PORT (
            A, B : IN std_logic_vector(7 DOWNTO 0);
            Op   : IN std_logic_vector(2 DOWNTO 0);
            S    : OUT std_logic_vector(7 DOWNTO 0);
            C, O, N, Z : OUT std_logic
        );
    END COMPONENT;
BEGIN
    UUT: ALU PORT MAP(A, B, Op, S, C, O, N, Z);
    
    PROCESS
    BEGIN
        -- Test addition
        A <= "01000011"; B <= "10000010"; Op <= "000";
        WAIT FOR 50 ns;
        
        -- Test carry addition
        A <= "10000011"; B <= "11000010"; Op <= "000";
        WAIT FOR 50 ns;
        
        -- Test soustraction
        A <= "00000101"; B <= "00000011"; Op <= "001";
        WAIT FOR 50 ns;
        
        -- Test negative soustraction
        A <= "10000101"; B <= "11000011"; Op <= "001";
        WAIT FOR 50 ns;
        
        -- Test multiplication
        A <= "00000010"; B <= "00000011"; Op <= "010";
        WAIT FOR 50 ns;
        
        -- Test overflow multiplication
        A <= "10000010"; B <= "11000011"; Op <= "010";
        WAIT FOR 50 ns;
        
        -- Test AND
        A <= "00001111"; B <= "11110000"; Op <= "011";
        WAIT FOR 50 ns;
        
        -- Test OR
        A <= "00001111"; B <= "11110000"; Op <= "100";
        WAIT FOR 50 ns;
        
        -- Test XOR
        A <= "00001111"; B <= "11110000"; Op <= "101";
        WAIT FOR 50 ns;
        
        -- Test NOT
        A <= "00001111"; B <= "00000000"; Op <= "110";
        WAIT FOR 50 ns;
        
        WAIT;
    END PROCESS;
END test;