library IEEE;
use IEEE.std_logic_1164.all;

library IEEE_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;


entity FP_remainder is 
    generic (
        bits_wide : integer := 32
    );
    port(
         CLK : std_logic;
         A, B : in std_logic_vector((bits_wide-1) downto 0);
         Result : out std_logic_vector((bits_wide-1) downto 0));
end entity;

architecture FP_remainder_rtl of FP_remainder is

    begin
    
    FPADD: process(A, B)
        variable  f_A, f_B, f_R : float32;
        
        begin
            f_A := to_float(A);
            f_B := to_float(B);
            
            f_R := remainder (l => f_A, r => f_B);

  
            Result <= to_std_logic_vector(f_R);  
    end process;
    
end architecture;