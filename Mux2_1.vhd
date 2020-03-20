library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux2_1 is
generic(N: integer :=32);

 port(
	A,B : in std_logic_vector(N-1 downto 0);
	Com: in std_logic;
	S: out std_logic_vector(N-1 downto 0)
);
end entity;

Architecture behaviour of Mux2_1 is
begin
process(A,B,Com)
begin
case Com is 
when '0' => S <= A;
when '1' => S <= B; 
when others => S <= (others => '0');
end case;
end process;
end architecture;