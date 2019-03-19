###############################################################################
##
## (c) Copyright 2009-2011 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
## 
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.



wcfg new
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/begin_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/track_data_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/data_error_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/start_of_packet_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/RX_DATA
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx0_frame_check/ERROR_COUNT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/begin_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/track_data_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/data_error_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/start_of_packet_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/RX_DATA
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx1_frame_check/ERROR_COUNT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/begin_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/track_data_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/data_error_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/start_of_packet_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/RX_DATA
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx2_frame_check/ERROR_COUNT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/begin_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/track_data_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/data_error_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/start_of_packet_detected_r
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/RX_DATA
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/gtx3_frame_check/ERROR_COUNT
divider add "Loopback and Powerdown Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/LOOPBACK_IN
divider add "Receive Ports - 8b10b Decoder"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXCHARISCOMMA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXCHARISK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXDISPERR_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXNOTINTABLE_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXRUNDISP_OUT
divider add "Receive Ports - Comma Detection and Alignment"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXBYTEISALIGNED_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXCOMMADET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXENMCOMMAALIGN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXENPCOMMAALIGN_IN
divider add "Receive Ports - RX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXDATA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXRECCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXUSRCLK2_IN
divider add "Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXEQMIX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXP_IN
divider add "Receive Ports - RX Loss-of-sync State Machine"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXLOSSOFSYNC_OUT
divider add "Receive Ports - RX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/GTXRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/MGTREFCLKRX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/PLLRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXPLLLKDET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/RXRESETDONE_OUT
divider add "Transmit Ports - 8b10b Encoder Control Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXCHARISK_IN
divider add "Transmit Ports - GTX Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/GTXTEST_IN
divider add "Transmit Ports - TX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXDATA_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXOUTCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXUSRCLK2_IN
divider add "Transmit Ports - TX Driver and OOB signaling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXDIFFCTRL_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXN_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXP_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXPOSTEMPHASIS_IN
divider add "Transmit Ports - TX Driver and OOB signalling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXPREEMPHASIS_IN
divider add "Transmit Ports - TX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/GTXTXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx0_v6_gtxwizard_v1_12_i/TXRESETDONE_OUT

divider add "Loopback and Powerdown Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/LOOPBACK_IN
divider add "Receive Ports - 8b10b Decoder"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXCHARISCOMMA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXCHARISK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXDISPERR_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXNOTINTABLE_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXRUNDISP_OUT
divider add "Receive Ports - Comma Detection and Alignment"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXBYTEISALIGNED_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXCOMMADET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXENMCOMMAALIGN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXENPCOMMAALIGN_IN
divider add "Receive Ports - RX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXDATA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXRECCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXUSRCLK2_IN
divider add "Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXEQMIX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXP_IN
divider add "Receive Ports - RX Loss-of-sync State Machine"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXLOSSOFSYNC_OUT
divider add "Receive Ports - RX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/GTXRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/MGTREFCLKRX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/PLLRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXPLLLKDET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/RXRESETDONE_OUT
divider add "Transmit Ports - 8b10b Encoder Control Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXCHARISK_IN
divider add "Transmit Ports - GTX Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/GTXTEST_IN
divider add "Transmit Ports - TX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXDATA_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXOUTCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXUSRCLK2_IN
divider add "Transmit Ports - TX Driver and OOB signaling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXDIFFCTRL_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXN_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXP_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXPOSTEMPHASIS_IN
divider add "Transmit Ports - TX Driver and OOB signalling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXPREEMPHASIS_IN
divider add "Transmit Ports - TX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/GTXTXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx1_v6_gtxwizard_v1_12_i/TXRESETDONE_OUT

divider add "Loopback and Powerdown Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/LOOPBACK_IN
divider add "Receive Ports - 8b10b Decoder"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXCHARISCOMMA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXCHARISK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXDISPERR_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXNOTINTABLE_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXRUNDISP_OUT
divider add "Receive Ports - Comma Detection and Alignment"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXBYTEISALIGNED_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXCOMMADET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXENMCOMMAALIGN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXENPCOMMAALIGN_IN
divider add "Receive Ports - RX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXDATA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXRECCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXUSRCLK2_IN
divider add "Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXEQMIX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXP_IN
divider add "Receive Ports - RX Loss-of-sync State Machine"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXLOSSOFSYNC_OUT
divider add "Receive Ports - RX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/GTXRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/MGTREFCLKRX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/PLLRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXPLLLKDET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/RXRESETDONE_OUT
divider add "Transmit Ports - 8b10b Encoder Control Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXCHARISK_IN
divider add "Transmit Ports - GTX Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/GTXTEST_IN
divider add "Transmit Ports - TX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXDATA_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXOUTCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXUSRCLK2_IN
divider add "Transmit Ports - TX Driver and OOB signaling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXDIFFCTRL_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXN_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXP_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXPOSTEMPHASIS_IN
divider add "Transmit Ports - TX Driver and OOB signalling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXPREEMPHASIS_IN
divider add "Transmit Ports - TX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/GTXTXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx2_v6_gtxwizard_v1_12_i/TXRESETDONE_OUT

divider add "Loopback and Powerdown Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/LOOPBACK_IN
divider add "Receive Ports - 8b10b Decoder"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXCHARISCOMMA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXCHARISK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXDISPERR_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXNOTINTABLE_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXRUNDISP_OUT
divider add "Receive Ports - Comma Detection and Alignment"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXBYTEISALIGNED_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXCOMMADET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXENMCOMMAALIGN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXENPCOMMAALIGN_IN
divider add "Receive Ports - RX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXDATA_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXRECCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXUSRCLK2_IN
divider add "Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXEQMIX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXN_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXP_IN
divider add "Receive Ports - RX Loss-of-sync State Machine"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXLOSSOFSYNC_OUT
divider add "Receive Ports - RX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/GTXRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/MGTREFCLKRX_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/PLLRXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXPLLLKDET_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/RXRESETDONE_OUT
divider add "Transmit Ports - 8b10b Encoder Control Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXCHARISK_IN
divider add "Transmit Ports - GTX Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/GTXTEST_IN
divider add "Transmit Ports - TX Data Path interface"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXDATA_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXOUTCLK_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXUSRCLK2_IN
divider add "Transmit Ports - TX Driver and OOB signaling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXDIFFCTRL_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXN_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXP_OUT
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXPOSTEMPHASIS_IN
divider add "Transmit Ports - TX Driver and OOB signalling"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXPREEMPHASIS_IN
divider add "Transmit Ports - TX PLL Ports"
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/GTXTXRESET_IN
wave add /DEMO_TB/v6_gtxwizard_v1_12_top_i/v6_gtxwizard_v1_12_i/gtx3_v6_gtxwizard_v1_12_i/TXRESETDONE_OUT

run 64 us
quit



