library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise4 is
    Port (LDB, S1, LDA, RD, S0, CLK : in std_logic;
          X, Y : in std_logic_vector(7 downto 0);
          RB, RA : out std_logic_vector(7 downto 0));
end Exercise4;

architecture Behavioral of Exercise4 is
    signal Mux1_out, Mux2_out, Rega_out, Regb_out : std_logic_vector(7 downto 0);
begin
    REGB: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if ((LDB and (not RD)) = '1') then
                Regb_out <= Mux1_out;
            end if;
        end if;
    end process;
    
    REGA: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if ((LDA and RD) = '1') then
                Rega_out <= Mux2_out;
            end if;
        end if;
    end process;
    
    with S1 select
    Mux1_out <= X when '1',
                Y when '0',
                (others => '0') when others;
    
    with S0 select
    Mux2_out <= Regb_out when '1',
                Y when '0',
                (others => '0') when others;
    
    RB <= Regb_out;
    RA <= Rega_out;
    
end Behavioral;
