--if you want to modify channel
--just modify component of transceiver(xcvr)

--!! warning !!
--user need to see "DataStruct_param_def_header.vhd"
--most important of typedef and parameter in here
--!! warning !!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

library work;
use work.DataStruct_param_def_header.all;--invoke our defined type and parameter

library UNISIM;
use UNISIM.vcomponents.all; --bufg oddr OBUFDES

entity XCVR_8B10B_interconnect is
    port (
        RST_N                       : in  std_logic := '1' ;

        TX_para_external_ch         : in  para_data_men;
        RX_para_external_ch         : out para_data_men;
        TX_para_external_clk_ch     : out ser_data_men;
        RX_para_external_clk_ch     : out ser_data_men;
        tx_traffic_ready_ext_ch     : out std_logic;
        rx_traffic_ready_ext_ch     : out std_logic;
        error_cnt_ch                : out para_data_men;

        XCVR_Ref_Clock              : in  std_logic ;
        init_clock                  : in  std_logic ;

        RX_ser                      : in  ser_data_men;
        TX_ser                      : out ser_data_men;
        RX_ser_N                    : in  ser_data_men;
        TX_ser_N                    : out ser_data_men
    );
end entity XCVR_8B10B_interconnect ;


architecture XCVR_8B10B_interconnect_Top of XCVR_8B10B_interconnect is
    --clock
    signal XCVR_Tx_clk_out_ch           : ser_data_men := (others =>'0');
    signal XCVR_Rx_clk_out_ch           : ser_data_men := (others =>'0');
    --==================--
    ----data gen/check----
    --==================--
    --loopback_en
    signal internal_loopback_en_ch      : std_logic_vector(2 downto 0) ;

    --para data
    signal tx_Para_data_ch              : para_data_men;
    signal rx_Para_data_ch              : para_data_men;

    signal tx_Para_data_internal_ch     : para_data_men;
    signal rx_Para_data_internal_ch     : para_data_men;

    signal xcvr_tx_Para_data_ch         : para_data_men;
    signal xcvr_rx_Para_data_ch         : para_data_men;

    --ready
    signal lane_up                      : std_logic := '0';

    signal TX_traffic_ready_ch          : ser_data_men := (others =>'0');
    signal RX_traffic_ready_ch          : ser_data_men := (others =>'0');
    signal TX_traffic_ready_buf_ch      : std_logic;
    signal RX_traffic_ready_buf_ch      : std_logic;

    signal tx_traffic_ready_internal_ch : std_logic;
    signal rx_traffic_ready_internal_ch : std_logic;

    signal XCVR_TX_ready_ch             : ser_data_men := (others =>'0'); --arria10
    signal XCVR_RX_ready_ch             : ser_data_men := (others =>'0'); --arria10

    --===============--
    ----transceiver----
    --===============--
    --controlled data
    signal rx_disp_err_ch               : ctrl_code_8B10B := (others => (others =>'0'));
    signal rx_err_detec_ch              : ctrl_code_8B10B := (others => (others =>'0'));

    signal rx_data_k_ch                 : ctrl_code_8B10B;
    signal tx_data_k_ch                 : ctrl_code_8B10B;

    signal rx_patterndetect_ch          : ctrl_code_8B10B; --arria10
    signal rx_syncstatus_ch             : ctrl_code_8B10B; --arria10
    signal rx_runningdisp_ch            : ctrl_code_8B10B; --arria10

    signal rx_std_wa_patternalign       : std_logic;

    signal rx_freqlocked_ch             : ser_data_men;

    signal XCVR_TxRx_rst                : ser_data_men;

    --===============--
    --  for xilinx  --
    --===============--
    --bufg
    signal tx_clk_buf_out               : ser_data_men := (others =>'0');
    signal rx_clk_buf_out               : ser_data_men := (others =>'0');
    signal tx_clk_buf_out_to_ext        : ser_data_men := (others =>'0');
    signal rx_clk_buf_out_to_ext        : ser_data_men := (others =>'0');
    --chip scope
    signal chip_scope_ctrl_0            : std_logic_vector(35 downto 0);
    signal chip_scope_ctrl_1            : std_logic_vector(35 downto 0);

    --8b10b and align
    signal pattern_is_comma             : ctrl_code_8B10B;
    signal rx_not_in_8b10b_table        : ctrl_code_8B10B;
    signal rx_byte_aligned              : ser_data_men;
    signal rx_comma_detected            : ser_data_men;
    --PMA manual ctrl
    constant gtx_test_0                 : std_logic_vector (12 downto 0) := "1000000000000";
    constant gtx_test_1                 : std_logic_vector (12 downto 0) := "1000000000000";
    constant gtx_test_2                 : std_logic_vector (12 downto 0) := "1000000000000";
    constant gtx_test_3                 : std_logic_vector (12 downto 0) := "1000000000000";
    constant tx_pre_emphasis_0          : std_logic_vector (3  downto 0) := "0000";
    constant tx_pre_emphasis_1          : std_logic_vector (3  downto 0) := "0000";
    constant tx_pre_emphasis_2          : std_logic_vector (3  downto 0) := "0000";
    constant tx_pre_emphasis_3          : std_logic_vector (3  downto 0) := "0000";
    constant tx_post_emphasis_0         : std_logic_vector (4  downto 0) := "00000";
    constant tx_post_emphasis_1         : std_logic_vector (4  downto 0) := "00000";
    constant tx_post_emphasis_2         : std_logic_vector (4  downto 0) := "00000";
    constant tx_post_emphasis_3         : std_logic_vector (4  downto 0) := "00000";
    constant tx_diff_ctrl_0             : std_logic_vector (3  downto 0) := "1010";
    constant tx_diff_ctrl_1             : std_logic_vector (3  downto 0) := "1010";
    constant tx_diff_ctrl_2             : std_logic_vector (3  downto 0) := "1010";
    constant tx_diff_ctrl_3             : std_logic_vector (3  downto 0) := "1010";
    constant rx_eq_mix_0                : std_logic_vector (2  downto 0) := "000";
    constant rx_eq_mix_1                : std_logic_vector (2  downto 0) := "000";
    constant rx_eq_mix_2                : std_logic_vector (2  downto 0) := "000";
    constant rx_eq_mix_3                : std_logic_vector (2  downto 0) := "000";
    --grouping
    signal rx_Para_data_to_sync_buf_ch          : para_data_men;
    signal rx_Para_data_from_sync_buf_ch        : para_data_men;
    signal elastic_buf_overflow                 : std_logic;
    signal elastic_buf_sync_done                : std_logic;
component v6_gtxwizard_v1_12 
generic
(
    -- Simulation attributes
    WRAPPER_SIM_GTXRESET_SPEEDUP    : integer   := 0 -- Set to 1 to speed up sim reset
);
port
(
    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GTX0  (X0_Y0)

    ------------------------ Loopback and Powerdown Ports ----------------------
    GTX0_LOOPBACK_IN                        : in   std_logic_vector(2 downto 0);
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    GTX0_RXCHARISCOMMA_OUT                  : out  std_logic_vector(1 downto 0);
    GTX0_RXCHARISK_OUT                      : out  std_logic_vector(1 downto 0);
    GTX0_RXDISPERR_OUT                      : out  std_logic_vector(1 downto 0);
    GTX0_RXNOTINTABLE_OUT                   : out  std_logic_vector(1 downto 0);
    GTX0_RXRUNDISP_OUT                      : out  std_logic_vector(1 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    GTX0_RXBYTEISALIGNED_OUT                : out  std_logic;
    GTX0_RXCOMMADET_OUT                     : out  std_logic;
    GTX0_RXENMCOMMAALIGN_IN                 : in   std_logic;
    GTX0_RXENPCOMMAALIGN_IN                 : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    GTX0_RXDATA_OUT                         : out  std_logic_vector(15 downto 0);
    GTX0_RXRECCLK_OUT                       : out  std_logic;
    GTX0_RXRESET_IN                         : in   std_logic;
    GTX0_RXUSRCLK2_IN                       : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    GTX0_RXEQMIX_IN                         : in   std_logic_vector(2 downto 0);
    GTX0_RXN_IN                             : in   std_logic;
    GTX0_RXP_IN                             : in   std_logic;
    -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    GTX0_RXBUFRESET_IN                      : in   std_logic;
    GTX0_RXBUFSTATUS_OUT                    : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - RX Loss-of-sync State Machine --------------
    GTX0_RXLOSSOFSYNC_OUT                   : out  std_logic_vector(1 downto 0);
    ------------------------ Receive Ports - RX PLL Ports ----------------------
    GTX0_GTXRXRESET_IN                      : in   std_logic;
    GTX0_MGTREFCLKRX_IN                     : in   std_logic;
    GTX0_PLLRXRESET_IN                      : in   std_logic;
    GTX0_RXPLLLKDET_OUT                     : out  std_logic;
    GTX0_RXRESETDONE_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    GTX0_TXCHARISK_IN                       : in   std_logic_vector(1 downto 0);
    ------------------------- Transmit Ports - GTX Ports -----------------------
    GTX0_GTXTEST_IN                         : in   std_logic_vector(12 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    GTX0_TXDATA_IN                          : in   std_logic_vector(15 downto 0);
    GTX0_TXOUTCLK_OUT                       : out  std_logic;
    GTX0_TXRESET_IN                         : in   std_logic;
    GTX0_TXUSRCLK2_IN                       : in   std_logic;
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    GTX0_TXDIFFCTRL_IN                      : in   std_logic_vector(3 downto 0);
    GTX0_TXN_OUT                            : out  std_logic;
    GTX0_TXP_OUT                            : out  std_logic;
    GTX0_TXPOSTEMPHASIS_IN                  : in   std_logic_vector(4 downto 0);
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    GTX0_TXPREEMPHASIS_IN                   : in   std_logic_vector(3 downto 0);
    ----------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    GTX0_TXBUFSTATUS_OUT                    : out  std_logic_vector(1 downto 0);
    ----------------------- Transmit Ports - TX PLL Ports ----------------------
    GTX0_GTXTXRESET_IN                      : in   std_logic;
    GTX0_TXRESETDONE_OUT                    : out  std_logic;


    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GTX1  (X0_Y1)

    ------------------------ Loopback and Powerdown Ports ----------------------
    GTX1_LOOPBACK_IN                        : in   std_logic_vector(2 downto 0);
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    GTX1_RXCHARISCOMMA_OUT                  : out  std_logic_vector(1 downto 0);
    GTX1_RXCHARISK_OUT                      : out  std_logic_vector(1 downto 0);
    GTX1_RXDISPERR_OUT                      : out  std_logic_vector(1 downto 0);
    GTX1_RXNOTINTABLE_OUT                   : out  std_logic_vector(1 downto 0);
    GTX1_RXRUNDISP_OUT                      : out  std_logic_vector(1 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    GTX1_RXBYTEISALIGNED_OUT                : out  std_logic;
    GTX1_RXCOMMADET_OUT                     : out  std_logic;
    GTX1_RXENMCOMMAALIGN_IN                 : in   std_logic;
    GTX1_RXENPCOMMAALIGN_IN                 : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    GTX1_RXDATA_OUT                         : out  std_logic_vector(15 downto 0);
    GTX1_RXRECCLK_OUT                       : out  std_logic;
    GTX1_RXRESET_IN                         : in   std_logic;
    GTX1_RXUSRCLK2_IN                       : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    GTX1_RXEQMIX_IN                         : in   std_logic_vector(2 downto 0);
    GTX1_RXN_IN                             : in   std_logic;
    GTX1_RXP_IN                             : in   std_logic;
    -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    GTX1_RXBUFRESET_IN                      : in   std_logic;
    GTX1_RXBUFSTATUS_OUT                    : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - RX Loss-of-sync State Machine --------------
    GTX1_RXLOSSOFSYNC_OUT                   : out  std_logic_vector(1 downto 0);
    ------------------------ Receive Ports - RX PLL Ports ----------------------
    GTX1_GTXRXRESET_IN                      : in   std_logic;
    GTX1_MGTREFCLKRX_IN                     : in   std_logic;
    GTX1_PLLRXRESET_IN                      : in   std_logic;
    GTX1_RXPLLLKDET_OUT                     : out  std_logic;
    GTX1_RXRESETDONE_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    GTX1_TXCHARISK_IN                       : in   std_logic_vector(1 downto 0);
    ------------------------- Transmit Ports - GTX Ports -----------------------
    GTX1_GTXTEST_IN                         : in   std_logic_vector(12 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    GTX1_TXDATA_IN                          : in   std_logic_vector(15 downto 0);
    GTX1_TXOUTCLK_OUT                       : out  std_logic;
    GTX1_TXRESET_IN                         : in   std_logic;
    GTX1_TXUSRCLK2_IN                       : in   std_logic;
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    GTX1_TXDIFFCTRL_IN                      : in   std_logic_vector(3 downto 0);
    GTX1_TXN_OUT                            : out  std_logic;
    GTX1_TXP_OUT                            : out  std_logic;
    GTX1_TXPOSTEMPHASIS_IN                  : in   std_logic_vector(4 downto 0);
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    GTX1_TXPREEMPHASIS_IN                   : in   std_logic_vector(3 downto 0);
    ----------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    GTX1_TXBUFSTATUS_OUT                    : out  std_logic_vector(1 downto 0);
    ----------------------- Transmit Ports - TX PLL Ports ----------------------
    GTX1_GTXTXRESET_IN                      : in   std_logic;
    GTX1_TXRESETDONE_OUT                    : out  std_logic;


    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GTX2  (X0_Y2)

    ------------------------ Loopback and Powerdown Ports ----------------------
    GTX2_LOOPBACK_IN                        : in   std_logic_vector(2 downto 0);
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    GTX2_RXCHARISCOMMA_OUT                  : out  std_logic_vector(1 downto 0);
    GTX2_RXCHARISK_OUT                      : out  std_logic_vector(1 downto 0);
    GTX2_RXDISPERR_OUT                      : out  std_logic_vector(1 downto 0);
    GTX2_RXNOTINTABLE_OUT                   : out  std_logic_vector(1 downto 0);
    GTX2_RXRUNDISP_OUT                      : out  std_logic_vector(1 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    GTX2_RXBYTEISALIGNED_OUT                : out  std_logic;
    GTX2_RXCOMMADET_OUT                     : out  std_logic;
    GTX2_RXENMCOMMAALIGN_IN                 : in   std_logic;
    GTX2_RXENPCOMMAALIGN_IN                 : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    GTX2_RXDATA_OUT                         : out  std_logic_vector(15 downto 0);
    GTX2_RXRECCLK_OUT                       : out  std_logic;
    GTX2_RXRESET_IN                         : in   std_logic;
    GTX2_RXUSRCLK2_IN                       : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    GTX2_RXEQMIX_IN                         : in   std_logic_vector(2 downto 0);
    GTX2_RXN_IN                             : in   std_logic;
    GTX2_RXP_IN                             : in   std_logic;
    -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    GTX2_RXBUFRESET_IN                      : in   std_logic;
    GTX2_RXBUFSTATUS_OUT                    : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - RX Loss-of-sync State Machine --------------
    GTX2_RXLOSSOFSYNC_OUT                   : out  std_logic_vector(1 downto 0);
    ------------------------ Receive Ports - RX PLL Ports ----------------------
    GTX2_GTXRXRESET_IN                      : in   std_logic;
    GTX2_MGTREFCLKRX_IN                     : in   std_logic;
    GTX2_PLLRXRESET_IN                      : in   std_logic;
    GTX2_RXPLLLKDET_OUT                     : out  std_logic;
    GTX2_RXRESETDONE_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    GTX2_TXCHARISK_IN                       : in   std_logic_vector(1 downto 0);
    ------------------------- Transmit Ports - GTX Ports -----------------------
    GTX2_GTXTEST_IN                         : in   std_logic_vector(12 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    GTX2_TXDATA_IN                          : in   std_logic_vector(15 downto 0);
    GTX2_TXOUTCLK_OUT                       : out  std_logic;
    GTX2_TXRESET_IN                         : in   std_logic;
    GTX2_TXUSRCLK2_IN                       : in   std_logic;
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    GTX2_TXDIFFCTRL_IN                      : in   std_logic_vector(3 downto 0);
    GTX2_TXN_OUT                            : out  std_logic;
    GTX2_TXP_OUT                            : out  std_logic;
    GTX2_TXPOSTEMPHASIS_IN                  : in   std_logic_vector(4 downto 0);
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    GTX2_TXPREEMPHASIS_IN                   : in   std_logic_vector(3 downto 0);
    ----------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    GTX2_TXBUFSTATUS_OUT                    : out  std_logic_vector(1 downto 0);
    ----------------------- Transmit Ports - TX PLL Ports ----------------------
    GTX2_GTXTXRESET_IN                      : in   std_logic;
    GTX2_TXRESETDONE_OUT                    : out  std_logic;


    
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GTX3  (X0_Y3)

    ------------------------ Loopback and Powerdown Ports ----------------------
    GTX3_LOOPBACK_IN                        : in   std_logic_vector(2 downto 0);
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    GTX3_RXCHARISCOMMA_OUT                  : out  std_logic_vector(1 downto 0);
    GTX3_RXCHARISK_OUT                      : out  std_logic_vector(1 downto 0);
    GTX3_RXDISPERR_OUT                      : out  std_logic_vector(1 downto 0);
    GTX3_RXNOTINTABLE_OUT                   : out  std_logic_vector(1 downto 0);
    GTX3_RXRUNDISP_OUT                      : out  std_logic_vector(1 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    GTX3_RXBYTEISALIGNED_OUT                : out  std_logic;
    GTX3_RXCOMMADET_OUT                     : out  std_logic;
    GTX3_RXENMCOMMAALIGN_IN                 : in   std_logic;
    GTX3_RXENPCOMMAALIGN_IN                 : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    GTX3_RXDATA_OUT                         : out  std_logic_vector(15 downto 0);
    GTX3_RXRECCLK_OUT                       : out  std_logic;
    GTX3_RXRESET_IN                         : in   std_logic;
    GTX3_RXUSRCLK2_IN                       : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    GTX3_RXEQMIX_IN                         : in   std_logic_vector(2 downto 0);
    GTX3_RXN_IN                             : in   std_logic;
    GTX3_RXP_IN                             : in   std_logic;
    -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    GTX3_RXBUFRESET_IN                      : in   std_logic;
    GTX3_RXBUFSTATUS_OUT                    : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - RX Loss-of-sync State Machine --------------
    GTX3_RXLOSSOFSYNC_OUT                   : out  std_logic_vector(1 downto 0);
    ------------------------ Receive Ports - RX PLL Ports ----------------------
    GTX3_GTXRXRESET_IN                      : in   std_logic;
    GTX3_MGTREFCLKRX_IN                     : in   std_logic;
    GTX3_PLLRXRESET_IN                      : in   std_logic;
    GTX3_RXPLLLKDET_OUT                     : out  std_logic;
    GTX3_RXRESETDONE_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    GTX3_TXCHARISK_IN                       : in   std_logic_vector(1 downto 0);
    ------------------------- Transmit Ports - GTX Ports -----------------------
    GTX3_GTXTEST_IN                         : in   std_logic_vector(12 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    GTX3_TXDATA_IN                          : in   std_logic_vector(15 downto 0);
    GTX3_TXOUTCLK_OUT                       : out  std_logic;
    GTX3_TXRESET_IN                         : in   std_logic;
    GTX3_TXUSRCLK2_IN                       : in   std_logic;
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    GTX3_TXDIFFCTRL_IN                      : in   std_logic_vector(3 downto 0);
    GTX3_TXN_OUT                            : out  std_logic;
    GTX3_TXP_OUT                            : out  std_logic;
    GTX3_TXPOSTEMPHASIS_IN                  : in   std_logic_vector(4 downto 0);
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    GTX3_TXPREEMPHASIS_IN                   : in   std_logic_vector(3 downto 0);
    ----------- Transmit Ports - TX Elastic Buffer and Phase Alignment ---------
    GTX3_TXBUFSTATUS_OUT                    : out  std_logic_vector(1 downto 0);
    ----------------------- Transmit Ports - TX PLL Ports ----------------------
    GTX3_GTXTXRESET_IN                      : in   std_logic;
    GTX3_TXRESETDONE_OUT                    : out  std_logic


);
end component;


    component chipscope_icon
    PORT (
        CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
        CONTROL1 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0));

    end component;
    component chipscope_ila
    PORT (
      CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
      CLK : IN STD_LOGIC;
      TRIG0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      TRIG1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      TRIG2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      TRIG3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      TRIG4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      TRIG5 : IN STD_LOGIC_VECTOR(15 DOWNTO 0));
  
  end component;


begin

    --connect loopback_en
    internal_loopback_en_ch <= xcvr_ser_internal_loopback_en; --on the xilinx virtex-6 platform

    --connecte para data with internal/external selector
    tx_Para_data_ch <= TX_para_external_ch when scr_para_Data_gen_check_form_this_module = '0';
    tx_Para_data_ch <= tx_Para_data_internal_ch when scr_para_Data_gen_check_form_this_module = '1';

    rx_Para_data_ch <= rx_Para_data_from_sync_buf_ch;
    
    rx_Para_data_internal_ch <= rx_Para_data_ch when scr_para_Data_gen_check_form_this_module = '1';
    RX_para_external_ch      <= rx_Para_data_ch when scr_para_Data_gen_check_form_this_module = '0';

    TX_para_external_clk_ch <= tx_clk_buf_out when scr_para_Data_gen_check_form_this_module = '0';
    RX_para_external_clk_ch <= rx_clk_buf_out when scr_para_Data_gen_check_form_this_module = '0';
    
    RX_traffic_ready_buf_ch <= and_reduce(RX_traffic_ready_ch);
    TX_traffic_ready_buf_ch <= and_reduce(TX_traffic_ready_ch);
    --ready-ext
    rx_traffic_ready_ext_ch <= RX_traffic_ready_buf_ch when scr_para_Data_gen_check_form_this_module = '0';
    tx_traffic_ready_ext_ch <= TX_traffic_ready_buf_ch when scr_para_Data_gen_check_form_this_module = '0';
    --ready-internal
    rx_traffic_ready_internal_ch <= RX_traffic_ready_buf_ch when scr_para_Data_gen_check_form_this_module = '1';
    tx_traffic_ready_internal_ch <= TX_traffic_ready_buf_ch when scr_para_Data_gen_check_form_this_module = '1';
    --for
    elastic_buf_en <= not(XCVR_TxRx_rst);

    --XCVR module connect

    v6_gtxwizard_v1_12_i : v6_gtxwizard_v1_12
        generic map
        (
            WRAPPER_SIM_GTXRESET_SPEEDUP    =>      1
        )
        port map
        (
            --_____________________________________________________________________
            --_____________________________________________________________________
            --GTX0  (X0Y4)

            ------------------------ Loopback and Powerdown Ports ----------------------
            GTX0_LOOPBACK_IN                =>      internal_loopback_en_ch,
            ----------------------- Receive Ports - 8b10b Decoder ----------------------
            GTX0_RXCHARISCOMMA_OUT          =>      pattern_is_comma(0),
            GTX0_RXCHARISK_OUT              =>      rx_data_k_ch(0),
            GTX0_RXDISPERR_OUT              =>      rx_disp_err_ch(0),
            GTX0_RXNOTINTABLE_OUT           =>      rx_not_in_8b10b_table(0),
            --------------- Receive Ports - Comma Detection and Alignment --------------
            GTX0_RXBYTEISALIGNED_OUT        =>      rx_byte_aligned(0),
            GTX0_RXCOMMADET_OUT             =>      rx_comma_detected(0),
            GTX0_RXENMCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            GTX0_RXENPCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            ------------------- Receive Ports - RX Data Path interface -----------------
            GTX0_RXDATA_OUT                 =>      xcvr_rx_Para_data_ch(0),
            GTX0_RXRECCLK_OUT               =>      XCVR_Rx_clk_out_ch(0),
            GTX0_RXRESET_IN                 =>      XCVR_TxRx_rst(0),
            GTX0_RXUSRCLK2_IN               =>      rx_clk_buf_out(0),
            ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
            GTX0_RXEQMIX_IN                 =>      rx_eq_mix_0,
            GTX0_RXN_IN                     =>      RX_ser_N(0),
            GTX0_RXP_IN                     =>      RX_ser(0),
            ------------------------ Receive Ports - RX PLL Ports ----------------------
            GTX0_GTXRXRESET_IN              =>      XCVR_TxRx_rst(0),
            GTX0_MGTREFCLKRX_IN             =>      XCVR_Ref_Clock,
            GTX0_PLLRXRESET_IN              =>      XCVR_TxRx_rst(0),
            GTX0_RXPLLLKDET_OUT             =>      rx_freqlocked_ch(0),
            GTX0_RXRESETDONE_OUT            =>      XCVR_RX_ready_ch(0),
            ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
            GTX0_TXCHARISK_IN               =>      tx_data_k_ch(0),
            ------------------------- Transmit Ports - GTX Ports -----------------------
            GTX0_GTXTEST_IN                 =>      gtx_test_0,
            ------------------ Transmit Ports - TX Data Path interface -----------------
            GTX0_TXDATA_IN                  =>      xcvr_tx_Para_data_ch(0),
            GTX0_TXOUTCLK_OUT               =>      XCVR_Tx_clk_out_ch(0),
            GTX0_TXRESET_IN                 =>      XCVR_TxRx_rst(0),
            GTX0_TXUSRCLK2_IN               =>      tx_clk_buf_out(0),
            ---------------- Transmit Ports - TX Driver and OOB signaling --------------
            GTX0_TXDIFFCTRL_IN              =>      tx_diff_ctrl_0,
            GTX0_TXN_OUT                    =>      TX_ser_N(0),
            GTX0_TXP_OUT                    =>      TX_ser(0),
            GTX0_TXPOSTEMPHASIS_IN          =>      tx_post_emphasis_0,
            --------------- Transmit Ports - TX Driver and OOB signalling --------------
            GTX0_TXPREEMPHASIS_IN           =>      tx_pre_emphasis_0,
            ----------------------- Transmit Ports - TX PLL Ports ----------------------
            GTX0_GTXTXRESET_IN              =>      XCVR_TxRx_rst(0),
            GTX0_TXRESETDONE_OUT            =>      XCVR_TX_ready_ch(0),


            --_____________________________________________________________________
            --_____________________________________________________________________
            --GTX1  (X0Y5)

            ------------------------ Loopback and Powerdown Ports ----------------------
            GTX1_LOOPBACK_IN                =>      internal_loopback_en_ch,
            ----------------------- Receive Ports - 8b10b Decoder ----------------------
            GTX1_RXCHARISCOMMA_OUT          =>      pattern_is_comma(1),
            GTX1_RXCHARISK_OUT              =>      rx_data_k_ch(1),
            GTX1_RXDISPERR_OUT              =>      rx_disp_err_ch(1),
            GTX1_RXNOTINTABLE_OUT           =>      rx_not_in_8b10b_table(1),
            --------------- Receive Ports - Comma Detection and Alignment --------------
            GTX1_RXBYTEISALIGNED_OUT        =>      rx_byte_aligned(1),
            GTX1_RXCOMMADET_OUT             =>      rx_comma_detected(1),
            GTX1_RXENMCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            GTX1_RXENPCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            ------------------- Receive Ports - RX Data Path interface -----------------
            GTX1_RXDATA_OUT                 =>      xcvr_rx_Para_data_ch(1),
            GTX1_RXRECCLK_OUT               =>      XCVR_Rx_clk_out_ch(1),
            GTX1_RXRESET_IN                 =>      XCVR_TxRx_rst(1),
            GTX1_RXUSRCLK2_IN               =>      rx_clk_buf_out(1),
            ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
            GTX1_RXEQMIX_IN                 =>      rx_eq_mix_1,
            GTX1_RXN_IN                     =>      RX_ser_N(1),
            GTX1_RXP_IN                     =>      RX_ser(1),
            ------------------------ Receive Ports - RX PLL Ports ----------------------
            GTX1_GTXRXRESET_IN              =>      XCVR_TxRx_rst(1),
            GTX1_MGTREFCLKRX_IN             =>      XCVR_Ref_Clock,
            GTX1_PLLRXRESET_IN              =>      XCVR_TxRx_rst(1),
            GTX1_RXPLLLKDET_OUT             =>      rx_freqlocked_ch(1),
            GTX1_RXRESETDONE_OUT            =>      XCVR_RX_ready_ch(1),
            ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
            GTX1_TXCHARISK_IN               =>      tx_data_k_ch(1),
            ------------------------- Transmit Ports - GTX Ports -----------------------
            GTX1_GTXTEST_IN                 =>      gtx_test_1,
            ------------------ Transmit Ports - TX Data Path interface -----------------
            GTX1_TXDATA_IN                  =>      xcvr_tx_Para_data_ch(1),
            GTX1_TXOUTCLK_OUT               =>      XCVR_Tx_clk_out_ch(1),
            GTX1_TXRESET_IN                 =>      XCVR_TxRx_rst(1),
            GTX1_TXUSRCLK2_IN               =>      tx_clk_buf_out(1),
            ---------------- Transmit Ports - TX Driver and OOB signaling --------------
            GTX1_TXDIFFCTRL_IN              =>      tx_diff_ctrl_1,
            GTX1_TXN_OUT                    =>      TX_ser_N(1),
            GTX1_TXP_OUT                    =>      TX_ser(1),
            GTX1_TXPOSTEMPHASIS_IN          =>      tx_post_emphasis_1,
            --------------- Transmit Ports - TX Driver and OOB signalling --------------
            GTX1_TXPREEMPHASIS_IN           =>      tx_pre_emphasis_1,
            ----------------------- Transmit Ports - TX PLL Ports ----------------------
            GTX1_GTXTXRESET_IN              =>      XCVR_TxRx_rst(1),
            GTX1_TXRESETDONE_OUT            =>      XCVR_TX_ready_ch(1),


            --_____________________________________________________________________
            --_____________________________________________________________________
            --GTX2  (X0Y6)

            ------------------------ Loopback and Powerdown Ports ----------------------
            GTX2_LOOPBACK_IN                =>      internal_loopback_en_ch,
            ----------------------- Receive Ports - 8b10b Decoder ----------------------
            GTX2_RXCHARISCOMMA_OUT          =>      pattern_is_comma(2),
            GTX2_RXCHARISK_OUT              =>      rx_data_k_ch(2),
            GTX2_RXDISPERR_OUT              =>      rx_disp_err_ch(2),
            GTX2_RXNOTINTABLE_OUT           =>      rx_not_in_8b10b_table(2),
            --------------- Receive Ports - Comma Detection and Alignment --------------
            GTX2_RXBYTEISALIGNED_OUT        =>      rx_byte_aligned(2),
            GTX2_RXCOMMADET_OUT             =>      rx_comma_detected(2),
            GTX2_RXENMCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            GTX2_RXENPCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            ------------------- Receive Ports - RX Data Path interface -----------------
            GTX2_RXDATA_OUT                 =>      xcvr_rx_Para_data_ch(2),
            GTX2_RXRECCLK_OUT               =>      XCVR_Rx_clk_out_ch(2),
            GTX2_RXRESET_IN                 =>      XCVR_TxRx_rst(2),
            GTX2_RXUSRCLK2_IN               =>      rx_clk_buf_out(2),
            ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
            GTX2_RXEQMIX_IN                 =>      rx_eq_mix_2,
            GTX2_RXN_IN                     =>      RX_ser_N(2),
            GTX2_RXP_IN                     =>      RX_ser(2),
            ------------------------ Receive Ports - RX PLL Ports ----------------------
            GTX2_GTXRXRESET_IN              =>      XCVR_TxRx_rst(2),
            GTX2_MGTREFCLKRX_IN             =>      XCVR_Ref_Clock,
            GTX2_PLLRXRESET_IN              =>      XCVR_TxRx_rst(2),
            GTX2_RXPLLLKDET_OUT             =>      rx_freqlocked_ch(2),
            GTX2_RXRESETDONE_OUT            =>      XCVR_RX_ready_ch(2),
            ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
            GTX2_TXCHARISK_IN               =>      tx_data_k_ch(2),
            ------------------------- Transmit Ports - GTX Ports -----------------------
            GTX2_GTXTEST_IN                 =>      gtx_test_2,
            ------------------ Transmit Ports - TX Data Path interface -----------------
            GTX2_TXDATA_IN                  =>      xcvr_tx_Para_data_ch(2),
            GTX2_TXOUTCLK_OUT               =>      XCVR_Tx_clk_out_ch(2),
            GTX2_TXRESET_IN                 =>      XCVR_TxRx_rst(2),
            GTX2_TXUSRCLK2_IN               =>      tx_clk_buf_out(2),
            ---------------- Transmit Ports - TX Driver and OOB signaling --------------
            GTX2_TXDIFFCTRL_IN              =>      tx_diff_ctrl_2,
            GTX2_TXN_OUT                    =>      TX_ser_N(2),
            GTX2_TXP_OUT                    =>      TX_ser(2),
            GTX2_TXPOSTEMPHASIS_IN          =>      tx_post_emphasis_2,
            --------------- Transmit Ports - TX Driver and OOB signalling --------------
            GTX2_TXPREEMPHASIS_IN           =>      tx_pre_emphasis_2,
            ----------------------- Transmit Ports - TX PLL Ports ----------------------
            GTX2_GTXTXRESET_IN              =>      XCVR_TxRx_rst(2),
            GTX2_TXRESETDONE_OUT            =>      XCVR_TX_ready_ch(2),


            --_____________________________________________________________________
            --_____________________________________________________________________
            --GTX3  (X0Y7)

            ------------------------ Loopback and Powerdown Ports ----------------------
            GTX3_LOOPBACK_IN                =>      internal_loopback_en_ch,
            ----------------------- Receive Ports - 8b10b Decoder ----------------------
            GTX3_RXCHARISCOMMA_OUT          =>      pattern_is_comma(3),
            GTX3_RXCHARISK_OUT              =>      rx_data_k_ch(3) ,
            GTX3_RXDISPERR_OUT              =>      rx_disp_err_ch(3),
            GTX3_RXNOTINTABLE_OUT           =>      rx_not_in_8b10b_table(3),
            --------------- Receive Ports - Comma Detection and Alignment --------------
            GTX3_RXBYTEISALIGNED_OUT        =>      rx_byte_aligned(3),
            GTX3_RXCOMMADET_OUT             =>      rx_comma_detected(3),
            GTX3_RXENMCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            GTX3_RXENPCOMMAALIGN_IN         =>      rx_std_wa_patternalign,
            ------------------- Receive Ports - RX Data Path interface -----------------
            GTX3_RXDATA_OUT                 =>      xcvr_rx_Para_data_ch(3),
            GTX3_RXRECCLK_OUT               =>      XCVR_Rx_clk_out_ch(3),
            GTX3_RXRESET_IN                 =>      XCVR_TxRx_rst(3),
            GTX3_RXUSRCLK2_IN               =>      rx_clk_buf_out(3),
            ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
            GTX3_RXEQMIX_IN                 =>      rx_eq_mix_3,
            GTX3_RXN_IN                     =>      RX_ser_N(3),
            GTX3_RXP_IN                     =>      RX_ser(3),
            ------------------------ Receive Ports - RX PLL Ports ----------------------
            GTX3_GTXRXRESET_IN              =>      XCVR_TxRx_rst(3),
            GTX3_MGTREFCLKRX_IN             =>      XCVR_Ref_Clock,
            GTX3_PLLRXRESET_IN              =>      XCVR_TxRx_rst(3),
            GTX3_RXPLLLKDET_OUT             =>      rx_freqlocked_ch(3),
            GTX3_RXRESETDONE_OUT            =>      XCVR_RX_ready_ch(3),
            ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
            GTX3_TXCHARISK_IN               =>      tx_data_k_ch(3),
            ------------------------- Transmit Ports - GTX Ports -----------------------
            GTX3_GTXTEST_IN                 =>      gtx_test_3,
            ------------------ Transmit Ports - TX Data Path interface -----------------
            GTX3_TXDATA_IN                  =>      xcvr_tx_Para_data_ch(3),
            GTX3_TXOUTCLK_OUT               =>      XCVR_Tx_clk_out_ch(3),
            GTX3_TXRESET_IN                 =>      XCVR_TxRx_rst(3),
            GTX3_TXUSRCLK2_IN               =>      tx_clk_buf_out(3),
            ---------------- Transmit Ports - TX Driver and OOB signaling --------------
            GTX3_TXDIFFCTRL_IN              =>      tx_diff_ctrl_3,
            GTX3_TXN_OUT                    =>      TX_ser_N(3),
            GTX3_TXP_OUT                    =>      TX_ser(3),
            GTX3_TXPOSTEMPHASIS_IN          =>      tx_post_emphasis_3,
            --------------- Transmit Ports - TX Driver and OOB signalling --------------
            GTX3_TXPREEMPHASIS_IN           =>      tx_pre_emphasis_3,
            ----------------------- Transmit Ports - TX PLL Ports ----------------------
            GTX3_GTXTXRESET_IN              =>      XCVR_TxRx_rst(3),
            GTX3_TXRESETDONE_OUT            =>      XCVR_TX_ready_ch(3)


        );
    --others connect
    Data_gen_loop : for i in 0 to (num_of_xcvr_ch - 1) generate
        judg_if_data_is_internal : if scr_para_Data_gen_check_form_this_module = '1' generate
            Data_gen : entity work.frame_gen
                port map(
                    TX_D              => tx_Para_data_internal_ch(i),

                    TX_traffic_ready  => tx_traffic_ready_internal_ch,

                    USER_CLK          => tx_clk_buf_out(i) ,
                    SYSTEM_RESET_N    => RST_N
                );
        end generate judg_if_data_is_internal;
    end generate Data_gen_loop;

    Data_check_loop : for i in 0 to (num_of_xcvr_ch - 1) generate
        judg_if_data_is_internal : if scr_para_Data_gen_check_form_this_module = '1' generate
            Data_check : entity work.frame_check
                port map(
                    RX_D              => rx_Para_data_internal_ch(i),

                    RX_traffic_ready  => rx_traffic_ready_internal_ch,

                    RX_errdetect      => rx_err_detec_ch(i),
                    RX_disperr        => rx_disp_err_ch(i),
                    rx_freq_locked    => rx_freqlocked_ch(i),

                    ERROR_COUNT       => error_cnt_ch(i),

                    USER_CLK          => rx_clk_buf_out(i),
                    SYSTEM_RESET_N    => RST_N
                );
        end generate judg_if_data_is_internal;
    end generate Data_check_loop;

    generate_traffic_loop : for i in 0 to (num_of_xcvr_ch - 1) generate
        traffic : entity work.traffic
            port map(
                Reset_n                  => RST_N,

                tx_traffic_ready         => TX_traffic_ready_ch(i),
                rx_traffic_ready         => RX_traffic_ready_ch(i),

                rx_elastic_buf_done      => rx_elastic_buf_aligned(i),
                Lane_up                  => lane_up, 

                rx_elastic_buf_sync_done => elastic_buf_sync_done,
                gp_sync_can_start        => open,

                Tx_K                     => tx_data_k_ch(i),
                Rx_K                     => rx_data_k_ch(i),
                TX_DATA_Xcvr             => xcvr_tx_Para_data_ch(i),
                RX_DATA_Xcvr             => xcvr_rx_Para_data_ch(i),
                Tx_DATA_client           => tx_Para_data_ch(i),
                Rx_DATA_client           => rx_Para_data_to_sync_buf_ch(i),

                Tx_Clk                   => tx_clk_buf_out(i),
                Rx_Clk                   => rx_clk_buf_out(i)
            );
    end generate generate_traffic_loop;
    
    ch_sync_buf_4ch : entity work.ch_sync_buffer
    port map(
        ch_sync_buffer_data_In          => rx_Para_data_to_sync_buf_ch,

        ch_sync_buffer_data_Out         => rx_Para_data_from_sync_buf_ch,

        ch_sync_buffer_sync_done        => elastic_buf_sync_done,
        ch_sync_buffer_overflow         => elastic_buf_overflow,

        sync_en                         => lane_up,

        ch_sync_buffer_directly_pass    => not(grouping_enable),
        
        CLK                             => rx_clk_buf_out(0),
        RST_N                           => RST_N
    );   

    loop_connect_pattern_detect_and_sync_status : for i in 0 to (num_of_xcvr_ch -1) generate
        rx_patterndetect_ch(i)  <= "01"  when  rx_comma_detected(i) = '1' else "00";
        rx_syncstatus_ch(i)     <= "11"  when  rx_byte_aligned(i)   = '1' else "00";
    end generate loop_connect_pattern_detect_and_sync_status;
    
    rst_ctrl : entity work.reset_ctrl
    Port map(
        Reset_n                  => RST_N,
        INIT_CLK                 => init_clock,

        
        XCVR_rst_out             => XCVR_TxRx_rst,
        align_en                 => rx_std_wa_patternalign,
        lane_up                  => lane_up,
        
        rx_freq_locked           => rx_freqlocked_ch,

        Tx_xcvrRstIp_is_Ready    => XCVR_TX_ready_ch,
        Rx_xcvrRstIp_is_Ready    => XCVR_RX_ready_ch,

        RX_elastic_buf_overflow  => elastic_buf_overflow
        rx_sync_status           => rx_syncstatus_ch,
        rx_pattern_detected      => rx_patterndetect_ch,
        RX_errdetect             => rx_err_detec_ch,
        RX_disperr               => rx_disp_err_ch
    );

    generate_TX_BUFG_loop : for i in 0 to (num_of_xcvr_ch - 1) generate
        xcvr_tx_data_clk_buf_used_assert : if xcvr_tx_data_clk_buf_used = '1' generate
            gen_TX_BUFG : BUFG
                port map
                (
                    I                               =>      XCVR_Tx_clk_out_ch(i),
                    O                               =>      tx_clk_buf_out(i)
                );
        end generate xcvr_tx_data_clk_buf_used_assert;
        xcvr_tx_data_clk_buf_not_used_assert : if xcvr_tx_data_clk_buf_used = '0' generate
            tx_clk_buf_out(i) <= XCVR_Tx_clk_out_ch(i);
        end generate xcvr_tx_data_clk_buf_not_used_assert;
    end generate  generate_TX_BUFG_loop;

    generate_RX_BUFG_loop : for i in 0 to (num_of_xcvr_ch - 1) generate
        xcvr_rx_data_clk_buf_used_assert : if xcvr_rx_data_clk_buf_used = '1' generate
            gen_RX_BUFG : BUFG
                port map
                (
                    I                               =>      XCVR_Rx_clk_out_ch(i),
                    O                               =>      rx_clk_buf_out(i)
                );
        end generate xcvr_rx_data_clk_buf_used_assert;
        xcvr_rx_data_clk_buf_not_used_assert : if xcvr_rx_data_clk_buf_used = '0' generate
            rx_clk_buf_out(i) <= XCVR_Rx_clk_out_ch(i);
        end generate xcvr_rx_data_clk_buf_not_used_assert;
    end generate generate_RX_BUFG_loop;


    icon : chipscope_icon
    port map (
      CONTROL0 => chip_scope_ctrl_0,
      CONTROL1 => chip_scope_ctrl_1
    );

    ila_tx : chipscope_ila
        port map (
            CONTROL => chip_scope_ctrl_0,
            CLK => tx_clk_buf_out(0),
            TRIG0 => tx_Para_data_ch(0),
            TRIG1 => tx_Para_data_ch(1),
            TRIG2 => tx_Para_data_ch(2),
            TRIG3 => tx_Para_data_ch(3),
            TRIG4 => (others =>'0'),
            TRIG5 => (others =>'0')
        );
    ila_rx : chipscope_ila
        port map (
            CONTROL => chip_scope_ctrl_1,
            CLK => rx_clk_buf_out(0),
            TRIG0 => rx_Para_data_ch(0),
            TRIG1 => rx_Para_data_ch(1),
            TRIG2 => rx_Para_data_ch(2),
            TRIG3 => rx_Para_data_ch(3),
            TRIG4 => (others =>'0'),
            TRIG5 => (others =>'0')
        );

end architecture XCVR_8B10B_interconnect_Top;
