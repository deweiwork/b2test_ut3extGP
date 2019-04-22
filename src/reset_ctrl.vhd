library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.DataStruct_param_def_header.all;--invoke our defined type and parameter

entity reset_ctrl is
generic (
    constant power_on_wait_clks         : integer := 2**16 -1;
    constant wait_locked_clks           : integer := 2**16 -1;
    constant wait_alignment_done_clks   : integer := 2**8 -1;
    constant pre_lane_up_clks           : integer := 2**8 -1
);
Port (
    Reset_n                  : in  std_logic;
    INIT_CLK                 : in  std_logic;

    
    XCVR_rst_out             : out std_logic;
    align_en                 : out std_logic; 
    lane_up                  : out std_logic;
    
    rx_freq_locked           : in  ser_data_men;

    Tx_xcvrRstIp_is_Ready    : in  ser_data_men;
    Rx_xcvrRstIp_is_Ready    : in  ser_data_men;

    RX_elastic_buf_overflow  : in  std_logic;
    rx_sync_status           : in  ctrl_code_8B10B;
    rx_pattern_detected      : in  ctrl_code_8B10B;
    RX_errdetect             : in  ctrl_code_8B10B;
    RX_disperr               : in  ctrl_code_8B10B
);
end entity reset_ctrl;


architecture Behavioral of reset_ctrl is

    type lane_up_condition_type is --for stratix-4
        (power_on ,wait_locked,comma_align,pre_lane_up,now_xcvr_init_done);
    signal lane_up_status            : lane_up_condition_type := power_on;

    signal RX_freq_locked_r          : std_logic := '0';
    signal XCVR_pll_locked_r         : std_logic := '0';
    signal all_locked                : std_logic := '0';

    signal RX_errdetect_r            : ser_data_men;
    signal RX_disperr_r              : ser_data_men;
    signal RX_errdetect_r2           : std_logic;
    signal RX_disperr_r2             : std_logic;
    signal error_happen              : std_logic;
    signal Tx_xcvrRstIp_is_Ready_r   : std_logic;
    signal Rx_xcvrRstIp_is_Ready_r   : std_logic;
    signal rst_ip_done               : std_logic;

    signal lane_up_r                 : std_logic := '0';
    signal XCVR_rst_out_r            : std_logic := '0';
    signal align_en_r                : std_logic;

begin

    err_signal_loop:for i in 0 to (num_of_xcvr_ch - 1) generate
        RX_errdetect_r(i)  <= or_reduce(RX_errdetect(i));
        RX_disperr_r(i)    <= or_reduce(RX_disperr(i));                    
    end generate err_signal_loop;
    RX_errdetect_r2 <= or_reduce(RX_errdetect_r);
    RX_disperr_r2   <= or_reduce(RX_disperr_r);
    error_happen    <= RX_errdetect_r2 or RX_disperr_r2 or RX_elastic_buf_overflow;
    
    Rx_xcvrRstIp_is_Ready_r <= and_reduce(Rx_xcvrRstIp_is_Ready);
    Tx_xcvrRstIp_is_Ready_r <= and_reduce(Tx_xcvrRstIp_is_Ready);
    
    lane_up_FSM : process(INIT_CLK,Reset_n)
        variable power_on_cnt               : integer range 0 to power_on_wait_clks         := 0 ;
        variable locked_cnt                 : integer range 0 to wait_locked_clks           := 0 ;
        variable comma_align_cnt            : integer range 0 to wait_alignment_done_clks   := 0 ;
        variable pre_lane_up_cnt            : integer range 0 to pre_lane_up_clks           := 0 ;
    begin
        if (Reset_n = '0') then
            lane_up_status <= power_on ;

            lane_up                  <= '0';
            XCVR_rst_out             <= '1';
            align_en                 <= '0';

            lane_up_r                <= '0';
            XCVR_rst_out_r           <= '1';
            align_en_r               <= '0';

            power_on_cnt    := 0;
            locked_cnt      := 0;
            comma_align_cnt := 0;
        else
            if (rising_edge(INIT_CLK)) then
                lane_up                     <= lane_up_r ;
                XCVR_rst_out                <= XCVR_rst_out_r;
                align_en                    <= align_en_r;
                
                RX_freq_locked_r    <= and_reduce(RX_freq_locked);
                rst_ip_done <= Tx_xcvrRstIp_is_Ready_r and Rx_xcvrRstIp_is_Ready_r;
                all_locked <= RX_freq_locked_r and rst_ip_done;

                case( lane_up_status ) is
                    when power_on =>
                        if (power_on_cnt = power_on_wait_clks) then
                            power_on_cnt     := 0;
                            XCVR_rst_out_r   <= '0';
                            align_en_r <= '1';
                            lane_up_status   <= wait_locked;
                        else
                            power_on_cnt     := power_on_cnt + 1;

                            XCVR_rst_out_r   <= '1';
                            lane_up_r        <= '0';
                            align_en_r       <= '0';
                            lane_up_status   <= power_on;
                        end if;

                    when wait_locked =>
                        if (all_locked = '1') then
                            if (locked_cnt = wait_locked_clks) then
                                locked_cnt      := 0;
                                lane_up_status  <= comma_align;
                            else
                                locked_cnt      := locked_cnt + 1;
                                lane_up_status  <= wait_locked;
                            end if;
                        else
                            lane_up_status      <= wait_locked;
                            locked_cnt          := 0;
                        end if;
                        
                    when comma_align =>

                        if (comma_align_cnt = wait_alignment_done_clks) then
                            comma_align_cnt := 0;
                            lane_up_status <= pre_lane_up;
                        else
                            comma_align_cnt := comma_align_cnt + 1;
                            lane_up_status  <= comma_align;
                        end if;
                    when pre_lane_up =>
                        lane_up_r <= '1';

                        if (pre_lane_up_cnt = pre_lane_up_clks) then
                            pre_lane_up_cnt := 0;
                            lane_up_status <= now_xcvr_init_done;
                        else
                            pre_lane_up_cnt := pre_lane_up_cnt + 1;
                            lane_up_status  <= pre_lane_up;
                        end if;

                    when now_xcvr_init_done =>
                        -- now lan-up? checker
                        if (error_happen = '0' and all_locked = '1') then
                            lane_up_r <= '1';
                            XCVR_rst_out_r <= '0';
                            lane_up_status          <= now_xcvr_init_done ;
                        else
                            lane_up_r <= '0';
                            XCVR_rst_out_r <= '1';
                            lane_up_status          <= power_on ;
                        end if;
                    when others =>

                end case ;
            end if;
        end if;
    end process lane_up_FSM;
end architecture Behavioral;
