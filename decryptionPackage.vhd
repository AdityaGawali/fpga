library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;

package pkg is
    type matrix_c is array( 0 to 3) of unsigned(7 downto 0);
    type matrix is array(0 to 3) of matrix_c;
    
    type key is array(0 to 3) of std_logic_vector(7 downto 0);
    type fkey is array(0 to 43) of key;
    
   type data128 is array(integer range <>) of unsigned(127 downto 0);
   

  function load_mat( data_raw : unsigned(127 downto 0)) return matrix;
  function col_shift( input_raw_mat : matrix) return matrix;
 -- function final(in1 : matrix; in2 : fkey; increment : integer) return matrix;
 

  COMPONENT blk_mem_gen_1
    PORT (
      clka : IN STD_LOGIC;
      addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;
end pkg;

package body pkg is
function load_mat(data_raw : unsigned(127 downto 0)) return matrix is
    variable count : integer := 127;
    variable state : matrix := (others =>(others =>X"00"));
    variable data_in : unsigned(127 downto 0) := X"00000000000000000000000000000000";
    
    begin
                data_in := data_raw; 
               for i in 0 to 3 loop -- i is coloum
                   for j in 0 to 3 loop -- j is row
                   state(j)(i) := data_in(count downto (count-7));
                   count := (count-8);
                end loop;
              end loop;
            return state;
          end load_mat;  
          
          
 function col_shift(input_raw_mat : matrix) return matrix is
                variable input_mat : matrix := (others=>(others =>X"00"));
                variable output_mat : matrix := (others =>(others =>X"00"));
                
                
                variable temp_row1 : unsigned(7 downto 0);
                
                variable temp_row21 : unsigned(7 downto 0);
                variable temp_row22 : unsigned(7 downto 0);
                
                variable temp_row31 : unsigned(7 downto 0);
                variable temp_row32 : unsigned(7 downto 0);
                variable temp_row33 : unsigned(7 downto 0);
                begin 
                  input_mat := input_raw_mat;
                  
                  temp_row1 := input_mat(1)(3);
                  
                  temp_row21 := input_mat(2)(3);
                  temp_row22 := input_mat(2)(2);
                  
                  temp_row31 := input_mat(3)(3);
                  temp_row32 := input_mat(3)(2);
                  temp_row33 := input_mat(3)(1);
                  
                  for i in 3 downto 1 loop -- ROW 1
                      input_mat(1)(i) := input_mat(1)(i - 1);
                   end loop;
                   
                   for i in 2 to 3 loop --ROW 2
                      input_mat(2)(i) := input_mat(2)(i - 2);
                    end loop;
                    
                   -- ROW 3
                   input_mat(3)(3) := input_mat(3)(0); 
                   --ROW 3
                   
                   input_mat(1)(0)  :=   temp_row1;
                   input_mat(2)(1)   := temp_row21;
                   input_mat(2)(0)   := temp_row22;
                   input_mat(3)(2)   := temp_row31;
                   input_mat(3)(1)   := temp_row32;
                   input_mat(3)(0)   := temp_row33;
                   
                   output_mat := input_mat;
                  return output_mat;
                  end col_shift;
          

      
end pkg; 
