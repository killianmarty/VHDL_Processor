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
    signal PC, PC_next : std_logic_vector(31 downto 0);
    signal instruction  : std_logic_vector(31 downto 0);
    
    signal LI_A, LI_OP, LI_B, LI_C : std_logic_vector(7 downto 0);
    signal DI_A, DI_OP, DI_B, DI_C : std_logic_vector(7 downto 0);
    signal EX_A, EX_OP, EX_B : std_logic_vector(7 downto 0);
    signal MEM_A, MEM_OP, MEM_B : std_logic_vector(7 downto 0);
    signal RE_A, RE_OP, RE_B : std_logic_vector(7 downto 0);
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
        
    -- todo fix the rest

    ----------------------------------------------------------------
    -- Decode Stage
    ----------------------------------------------------------------
    regfile: entity work.Registers_bench
        port map(
            clk     => clk,
            rst     => rst,
            rs_addr => IF_B(31 downto 27),
            rt_addr => IF_B(26 downto 22),
            rd_addr => IF_B(21 downto 17),
            rd_data => WB_A,
            we      => WB_OP(0),
            rs_data => ID_A,
            rt_data => ID_B
        );

    -- ID/EX Pipeline Register
    ID_stage: entity work.pipeline
        port map(
            clk    => clk,
            rst    => rst,
            A_in   => ID_A,
            OP_in  => IF_OP,
            B_in   => ID_B,
            C_in   => IF_B(15 downto 0) & (others => '0'),
            A_out  => ID_A,
            OP_out => ID_OP,
            B_out  => ID_B,
            C_out  => ID_C
        );

    ----------------------------------------------------------------
    -- Execute Stage
    ----------------------------------------------------------------
    alu_inst: entity work.ALU
        port map(
            A      => ID_A,
            B      => ID_C,
            Op     => ID_OP,
            Result => EX_A
        );

    EX_stage: entity work.pipeline
        port map(
            clk    => clk,
            rst    => rst,
            A_in   => EX_A,
            OP_in  => ID_OP,
            B_in   => ID_B,
            C_in   => (others => '0'),
            A_out  => EX_A,
            OP_out => EX_OP,
            B_out  => EX_B,
            C_out  => EX_C
        );

    ----------------------------------------------------------------
    -- Memory Stage
    ----------------------------------------------------------------
    data_mem: entity work.data_memory
        port map(
            clk  => clk,
            addr => EX_A,
            din  => EX_B,
            we   => EX_OP(1),
            dout => WB_A
        );

    MEM_stage: entity work.pipeline
        port map(
            clk    => clk,
            rst    => rst,
            A_in   => WB_A,
            OP_in  => EX_OP,
            B_in   => (others => '0'),
            C_in   => (others => '0'),
            A_out  => WB_A,
            OP_out => WB_OP,
            B_out  => WB_B,
            C_out  => WB_C
        );

    ----------------------------------------------------------------
    -- Write Back handled by regfile input (WB_A and WB_OP)
    ----------------------------------------------------------------

end rtl;
