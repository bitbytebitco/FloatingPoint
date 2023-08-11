library IEEE;
use IEEE.std_logic_1164.all;

library IEEE_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;

entity Top is
    Port ( CLK : in STD_LOGIC;
--           i_A : in std_logic_vector(31 downto 0);
--           i_B : in std_logic_vector(31 downto 0);
--           o_R : out std_logic_vector(31 downto 0);
           RST : in std_logic
    );
end entity;

architecture Top_rtl of Top is

    constant n : integer := 32; -- # of Bits in Multiplier
    signal w_A, w_B, w_P32: std_logic_vector( (n-1) downto 0);
    signal w_SEL : std_logic_vector(1 downto 0);
    signal w_RST : std_logic;
    
--    -- Debug
    attribute MARK_DEBUG : string;
    ATTRIBUTE MARK_DEBUG OF CLK : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF w_A : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF w_B : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF w_SEL : SIGNAL IS "true";
    ATTRIBUTE MARK_DEBUG OF w_P32 : SIGNAL IS "true";
      
    component floating_point_multiply 
        generic (
            bits_wide : integer := 32
        );
        port(
             CLK : std_logic;
             A, B : in std_logic_vector((bits_wide-1) downto 0);
             Result : out std_logic_vector((bits_wide-1) downto 0));
    end component;
    
    --Declare vio_reset
    COMPONENT vio_inputs
        PORT(
            CLK        : IN STD_LOGIC;
            PROBE_OUT0 : OUT STD_LOGIC;
            PROBE_OUT1 : OUT std_logic_vector(31 downto 0); 
            PROBE_OUT2 : OUT std_logic_vector(31 downto 0);
            PROBE_OUT3 : OUT std_logic_vector(1 downto 0)
        );
    END COMPONENT;
        
    
begin
  
    
    VIO: vio_inputs
        port map(
            CLK => CLK,
            PROBE_OUT0 => w_RST,
            PROBE_OUT1 => w_A,
            PROBE_OUT2 => w_B, 
            PROBE_OUT3 => w_SEL
        );
   
--    w_A <= i_A;
--    w_B <= i_B;
--    o_R <= w_P32;
    
--    FP : floating_point_add 
--        generic map (
--            bits_wide => n
--        )
--        port map(
--            CLK => CLK,
--            A => w_A, 
--            B => w_B,
--            Result => w_P32
--        );

--      FP : floating_point_sub 
--        generic map (
--            bits_wide => n
--        )
--        port map(
--            CLK => CLK,
--            A => w_A, 
--            B => w_B,
--            Result => w_P32
--        );

      FP : floating_point_multiply 
        generic map (
            bits_wide => n
        )
        port map(
            CLK => CLK,
            A => w_A, 
            B => w_B,
            Result => w_P32
        );

--      FP : floating_point_divide 
--        generic map (
--            bits_wide => n
--        )
--        port map(
--            CLK => CLK,
--            A => w_A, 
--            B => w_B,
--            Result => w_P32
--        );

            
end architecture;
