----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2025 10:16:33 AM
-- Design Name: 
-- Module Name: MUX_unit - Behavioral
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

entity EX_MUX_unit is
    Port (
        OP_in  : in  std_logic_vector(7 downto 0);
        B_in  : in  std_logic_vector(7 downto 0);
        data_in  : in  std_logic_vector(7 downto 0);
        data_out : out  std_logic_vector(7 downto 0)
    );
end EX_MUX_unit;

architecture Behavioral of EX_MUX_unit is

begin

    with OP_in select data_out <=
        data_in when x"01",
        data_in when x"02",
        data_in when x"03",
        data_in when x"04",
        B_in when others;

end Behavioral;