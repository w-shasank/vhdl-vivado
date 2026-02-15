
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



entity pid is
 Port ( 
 
        clk : in std_logic ;
        rst :in std_logic;
        
        adc_data : in std_logic_vector(15 downto 0);-- 16 bit unsigned pid input
        adc_valid: in std_logic;
        
        setpoint : in std_logic_vector(15 downto 0);
        
        dac_data : out std_logic_vector(6 downto 0);
        dac_valid : out std_logic ;
        
        kp : in std_logic_vector(7 downto 0);
        ki : in std_logic_vector(7 downto 0);
        kd : in std_logic_vector(7 downto 0)
         
         );
       
end pid;

architecture Behavioral of pid is
        
        signal error : signed(16 downto 0);
        signal error_prev : signed(16 downto 0):=(others => '0');
        signal integral : signed(31 downto 0):=(others => '0');
        
        signal p_terms : signed(31 downto 0);
        signal i_terms : signed (31 downto 0 );
        signal d_terms : signed(31 downto 0);
        
        signal pid_sum : signed(31 downto 0);
        signal output : signed(31 downto 0); 
    
begin
     process(clk,rst)
        begin
            if(rst = '1') then
                error_prev <= (others => '0');
                integral <= (others => '0' );
                dac_valid <= '0' ;
                
            elsif (rising_edge (clk)) then
                if (adc_valid = '1') then
                    error <= signed('0' & setpoint )  - signed('0' & adc_data);
                    
                    p_terms <= RESIZE(error * signed('0' & kp ), 32);
                    
                    integral <= integral + RESIZE(error , 32);
                    
                    
                    if (integral > 1000000) then 
                        integral <= to_signed(1000000 ,32);
                    elsif(integral < -1000000) then
                        integral <= to_signed(-1000000 , 32);
                    end if; 
                    
                    i_terms <= resize(integral * signed('0' & ki) ,32 ) ;
                    
                    d_terms <= resize((error - error_prev) * signed('0' &kd ) , 32 );
                    error_prev <= error ;
                    
                    
                    pid_sum <= p_terms + (i_terms / 256 ) + d_terms ;
                    
                    output <= pid_sum / 256 ;
                    
                    
                    if output < 0 then 
                        dac_data <= "000000";
                    elsif output > 63 then  
                        dac_data<="111111" ;
                     else 
                            dac_data <= std_logic_vector(output(5 downto 0));
                     end if;  
                     
                     
                     dac_valid<='1';
                     
                   else 
                        dac_valid <= '0';
                    end if; 
                end if ;  
             end process;
            
            
end Behavioral;
