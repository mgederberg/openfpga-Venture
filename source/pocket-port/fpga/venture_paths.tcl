project_open ap_core
create_timing_netlist
read_sdc
update_timing_netlist

report_timing \
    -setup \
    -npaths 10 \
    -detail full_path \
    -file venture_setup_paths.txt

report_timing \
    -recovery \
    -npaths 10 \
    -detail full_path \
    -file venture_recovery_paths.txt

report_ucp \
    -file venture_unconstrained_paths.txt

delete_timing_netlist
project_close
