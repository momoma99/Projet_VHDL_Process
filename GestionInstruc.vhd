library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

Entity GestionInstruc is
  generic(N: integer :=8);
  port(
        clk: in std_logic;
        rst: in std_logic;
        Offset: in std_logic_vector(N-1 downto 0); --Entrée du sign extender
        nPCsel: in std_logic;-- selecteur du mux2 vers 1;
        Instruction: out std_logic_vector(31 downto 0)     
  );
end entity;

Architecture behav of GestionInstruc is

signal IPC1,IPC2: std_logic_vector(31 downto 0);--entree et sortie regsitre du mux;
signal PC: std_logic_vector(31 downto 0);--regsitre PC;
signal Stend:  std_logic_vector(31 downto 0);--Sortie du sign extend

-- Declaration Type Tableau Memoire
	type table is array (63 downto 0) of std_logic_vector(31 downto 0);
	
	-- Fonction d'Initialisation du Banc de Registres
	function init_banc return table is
	variable result : table;
	begin
	for i in 62 downto 2 loop
	 result(i) := (others=>'0');
	 end loop;
	 result(63):=X"00000030";
	 
	 result(1):=X"00000001";
	 result(0):=X"00000000";
	 return result;
	end init_banc;
	
	-- DÃ©claration et Initialisation du Banc de Registres 64x32 bits
	signal Banc: table:=init_banc;
  
begin
  Instruction<=Banc(to_integer(unsigned(PC(5 downto 0))));
  
  U1:entity work.sign_extend port map( E=>offset, S=>Stend);
  U2:entity work.Mux2_1 port map(A=>IPC1, B=>IPC2, Com=>nPCsel, S=>PC);
   
  process(rst,clk)
    begin
      if rst='1' then
        -- les entrées a 0
        PC<= (others=>'0');
       elsif rising_edge(clk) then
         
         banc(to_integer(unsigned(PC(5 downto 0))))<=PC;
         IPC1<= PC+std_logic_vector(to_unsigned(1,32));
         IPC2<= PC + std_logic_vector(to_unsigned(1,32)) +Stend(To_integer(unsigned(offset)));
         
       end if;
       
     end process;
  
   end architecture;