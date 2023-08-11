library IEEE;
use IEEE.std_logic_1164.all;

library IEEE_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;


entity floating_point_mac is 
    generic (
        bits_wide : integer := 32
    );
    port(
         CLK : std_logic;
         A, B, C: in std_logic_vector((bits_wide-1) downto 0);
         Result : out std_logic_vector((bits_wide-1) downto 0));
end entity;

architecture floating_point_mac_rtl of floating_point_mac is

    begin
    
    FPADD: process(A, B)
        variable  f_A, f_B, f_C, f_R : float32;
        
        begin
            f_A := to_float(A);
            f_B := to_float(B);
            f_C := to_float(C);
            

            f_R := mac (l => f_A, r => f_B, c => f_C);

  
            Result <= to_std_logic_vector(f_R);  
    end process;
    
end architecture;
