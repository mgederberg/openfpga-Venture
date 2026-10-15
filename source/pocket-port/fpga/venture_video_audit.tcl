project_open ap_core -revision ap_core
create_timing_netlist
read_sdc
update_timing_netlist

set pixels [get_registers {*|pixel_*}]
puts "Matched pixel registers: [get_collection_size $pixels]"

if {[get_collection_size $pixels] == 0} {
    error "No pixel registers matched"
}

report_timing -setup -to $pixels -npaths 20 \
    -detail full_path -file venture_video_setup.txt

report_timing -hold -to $pixels -npaths 20 \
    -detail full_path -file venture_video_hold.txt

puts "=== VIDEO TIMING AUDIT COMPLETE ==="
delete_timing_netlist
project_close
