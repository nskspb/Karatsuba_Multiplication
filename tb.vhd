library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture Behavioral of testbench is
    constant C_WIDTH: natural := 32;
    signal ia: std_logic_vector(C_WIDTH - 1 downto 0) := (others => '0');
    signal ib: std_logic_vector(C_WIDTH - 1 downto 0) := (others => '0');
    signal oq, oq2: std_logic_vector (C_WIDTH + C_WIDTH - 1 downto 0) := (others => '0');
    
    signal iclk: std_logic := '0';
    
    constant clock_period : time := 10ns;
    
    signal error: std_logic := '0';

begin

    iclk <= not iclk after clock_period/2;
    
    golden: entity work.mult(Behavioral)
    generic map ( C_WIDTH => C_WIDTH )
    port map(
        ia => ia,
        ib => ib,
        oq => oq,
        iclk => iclk
    );
    
    dut: entity work.karatsuba(Behavioral)
    generic map ( C_WIDTH => C_WIDTH )
    port map(
        ia => ia,
        ib => ib,
        oq => oq2,
        iclk => iclk
    );
    
    process begin
        wait for 250ns;
        ia <= std_logic_vector(to_unsigned(1111_3333, ia'length));
        ib <= std_logic_vector(to_unsigned(5555_7777, ib'length));
        wait for clock_period;
        
        ia <= std_logic_vector(to_unsigned(534533, ia'length));
        ib <= std_logic_vector(to_unsigned(775377, ib'length));
        wait for clock_period;
        
     --   ia <= b"01011100011110001110110001111110111111110010100011100000011101000101110001111000111011000111111011111111001010001110000001110100";
       -- ib <= std_logic_vector(to_unsigned(5555_7777, ib'length));
       -- wait for clock_period;
        
        ia <= (others => '0');
        ib <= (others => '0');
        wait;
    end process;
    
    process (iclk) begin
        if falling_edge(iclk)then
            if (oq /= oq2) then
                error <= '1';
            else
                error <= '0';
            end if;
        end if;
    end process;
end Behavioral;
