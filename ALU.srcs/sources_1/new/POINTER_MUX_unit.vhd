----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2025 12:57:04 PM
-- Design Name: 
-- Module Name: POINTER_MUX_unit - Behavioral
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

entity POINTER_MUX_unit is
    port(
        signal A_in, C_in, OP_in : in std_logic_vector(7 downto 0);
        signal A_out : out std_logic_vector(7 downto 0)
    );
end POINTER_MUX_unit;

architecture Behavioral of POINTER_MUX_unit is
    
begin
    A_out <= C_in when (OP_in = x"0E") else A_in;
end Behavioral;
