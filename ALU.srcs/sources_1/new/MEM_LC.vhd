----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 02:24:53 PM
-- Design Name: 
-- Module Name: MEM_LC - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEM_LC is
    Port (
        OP         : in  std_logic_vector(7 downto 0);
        RW   : out std_logic
    );
end MEM_LC;

architecture Behavioral of MEM_LC is
begin
    process(OP)
    begin
        RW <= '1';

        case OP is
            when x"10" =>  -- LOAD
                RW <= '1';
            when x"11" => -- STORE
                RW <= '0';
                
            when others =>
                null;
        end case;
    end process;
end Behavioral;
