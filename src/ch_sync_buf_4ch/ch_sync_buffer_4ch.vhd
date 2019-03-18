library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

library work;
use work.DataStruct_param_def_header.all;--invoke our defined type and parameter


entity ch_sync_buffer is   
    generic (
        constant grouped_ch                 : integer := 4;
        constant sync_pattern               : std_logic_vector((para_data_length_per_ch -1) downto 0) := x"1234"                
    );
    port (
        ch_sync_buffer_data_In          : in  para_data_mem ; 

        ch_sync_buffer_data_Out         : out para_data_mem ; 

        ch_sync_buffer_sync_done            : out std_logic ;
        ch_sync_buffer_overflow             : out std_logic ;

        sync_en                             : in  std_logic ;

        ch_sync_buffer_directly_pass        : in  std_logic ;
        
        CLK                                 : in  std_logic ;       
        RST_N                               : in  std_logic 
    );
end ch_sync_buffer;

architecture top of ch_sync_buffer is 
    
begin
    shift_reg_gen_loop : for i in 0 to (ch_sync_buffer_Length -2) generate        
        ch_loop : for j in 0 to (grouped_ch -1) generate
            shift_reg : entity work.D_FF_sync_buf
                port map(
                    Q           => sync_buf_ch(j)(i+1),    
                    Clk         => CLK,
                    RST_N       => RST_N and sync_en ,  
                    D           => sync_buf_ch(j)(i) 
                ); 
        end generate ch_loop;     
    end generate shift_reg_gen_loop;

    sync_process: process(RST_N,CLK,sync_en)
        type int_4ch_t is array (grouped_ch -1 downto 0) of integer;
        variable cnt_ch : int_4ch_t range 0 to  (2**ch_sync_buffer_Length_power -1) :=  (others => (others => '0'));    
        type syncing_status_type is (sync_start, sync_done);
        variable sync_status : syncing_status_type := sync_start;
    begin
        if (RST_N = '0' and sync_en = '0') then
            cnt_ch      := (others => 0);
            sync_status := sync_start;

        elsif (rising_edge(CLK)) then
            case sync_status is
                when sync_start =>
                    for i in range 0 to (grouped_ch-1) loop
                        if (cnt_ch(i) /= 0) then
                            sync_status := sync_done;
                        elsif (ch_sync_buffer_data_In(i) = sync_pattern) then
                            cnt_ch(i) = cnt_ch(i)+1;
                            sync_status := sync_start;
                        end if;
                    end loop;

                when sync_done =>
            
                when others =>        
            
            end case;
        end if;
    end process sync_process;

    Out_mux_ch_gen_loop : for j in 0 to (grouped_ch -1) generate
        Mux : entity work.ch_sync_buf_out_mux
            port map(
                Data_Out    => output_buf(j),  
                sel         => conv_std_logic_vector(out_mux_sel_ch(j),ch_sync_buffer_Length_power),
                Data_In     => sync_buf_ch(j)
            );
    end generate Out_mux_ch_gen_loop; 

    ch_sync_buffer_data_Out <= ch_sync_buffer_data_In when ch_sync_buffer_directly_pass = '1' else 

end architecture top;