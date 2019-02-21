library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise3 is
    Port ( LDB, LDA, S1, S0, CLK : in std_logic;
           X, Y : in std_logic_vector(7 downto 0);
           RB : out std_logic_vector(7 downto 0));
end Exercise3;

architecture Behavioral of Exercise3 is
    signal Mux1_out, Mux2_out, Rega_out, Regb_out : std_logic_vector(7 downto 0);
begin
    regb: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDB = '1') then
                Regb_out <= Mux2_out;
            end if;
    end if;
    end process; 
    rega: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                Rega_out <= Mux1_out;
            end if;
    end if;
    end process; 

    with S1 select
    Mux1_out <= X when '1',
                Regb_out when '0',
                (others => '0') when others;
    with S0 select
    Mux2_out <= Rega_out when '1',
                Y when '0',
                (others => '0') when others;
    RB <= Regb_out;
    
end Behavioral;
