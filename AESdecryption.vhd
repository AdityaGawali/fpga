library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decrypt1 is
  Port ( 
         clk : in std_logic
         
         );
end decrypt1;

architecture Behavioral of decrypt1 is

signal state_data : unsigned(127 downto 0) :=  X"29C3505F571420F6402299B31A02D73A"; --X"901a02049e87964d1b92c643ffe80460"; 
signal state_matrix : matrix := (others => (others =>X"00"));
signal sbox_mat : matrix := (others => (others =>X"00"));

signal  a :  matrix := ((x"14", x"11",x"13",x"09" ), (x"09", x"14",x"11",x"13" ),(x"13", x"09",x"14",x"11" ),(x"11", x"13",x"09",x"14" ));
signal b : matrix := (others=>(others => x"00"));

signal address : std_logic_vector(11 downto 0);
signal address1 : std_logic_vector(11 downto 0);
signal enable :  std_logic := '1';
signal data_out : std_logic_vector(7 downto 0);
signal data_out1 : std_logic_vector(7 downto 0);

 signal prod : matrix := (others=>(others=>(others=>'0')));
 signal sum : unsigned(7 downto 0) := "00000000";

signal count,count1,counter : integer := 0;
signal i,j,k,i1 : integer :=0; 
--shared variable ready : integer := 0;
--signal ready : integer := 0;
signal ready : integer := 0;
-------------------------------keys--------------------------------------------
signal temp:STD_LOGIC_VECTOR(7 downto 0);
  signal finalKey:fKey;
  signal key0 : key  := (x"54",x"68",x"61",x"74");--(x"54",x"73",x"20",x"67");----(x"a0",x"fa",x"fe",x"17");--
  signal key1 : key  := (x"73",x"20",x"6D",x"79");--(x"68",x"20",x"4b",x"20");----(x"88",x"54",x"2c",x"b1");--
  signal key2 : key  := (x"20",x"4B",x"75",x"6E");--(x"61",x"6d",x"75",x"46");----(x"23",x"a3",x"39",x"39");--
  signal key3 : key  := (x"67",x"20",x"46",x"75");--(x"74",x"79",x"6e",x"75");----(x"2a",x"6c",x"76",x"05");--
  signal a1: integer range 0 to 5 :=0;
  signal j1: integer :=0;
  signal k1: integer :=0;
  signal b1: integer :=0;
  signal n: integer :=0;
  signal q: integer :=0;
  signal g: integer :=0;
  signal count2:integer :=1;
  signal conv:integer :=1;
  signal firsttime:integer :=1;
  signal count3 : integer := 10;
-------------------------------------------------------------------------------

signal data_loaded : integer := 0;
signal keyDone : integer := 0;
signal delay : integer := 0;

signal i2,j2,k2 : integer := 0;
 signal output : matrix := (others =>(others =>X"00"));
 signal toggle : integer := 0;

signal firstKey : integer := 0;

signal cipher : data128(0 to 5) := (others=>(x"00000000000000000000000000000000"));
signal number : integer := 0;
shared variable final : unsigned(127 downto 0) ;
shared variable count4 : integer := 127;


begin 

your_instance_name : blk_mem_gen_1
  PORT MAP (
    clka => clk,
    addra => address,
    douta => data_out
  );

your_instance_name_1 : blk_mem_gen_1
  PORT MAP (
    clka => clk,
    addra => address1,
    douta => data_out1
  );

main : process (clk)
begin

if(data_loaded = 0) then
    state_matrix <= load_mat(state_data);
    data_loaded <= 1;
end if;

    if(rising_edge(clk))then  
        if(ready = 0 and keyDone = 1 )then
              if(j2 < 4) then
                 if(k2 < 4) then
                    if(firstKey = 0) then
                      output(j2)(k2) <= unsigned(finalKey(4*count3 + k2)(j2)) xor state_matrix(j2)(k2); -------------------------------------------------------
                    else output(j2)(k2) <= unsigned(finalKey(4*count3 + k2)(j2)) xor (sbox_mat(j2)(k2));
                    end if; ----------------------------------------fisrtKey
                k2 <= k2 + 1;
            end if;       ---------------------------------k
            
            if(k2 = 4) then 
                j2 <= j2 + 1;
                k2 <= 0;
            end if;
        end if;       --------------------------------j
        if(j2 = 4) then
            if(firstKey = 0) then
                count3 <= count3 - 1;
                b <= col_shift(output);
                firstKey <= 1;
            end if;
            j2 <= 0;
            k2 <= 0;
            if(toggle = 1) then
                ready <= 2;
                toggle <= 0;
            else ready <= 1;
            end if;
            
            if(count3 = 0) then
                count3 <= 12 ;
            end if;
            
                   -----------------product if mix
        end if;
        
        elsif (ready = 1 and keyDone = 1 and count3 <11) then
            if( i < 4)then
                if(j < 4)then
                    address <= "0101" & std_logic_vector(b(j)(i));
                        if (count1 = 3)then
                            count1 <= 0;
                            sbox_mat(j)(i) <= unsigned(data_out);
                            j <= j + 1;
                        else 
                            count1 <= count1 + 1;
                        end if;      
                end if; --------------j
           if(j = 4)then
                 i <= i + 1;
                 j <= 0;
           end if;   
         end if;        ------------------------------------------i
         
         if(i = 4 )then
            toggle <= 1;
            j <= 0;
            k <= 0;
            count1 <= 0;          
            ready <= 0;
            i <= 0;
                        
         end if;
         
         end if;    --------------------ready = 1

         if(ready = 2 and keyDone = 1 and count3 < 11)then
             if(count = 4) then
                 count <= 0;
                 if (i1<4) then
                     if (j<4) then
                         if (k<4) then
                             if(a(i1)(k) = x"11") then
                                 address <= "0001"&std_logic_vector(output(k)(j));
                             elsif(a(i1)(k) = x"13") then
                                 address <= "0010"&std_logic_vector(output(k)(j));
                             elsif(a(i1)(k) = x"09") then
                                 address <= "0011"&std_logic_vector(output(k)(j));        
                             elsif(a(i1)(k) = x"14") then
                                 address <= "0100"& std_logic_vector(output(k)(j));    
                             end if;
                     
                            if(counter = 3) then
                                 counter <= 0;
                                 sum  <= sum xor unsigned(data_out);
                                 k <= k + 1;
                            else counter <= counter + 1;
                            end if;
                                    
                        end if; ------------------k
                         if(k = 4) then
                             prod(i1)(j) <= sum;
                             sum <= "00000000";
                             j <= j + 1;
                             k <= 0;
                         end if;
                     end if;    ---------------------------j
                     if(j = 4) then 
                         i1 <= i1 + 1;
                         k <= 0;
                         j <= 0;
                      end if;
                    end if; --------------------------i
                    
                 else  count <= count + 1;
         end if; ---------------count
         
         if(i1 = 4 ) then 
            i1 <= 0;
            j <= 0;
            k <= 0; 
            b <= col_shift(prod);
            ready <= 1;
            count <= 0;
            counter <= 0;
            count3 <= count3 - 1;
         end if; 
         
         end if; -----------ready       

         
         if(count3 > 10) then
            for i3 in 0 to 3 loop
                 for j3 in 0 to 3 loop
                     final(count4 downto (count4-7)) := output(j3)(i3);
                     count4 := count4 - 8;
                 end loop;
             end loop;
           cipher(number) <= final;
           number <= number + 1;
           state_data <= X"901a02049e87964d1b92c643ffe80460";
           data_loaded <= 0;
           count4 := 127;
           count3 <= 10;
           ready <= 0;
           firstKey <= 0;
         end if;
         
 end if; ------------------------------rising edge
 end process;
 
 ------------------------------------------------------------------------------------------------
 keyGeneration :process(clk)
     begin
    if( keyDone = 0) then    ---ready 2
      if(firsttime = 1) then
         finalkey(0)<=key0;
         finalkey(1)<=key1;
         finalkey(2)<=key2;
         finalkey(3)<=key3;
         firsttime<=0;
      end if;   
      if(k1=4) then
         for i1 in 0 to 3 loop
           finalkey(4*count2)(i1)<=key3(i1) XOR key0(i1);
           finalkey(4*count2+1)(i1)<=finalkey(4*count2-3)(i1) XOR key3(i1) XOR key0(i1);
           finalkey(4*count2+2)(i1)<=finalkey(4*count2-2)(i1) XOR finalkey(4*count2-3)(i1) XOR key3(i1) XOR key0(i1);
           finalkey(4*count2+3)(i1)<=finalkey(4*count2-1)(i1) XOR finalkey(4*count2-2)(i1) XOR finalkey(4*count2-3)(i1) XOR key3(i1) XOR key0(i1);
         end loop;
         k1<=5;
         a1<=0;
             
         count2<=count2+1;
         conv<=conv*2;
              
      end if;
      
      
      if (rising_edge(clk)) then  
        
        if(a1=0) then  
               if(k1=5) then
                 key0<=finalKey(4*count2-4);
                 key1<=finalKey(4*count2-3);
                 key2<=finalKey(4*count2-2);
                 key3<=finalKey(4*count2-1);
                 k1<=0;
               end if;    
                   
               
               temp<=key3(0);
                 if(q=10) then
                     
                   q<=0;  
                   for w in 0 to 2  loop
                     key3(w)<=key3(w+1);
                   end loop; 
                   a1 <= 1;
                   key3(3)<=temp;
                else
                 q<=q+1;  
                end if;  
        end if;
                
        if (a1 = 1) then 
            address1 <="0000" & key3(k1);
             if(conv>128) then
             conv<=27;
             end if;
            if (j1 = 3) then
                   j1 <= 0;
                   if(k1=0) then
                       key3(k1) <= data_out1 XOR std_logic_vector(to_unsigned(conv,8));     
                   else
                       key3(k1)<=data_out1;
                   end if;        
                   k1 <= k1 + 1;               
            else 
                   j1 <= j1 + 1;
            end if;          
        end if;            
       end if;
       
       if(count2 > 10 ) then
        keyDone <= 1;
       end if;
         
  end if;
  
  end process; 
 
 end Behavioral;  
               
                 
