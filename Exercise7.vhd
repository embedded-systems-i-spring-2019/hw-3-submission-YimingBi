library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux4 is
    Port ( inpt1, inpt2, inpt3, inpt4 : in std_logic_vector(7 downto 0);
           Sel : in std_logic_vector(1 downto 0);
           outpt : out std_logic_vector(7 downto 0));
end Mux4;
architecture Mux4 of Mux4 is
begin
    with Sel select
    outpt <= inpt1 when "11",
             inpt2 when "10",
             inpt3 when "01",
             inpt4 when "00",
             (others => '0') when others;
end Mux4;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is 
    Port ( inpt : in std_logic_vector(7 downto 0);
           LD, CLK : in std_logic;
           outpt : out std_logic_vector(7 downto 0));
end Reg;
architecture Reg of Reg is
begin
    reg: process(CLK)
    begin 
        if (rising_edge(CLK)) then
            if (LD = '1') then
                outpt <= inpt;
            end if;
        end if;
    end process;
end Reg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is 
    Port ( inpt : in std_logic;
           outpt0, outpt1 : out std_logic);
end Decoder;
architecture Decoder of Decoder is
begin
    outpt0 <= '1' when (inpt = '0') else '0';
    outpt1 <= '1' when (inpt = '1') else '0';
end Decoder;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex2 is
    Port( DS, CLK : in std_logic;
          X, Y, Z : in std_logic_vector(7 downto 0);
          MS : in std_logic_vector(1 downto 0);
          RB, RA : out std_logic_vector(7 downto 0));
end ex2;
architecture ex2 of ex2 is
    component Mux4
        Port ( inpt1, inpt2, inpt3, inpt4 : in std_logic_vector(7 downto 0);
               Sel : in std_logic_vector(1 downto 0);
               outpt : out std_logic_vector(7 downto 0));
    end component;
    component Reg
        Port ( inpt : in std_logic_vector(7 downto 0);
               LD, CLK : in std_logic;
               outpt : out std_logic_vector(7 downto 0));
    end component;
    component Decoder
        Port ( inpt : in std_logic;
               outpt0, outpt1 : out std_logic);
    end component;
    
    signal deco_result_0, deco_result_1 : std_logic;
    signal mux_result : std_logic_vector(7 downto 0);
    signal RegA_result, RegB_result : std_logic_vector(7 downto 0);
    
begin
    De: Decoder
    port map (inpt => DS,
              outpt0 => deco_result_0,
              outpt1 => deco_result_1 );
    Mx: Mux4
    port map (inpt1 => X,
              inpt2 => Y,
              inpt3 => Z,
              inpt4 => RegB_result,
              Sel => MS,
              outpt => mux_result );
    Rega: Reg
    port map (inpt => mux_result,
              LD => deco_result_0,
              CLK => CLK,
              outpt => RegA_result );
    
    Regb: Reg
    port map (inpt => RegA_result,
              LD => deco_result_1,
              CLK => CLK,
              outpt => RegB_result );  
    RA <= RegA_result;
    RB <= RegB_result;        
end ex2;

































