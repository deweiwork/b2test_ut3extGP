
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name BelleIIvt6 -dir "C:/Users/B1409_Server/Desktop/BelleII_Xilinx/BelleIIvt6127gp/planAhead_run_4" -part xc6vhx380tff1923-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/B1409_Server/Desktop/BelleII_Xilinx/BelleIIvt6127gp/XCVR_TOP.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/B1409_Server/Desktop/BelleII_Xilinx/BelleIIvt6127gp} {../ipcore_dir} {../ipcore_dir/v6_gtxwizard_v1_12/implement} }
add_files [list {../ipcore_dir/chipscope_icon.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {../ipcore_dir/chipscope_ila.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "XCVR_TOP.ucf" [current_fileset -constrset]
add_files [list {XCVR_TOP.ucf}] -fileset [get_property constrset [current_run]]
link_design
