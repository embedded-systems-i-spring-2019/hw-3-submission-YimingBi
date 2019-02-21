library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Exercise2 is
    Port ( DS, CLK : in std_logic;
           X, Y, Z : in std_logic_vector(7 downto 0);
           MS : in std_logic_vector(1 downto 0);
           RB, RA : out std_logic_vector(7 downto 0));
end Exercise2;

architecture Behavioral of Exercise2 is
    
    signal dec_result_0, dec_result_1 : std_logic;
    signal Reg_result_A, Reg_result_B, Mux_result : std_logic_vector(7 downto 0);

begin
    RegB: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_result_1 = '1') then
                Reg_result_B <= Reg_result_A;
            end if;
        end if;
    end process;
    
    RegA: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (dec_result_0 = '1') then
                Reg_result_A <= Mux_result;
            end if;
        end if;
    end process;
    
    with MS select
    Mux_result <= X when "11",
                  Y when "10",
                  Z when "01",
                  Reg_result_B when "00",
                  (others => '0') when others;
    
    dec_result_0 <= '1' when (DS = '0') else '0';
    dec_result_1 <= '1' when (DS = '1') else '0';
    
    RA <= Reg_result_A;
    RB <= Reg_result_B;

end Behavioral;
