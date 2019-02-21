library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise1 is
    Port ( LDA, SEL, CLK : in STD_LOGIC;
           A, B : in STD_LOGIC_VECTOR (7 downto 0);
           F : out STD_LOGIC_VECTOR (7 downto 0));
end Exercise1;

architecture Behavioral of Exercise1 is

    signal mux_result : STD_LOGIC_VECTOR (7 downto 0);
    
begin

    Reg_A: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                F <= mux_result;
            end if;
        end if;
    end process;
    
    with SEL select
    mux_result <= A when '1',
                  B when '0',
                  (others => '0') when others;

end Behavioral;
