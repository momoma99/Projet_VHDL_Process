library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Gesti is
end entity;

architecture bench of tb_Gesti is
  signal rst:   std_logic;         -- reset de l'interface
   signal	clk :   std_logic; 
    signal Offset:  std_logic_vector(7 downto 0); --Entrée du sign extender
    signal nPCsel:  std_logic;-- selecteur du mux2 vers 1;
    signal Instruction:  std_logic_vector(31 downto 0);
    
    begin
      
      UUT: entity work.GestionInstruc port map(clk=>clk,rst=>rst,Offset=>Offset,nPCsel=>nPCsel,Instruction=>Instruction);
      
       horloge:process is
        begin
        clk<='1';
        wait for 10 ns;
        clk<='0';
        wait for 10 ns;
        end process;
        
      --signal genere
      signal_gen: process
          begin
            rst<='1';
            Offset<="00000000";
            nPCsel<='0';
            wait for 20 ns;
            rst<='0';
            Offset<="00000000";
            nPCsel<='0';
            wait for 20 ns;
            Offset<="00000000";
            nPCsel<='1';
            wait for 20 ns;
            Offset<="00000001";
            nPCsel<='1';
            wait for 20 ns;
            Offset<="00000001";
            nPCsel<='0';
            wait for 20 ns;
            wait;   
            
          end process;
        end architecture;
            
            
    
     