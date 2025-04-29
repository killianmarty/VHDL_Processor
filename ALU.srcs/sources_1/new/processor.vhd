----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 11:09:27 AM
-- Design Name: 
-- Module Name: processor - Behavioral
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

entity processor is
    Port(
        clk : in std_logic;
        rst : in std_logic
    );
end processor;

architecture rtl of processor is
    signal PC, PC_next : std_logic_vector(7 downto 0);
    signal instruction  : std_logic_vector(31 downto 0);
    
    signal LI_A, LI_OP, LI_B, LI_C : std_logic_vector(7 downto 0);
    signal DI_A, DI_OP, DI_B, DI_C : std_logic_vector(7 downto 0);
    signal EX_A, EX_OP, EX_B, EX_C : std_logic_vector(7 downto 0);
    signal MEM_A, MEM_OP, MEM_B, MEM_C : std_logic_vector(7 downto 0);
    signal RE_A, RE_OP, RE_B, RE_C : std_logic_vector(7 downto 0);
    signal LC_REG : std_logic;
begin
    ----------------------------------------------------------------
    -- Fetch Stage
    ----------------------------------------------------------------
    PC_next <= std_logic_vector(unsigned(PC) + 4);
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                PC <= (others => '0');
            else
                PC <= PC_next;
            end if;
        end if;
    end process;

    -- Instruction Memory
    instr_mem: entity work.instr_memory
        port map(
            clk  => clk,
            ADDR => PC,
            INSTR => instruction
        );

    -- LI/DI Pipeline Register
    LIDI_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => instruction(23 downto 16),
            OP_in  => instruction(31 downto 24),
            B_in   => instruction(15 downto 8),
            C_in   => (others => '0'),
            A_out  => DI_A,
            OP_out => DI_OP,
            B_out  => DI_B,
            C_out  => DI_C,
            enable => '1'
        );
        
    -- DI/EX Pipeline Register
    DIEX_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => DI_A,
            OP_in  => DI_OP,
            B_in   => DI_B,
            C_in   => (others => '0'),
            A_out  => EX_A,
            OP_out => EX_OP,
            B_out  => EX_B,
            C_out  => EX_C,
            enable => '1'
        );
        
    -- EX/MEM Pipeline Register
    EXMEM_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => EX_A,
            OP_in  => EX_OP,
            B_in   => EX_B,
            C_in   => (others => '0'),
            A_out  => MEM_A,
            OP_out => MEM_OP,
            B_out  => MEM_B,
            C_out  => MEM_C,
            enable => '1'
        );
        
        
     -- MEM/RE Pipeline Register
     MEMRE_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => MEM_A,
            OP_in  => MEM_OP,
            B_in   => MEM_B,
            C_in   => (others => '0'),
            A_out  => RE_A,
            OP_out => RE_OP,
            B_out  => RE_B,
            C_out  => RE_C,
            enable => '1'
        );
        
    LC_unit: entity work.LC
        port map(
            OP => RE_OP,
            W => LC_REG
        );
        
    -- register bench
    regfile: entity work.Registers_bench
        port map(
            clk     => clk,
            rst     => rst,
            W => RE_A,
            DATA => RE_B,
            WE => LC_REG,
            A => (others => '0'),
            B => (others => '0')
        );

end rtl;
