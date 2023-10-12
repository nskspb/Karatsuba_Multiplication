library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity top is
generic (
    C_WIDTH: natural := 32

);
 port (
 iclk: in std_logic;
 ia: in std_logic_vector(C_WIDTH - 1 downto 0);
 ib: in std_logic_vector (C_WIDTH - 1 downto 0);
 oq: out std_logic_vector  (C_WIDTH + C_WIDTH - 1 downto 0);
 oq2: out std_logic_vector  (C_WIDTH + C_WIDTH - 1 downto 0)
 );
 
end top;


architecture Behavioral of top is
    begin

    mult_simple: entity work.mult(Behavioral)
    generic map ( C_WIDTH => C_WIDTH )
    port map(
        ia => ia,
        ib => ib,
        oq => oq,
        iclk => iclk
    );
    
    karatsuba: entity work.karatsuba(Behavioral)
    generic map ( C_WIDTH => C_WIDTH )
    port map(
        ia => ia,
        ib => ib,
        oq => oq2,
        iclk => iclk
    );

end Behavioral;
