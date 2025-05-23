----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 02:40:26 PM
-- Design Name: 
-- Module Name: MEM_MUX_unit - Behavioral
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

entity MEM_MUX_unit is
    Port (
        clk, flush: in std_logic;
        OP_in  : in  std_logic_vector(7 downto 0);
        B_in  : in  std_logic_vector(7 downto 0);
        data_in  : in  std_logic_vector(7 downto 0);
        data_out : out  std_logic_vector(7 downto 0)
    );
end MEM_MUX_unit;

architecture Behavioral of MEM_MUX_unit is

begin
    
    process (clk)
    begin
        if flush = '1' then
            data_out <= x"00";
        elsif OP_in = x"10" or OP_in = x"0F" then
            data_out <= data_in;
        elsif rising_edge(clk) then
            data_out <= B_in;
        end if;
    end process;

end Behavioral;
