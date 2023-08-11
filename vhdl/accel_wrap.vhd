library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity accel_wrap is
    generic (
        BITS_WIDE : integer := 32
    );
    port(
        i_fp_clock         : in std_logic;
        i_fp_reset         : in std_logic;
        i_fp_start         : in std_logic;
        i_fp_cycles        : in std_logic_vector(4 downto 0);
        i_fp_A             : in std_logic_vector(BITS_WIDE-1 downto 0);
        i_fp_B             : in std_logic_vector(BITS_WIDE-1 downto 0);
        i_fp_C             : in std_logic_vector(BITS_WIDE-1 downto 0);
        i_fp_done_clear    : in std_logic;
        o_fp_R             : out std_logic_vector(31 downto 0);
        o_fp_busy          : out std_logic;
        o_fp_done          : out std_logic
    );
end entity;

architecture accel_wrap_rtl of accel_wrap is
    
        -- signal and constant declarations
        type state_type is (IDLE, BUSY, VALID_WAIT);
        signal current_state, next_state : state_type;
        
        signal clk_cnt: integer := 0;
        constant n : integer := BITS_WIDE;
        
        signal w_A, w_B, w_C : std_logic_vector(n-1 downto 0);
        signal w_R : std_logic_vector(31 downto 0);
        signal r_fp_cycles : std_logic_vector(4 downto 0);
        
        -- Debug
        attribute MARK_DEBUG : string;
        ATTRIBUTE MARK_DEBUG OF w_A : SIGNAL IS "true";
        ATTRIBUTE MARK_DEBUG OF w_B : SIGNAL IS "true";
        ATTRIBUTE MARK_DEBUG OF w_C : SIGNAL IS "true";
        ATTRIBUTE MARK_DEBUG OF w_R : SIGNAL IS "true";
             
        -- component declaration
--        component floating_point_add
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;
    
--        component floating_point_sub
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;

--        component floating_point_divide
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;

--        component floating_point_multiply
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;
        
--        component floating_point_remainder
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;

--        component floating_point_dividebyp2
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--        end component;

--          component floating_point_modulo
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A, B: in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--          end component;

          component floating_point_mac
            generic (
                bits_wide : integer := 32
            );
            port(
                 A, B, C: in std_logic_vector((bits_wide-1) downto 0);
                 Result : out std_logic_vector((bits_wide-1) downto 0));
          end component;
          
--          component floating_point_reciprocal
--            generic (
--                bits_wide : integer := 32
--            );
--            port(
--                 A : in std_logic_vector((bits_wide-1) downto 0);
--                 Result : out std_logic_vector((bits_wide-1) downto 0));
--          end component;
          

    begin
    
        r_fp_cycles <= i_fp_cycles;
        w_A <= i_fp_A when i_fp_start = '1' and current_state = IDLE;
        w_B <= i_fp_B when i_fp_start = '1' and current_state = IDLE;
        w_C <= i_fp_C when i_fp_start = '1' and current_state = IDLE;    
        o_fp_R <= w_R when i_fp_start = '1' and current_state = VALID_WAIT;   

        ------------------------------------------------------------------------------------------------------------------------------------
        -- COMPONENT INSTANTIATION
        ------------------------------------------------------------------------------------------------------------------------------------ 
--        p_FP_ADD : floating_point_add 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        );    
        
--        p_FP_SUB : floating_point_sub 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        );  
       
   
--        p_FP_MUL : floating_point_multiply
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        );  
        
--        p_FP_DIV : floating_point_divide 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        ); 

--        p_FP_REM : floating_point_remainder 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        ); 

--        p_FP_MOD : floating_point_modulo 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        ); 

--        p_FP_DIVP2 : floating_point_dividebyp2 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                B => w_B,
--                Result => w_R
--        );

        p_FP_MAC : floating_point_mac 
            generic map (
                bits_wide => n
            )
            port map(
                A => w_A, 
                B => w_B,
                C => w_C,
                Result => w_R
        );

--        p_FP_RECIP : floating_point_reciprocal 
--            generic map (
--                bits_wide => n
--            )
--            port map(
--                A => w_A, 
--                Result => w_R
--        );
        
               
    
        ------------------------------------------------------------------------------------------------------------------------------------
        -- STATE MEMORY
        ------------------------------------------------------------------------------------------------------------------------------------
        p_SM : process(i_fp_clock, i_fp_reset, current_state)
            begin
                if(i_fp_reset = '0') then
                    -- default
                    current_state <= IDLE;
                    clk_cnt <= 0;
                elsif(rising_edge(i_fp_clock)) then
                    current_state <= next_state;
                    
                    if(current_state = BUSY) then
                        clk_cnt <= clk_cnt + 1;
                    end if;
                    
                    if(current_state = VALID_WAIT) then
                        clk_cnt <= 0;
                    end if;
                end if;
        end process;
        
        
        ------------------------------------------------------------------------------------------------------------------------------------
        -- NEXT STATE LOGIC
        ------------------------------------------------------------------------------------------------------------------------------------
        p_NSM : process(current_state, i_fp_start, i_fp_done_clear, clk_cnt)
            begin
                case current_state is
                    when IDLE => 
                        if(i_fp_start = '1') then
                            next_state <= BUSY;
                        else 
                            next_state <= IDLE;
                        end if;
                    when BUSY =>
                        if(clk_cnt >= to_integer(unsigned(r_fp_cycles))) then
                            next_state <= VALID_WAIT;
                        else 
                            next_state <= BUSY;
                        end if;     
                    when VALID_WAIT => 
                        if(i_fp_done_clear = '1') then
                            next_state <= IDLE;
                        else 
                            next_state <= VALID_WAIT;
                        end if;
                    when others => next_state <= IDLE;
                end case;
        end process;
        
        
        
        ------------------------------------------------------------------------------------------------------------------------------------
        -- OUTPUT LOGIC
        ------------------------------------------------------------------------------------------------------------------------------------
        p_OL : process(clk_cnt, current_state, next_state)
            begin
                case current_state is
                    when IDLE => 
                        o_fp_busy <= '0';
                        o_fp_done <= '0';
--                        w_R(8 downto -23) <= (others => 'U');
                        
                    when BUSY | VALID_WAIT =>
                        
                        if(current_state = BUSY) then
                            o_fp_busy <= '1';
                            o_fp_done <= '0';
                        elsif(current_state = VALID_WAIT) then
                            o_fp_busy <= '0';
                            o_fp_done <= '1';
--                        else 
--                            o_fp_busy <= 'U';
--                           o_fp_done <= 'U';
                        end if;                                                      
                        
                    when others => 
                        o_fp_busy <= '0';
                        o_fp_done <= '0';
--                        w_R(8 downto -23) <= (others => 'U');
                end case;
        end process;
    
    
end architecture;
