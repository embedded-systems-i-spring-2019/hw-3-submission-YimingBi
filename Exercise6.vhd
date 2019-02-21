library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise6 is
    Port (A, B, C : in std_logic_vector(7 downto 0);
          SEL1, SEL2, CLK : in std_logic;
          RAP, RBP : out std_logic_vector(7 downto 0));
end Exercise6;

architecture Behavioral of Exercise6 is
    signal mux_out : std_logic_vector(7 downto 0);
    signal dec_out1, dec_out0 : std_logic;
begin
    rega: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_out1 = '1') then
                RAP <= mux_out;
            end if;
        end if;
    end process;
    
    regb: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_out0 = '1') then
                RBP <= C;
            end if;
        end if;
    end process;
    
    dec_out1 <= '1' when (SEL2 = '1') else '0';
    dec_out0 <= '1' when (SEL2 = '0') else '0';
    
    with SEL1 select
    mux_out <= A when '1',
               B when '0',
               (others => '0') when others;

end Behavioral;
