----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 03:13:40 PM
-- Design Name: 
-- Module Name: MEM_STORE_MUX_unit - Behavioral
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

entity MEM_STORE_MUX_unit is
    Port (
        OP_in  : in  std_logic_vector(7 downto 0);
        A_in, B_in  : in  std_logic_vector(7 downto 0);
        data_out : out  std_logic_vector(7 downto 0)
    );
end MEM_STORE_MUX_unit;

architecture Behavioral of MEM_STORE_MUX_unit is

begin

    with OP_in select data_out <=
        A_in when x"11",
        A_in when x"0E",
        B_in when others;

end Behavioral;
