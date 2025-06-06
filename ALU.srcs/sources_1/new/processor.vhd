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
USE ieee.std_logic_unsigned.ALL;

entity processor is
    Port(
        clk : in std_logic;
        rst : in std_logic
    );
end processor;

architecture rtl of processor is
    signal PC : std_logic_vector(7 downto 0);
    signal instruction, instruction_next  : std_logic_vector(31 downto 0);
    signal COUNTER_ENABLE : std_logic;
    
    signal LI_A, LI_OP, LI_B, LI_C : std_logic_vector(7 downto 0);
    signal DI_A, DI_OP, DI_B, DI_C : std_logic_vector(7 downto 0);
    signal EX_A, EX_OP, EX_B, EX_C : std_logic_vector(7 downto 0);
    signal MEM_A, MEM_OP, MEM_B, MEM_C : std_logic_vector(7 downto 0);
    signal RE_A, RE_OP, RE_B, RE_C : std_logic_vector(7 downto 0);
    signal QA_DI_MUX, MUX_DI : std_logic_vector(7 downto 0);
    signal ALU_MUX, EX_MUX_B: std_logic_vector(7 downto 0);
    signal REG_C, POINTER_MUX_A: std_logic_vector(7 downto 0);
    signal DATAMEM_MUX, DATAMEM_MUX_RE, MEM_STORE_MUX_DAT_MEM: std_logic_vector(7 downto 0);
    signal LC_REG : std_logic;
    signal MEM_LC_DATAMEM : std_logic;
    
    signal JUMP_PC : std_logic_vector(7 downto 0);
    signal JUMP : std_logic;
    
    signal LED_SIGNALS: std_logic_vector(7 downto 0) := (others => '0');
    
begin
    ----------------------------------------------------------------
    -- Fetch Stage
    ----------------------------------------------------------------
    program_counter: entity work.counter
        port map(
            clock => clk,
            direction => '1',
            enable => COUNTER_ENABLE,
            clear => rst,
            value => PC,
            update => JUMP,
            updated_value => JUMP_PC
        );
    
    alea_predictor: entity work.alea_predictor
        port map(
            clock => clk,
            rst => JUMP,
            instruction => instruction_next,
            LIDI => instruction(31 downto 24),
            LIDI_addr => instruction(23 downto 16),
            DIEX => DI_OP,
            DIEX_addr => DI_A,
            EXMEM => EX_OP,
            EXMEM_addr => EX_A,
            MEMRE => MEM_OP,
            MEMRE_addr => MEM_A,
            enable_counter => COUNTER_ENABLE
        );

    -- Instruction Memory
    instr_mem: entity work.instr_memory
        port map(
            clk  => clk,
            ENABLED => COUNTER_ENABLE,
            ADDR => PC,
            INSTR => instruction,
            INSTR_NEXT => instruction_next
        );

    -- LI/DI Pipeline Register
    LIDI_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => JUMP,
            A_in   => instruction(23 downto 16),
            OP_in  => instruction(31 downto 24),
            B_in   => instruction(15 downto 8),
            C_in   => instruction(7 downto 0),
            A_out  => DI_A,
            OP_out => DI_OP,
            B_out  => DI_B,
            C_out  => DI_C,
            enable => '1'
        );
        
    DI_MUX: entity work.DI_MUX_unit
        port map(
            OP_in => DI_OP,
            B_in => DI_B,
            data_in => QA_DI_MUX,
            data_out => MUX_DI
        );
        
    POINTER_MUX: entity work.POINTER_MUX_unit
        port map(
            OP_in => DI_OP,
            A_in => DI_A,
            C_in => REG_C,
            A_out => POINTER_MUX_A
        );
        
    -- DI/EX Pipeline Register
    DIEX_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => JUMP,
            A_in   => POINTER_MUX_A, -- POINTER_MUX_A
            OP_in  => DI_OP,
            B_in   => MUX_DI,
            C_in   => REG_C,
            A_out  => EX_A,
            OP_out => EX_OP,
            B_out  => EX_B,
            C_out  => EX_C,
            enable => '1'
        );
        
    -- Branch unit
    Branch_unit: entity work.Branch_unit
        port map(
            clk => clk,
            OP_in => EX_OP,
            A_in => EX_A,
            B_in => EX_B,
            PC_out => JUMP_PC,
            Jump => JUMP
        );
        
    -- ALU
    ALU: entity work.ALU
        port map(
            A => EX_B,
            B => EX_C,
            S => ALU_MUX,
            Op => EX_OP
        );
        
    -- PRINT UNIT
    process(clk)
    begin
        if(EX_OP=x"09") then
            LED_SIGNALS <= EX_B;
        end if;
    end process;
        
    -- MUX of EX stage
    EX_MUX: entity work.EX_MUX_unit
        port map(
            B_in => EX_B,
            OP_in => EX_OP,
            data_in => ALU_MUX,
            data_out => EX_MUX_B
        );
        
    -- EX/MEM Pipeline Register
    EXMEM_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => EX_A,
            OP_in  => EX_OP,
            B_in   => EX_MUX_B,
            C_in   => (others => '0'),
            A_out  => MEM_A,
            OP_out => MEM_OP,
            B_out  => MEM_B,
            C_out  => MEM_C,
            enable => '1'
        );
        
     -- MEM STORE MUX
     MEM_STORE_MUX: entity work.MEM_STORE_MUX_unit
        port map(
            OP_in => MEM_OP,
            A_in => MEM_A,
            B_in => MEM_B,
            data_out => MEM_STORE_MUX_DAT_MEM
        );
        
     -- MEM LC
     MEM_LC: entity work.MEM_LC
        port map(
            OP => MEM_OP,
            RW => MEM_LC_DATAMEM
        );
        
     -- DATA MEMORY
     DATA_MEM: entity work.data_memory
        port map(
            CLK => clk,
            RW => MEM_LC_DATAMEM,
            ADDR => MEM_STORE_MUX_DAT_MEM,
            IN_DATA => MEM_B,
            OUT_DATA => DATAMEM_MUX
        );
        
     -- MEM MUX
     MEM_MUX: entity work.MEM_MUX_unit
        port map(
            B_in => MEM_B,
            OP_in => RE_OP,
            data_in => DATAMEM_MUX,
            data_out => DATAMEM_MUX_RE,
            clk => clk,
            flush => rst
        );
        
        
     -- MEM/RE Pipeline Register
     MEMRE_stage: entity work.pipeline
        port map(
            clk    => clk,
            flush  => rst,
            A_in   => MEM_A,
            OP_in  => MEM_OP,
            B_in   => (others => '0'),
            C_in   => (others => '0'),
            A_out  => RE_A,
            OP_out => RE_OP,
            B_out  => RE_B,
            C_out  => RE_C,
            enable => '1'
        );
        
    RE_LC_unit: entity work.RE_LC
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
            DATA => DATAMEM_MUX_RE,
            WE => LC_REG,
            QA => QA_DI_MUX,
            A => DI_B,
            B => DI_C,
            QB => REG_C
        );

end rtl;
