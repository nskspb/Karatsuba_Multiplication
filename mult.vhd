library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity mult is

generic (
    C_WIDTH: natural := 32
);
port (
    iclk: in std_logic;
    ia: in std_logic_vector(C_WIDTH - 1 downto 0);
    ib: in std_logic_vector (C_WIDTH - 1 downto 0);
    oq: out std_logic_vector  (C_WIDTH + C_WIDTH - 1 downto 0)
);
end mult;

architecture Behavioral of mult is

    signal a: std_logic_vector(ia'range) := (others => '0');
    signal b: std_logic_vector(ib'range) := (others => '0');

    --delay for test with karatsuba algorith
    signal q, q_dff1, q_dff2, q_dff3, q_dff4 : std_logic_vector(oq'range) := (others => '0');
    
begin

pure_mult: process(iclk) begin
        if rising_edge (iclk) then
            a <= ia;
            b <= ib;
            q <= a * b;
            q_dff1 <= q;
            q_dff2 <= q_dff1;
            q_dff3 <= q_dff2;
            oq <= q_dff3;
        end if;
    end process;

end Behavioral;
