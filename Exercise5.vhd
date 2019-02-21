library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise5 is
    Port (A, B, C : in std_logic_vector(7 downto 0);
          SL1, SL2, CLK : in std_logic;
          RAX, RBX : out std_logic_vector(7 downto 0));
end Exercise5;

architecture Behavioral of Exercise5 is
    signal dec_out1, dec_out0 : std_logic;
    signal mux_out : std_logic_vector(7 downto 0);
begin
    rega: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_out1 = '1') then
                RAX <= A;
            end if;
        end if;
    end process;
    
    regb: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_out0 = '1') then
                RBX <= mux_out;
            end if;
        end if;
    end process;
    
    dec_out1 <= '1' when (SL1 = '1') else '0';
    dec_out0 <= '1' when (SL1 = '0') else '0';
    
    with SL2 select
    mux_out <= B when '1',
               C when '0',
               (others => '0') when others;

end Behavioral;
