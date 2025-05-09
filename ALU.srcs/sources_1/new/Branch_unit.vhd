----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 04:26:27 PM
-- Design Name: 
-- Module Name: Branch_unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Branch_unit is
    Port (
        clk: in std_logic;
        OP_in  : in  std_logic_vector(7 downto 0);
        A_in, B_in  : in  std_logic_vector(7 downto 0);
        PC_out : out  std_logic_vector(7 downto 0);
        Jump : out std_logic
    );
end Branch_unit;

architecture Behavioral of Branch_unit is

begin
--    process(clk)
--    begin
--        if rising_edge(clk) then
--            if ((OP_in = x"07") or (OP_in = x"08" and B_in = x"00")) then
--                PC_out <= A_in;
--                Jump <= '1';
--            else
--                PC_out <= A_in;
--                Jump <= '0';
--            end if;
--        end if;
--    end process;
    PC_out <= A_in;
    Jump <= '1' when ((OP_in = x"07") or (OP_in = x"08" and B_in = x"00")) else '0';
end Behavioral;
