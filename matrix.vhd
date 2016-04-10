----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:26:44 04/05/2016 
-- Design Name: 
-- Module Name:    matrix - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity matrix is
    Port ( CLK1 : in  STD_LOGIC;
	 		  sw : in   STD_LOGIC_VECTOR (7 downto 0) ;
			  JA : out  STD_LOGIC_VECTOR (3 downto 0) ;
			  JB : out  STD_LOGIC_VECTOR (3 downto 0) ;
			  JC : out  STD_LOGIC_VECTOR (3 downto 0) ;
           JD : out  STD_LOGIC_VECTOR (3 downto 0) 
			  );
end matrix;

architecture Behavioral of matrix is
	signal count1 : integer range 0 to 49999999 :=0;
	signal count2 : integer range 0 to 49999 :=0;
	signal speed  : integer range 0 to 49999999 :=0;
	signal row_mask  : std_logic_vector (7 downto 0):= "00000001";
	signal col_mask  : std_logic_vector (63 downto 0):=
   "0010010000000000000100000000100000010000010000100011110000000000";
begin
	counter : process(CLK1)
	begin 
		--col_mask(7 downto 0) <= sw(7 downto 0);
		if sw(0)="1" then
			speed <= 49999;
		end if;
		if sw(1)="1" then
			speed <= 499999;
		end if;
		if sw(2)="1" then
			speed <= 4999999;
		end if;
		if sw(3)="1" then
			speed <= 49999999;
		end if;
		if CLK1'event and CLK1 = '1' then
			if count1 = speed then
				count1 <= 0;
				col_mask <= to_stdlogicvector(to_bitvector(col_mask) ror 8);
				row_mask <= to_stdlogicvector(to_bitvector(row_mask) ror 1);
			else
				count1 <= count1 + 1;
			end if;
			if count2 = 49999 then
				count2 <= 0;
			else
				count2 <= count2 + 1;
			end if;
		end if;
	end process;
	JB(0) <= col_mask(0); -- and "10000000";
	JA(1) <= col_mask(1); 	--and "01000000";
	JB(2) <= col_mask(2); 	--and "00100000";
	JA(0) <= col_mask(3); 	--and "00010000";
	JD(0) <= col_mask(4);   --and "00001000";
	JB(3) <= col_mask(5); 	--and "00000100";
	JC(2) <= col_mask(6); 	--and "00000010";
	JD(3) <= col_mask(7); 	--and "00010001";	
	
	JC(0) <= not row_mask(0); --and "10000000";
	JC(1) <= not row_mask(1); --and "01000000";
	JD(1) <= not row_mask(2); --and "00100000";
	JB(1) <= not row_mask(3); --and "00010000";
	JD(2) <= not row_mask(4); --and "00000010";
	JA(3) <= not row_mask(5); --and "00000100";
	JA(2) <= not row_mask(6); --and "00001000";
	JC(3) <= not row_mask(7); --and "00010001";	

end Behavioral;

