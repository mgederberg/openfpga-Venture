project_open ap_core
create_timing_netlist
read_sdc
update_timing_netlist

report_timing \
    -setup \
    -npaths 10 \
    -detail full_path \
    -panel_name "Venture Worst Setup Paths"

report_timing \
    -recovery \
    -npaths 10 \
    -detail full_path \
    -panel_name "Venture Worst Recovery Paths"

report_ucp \
    -panel_name "Venture Unconstrained Paths"

delete_timing_netlist
project_close
