library IEEE;
use IEEE.std_logic_1164.all;

library IEEE_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;


entity floating_point_reciprocal is 
    generic (
        bits_wide : integer := 32
    );
    port(
         CLK : std_logic;
         A : in std_logic_vector((bits_wide-1) downto 0);
         Result : out std_logic_vector((bits_wide-1) downto 0));
end entity;

architecture floating_point_reciprocal_rtl of floating_point_reciprocal is

    begin
    
    FPADD: process(A)
        variable  f_A, f_R : float32;
        
        begin
            f_A := to_float(A);
            
            f_R := reciprocal (arg => f_A);

  
            Result <= to_std_logic_vector(f_R);  
    end process;
    
end architecture;
