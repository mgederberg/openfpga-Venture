project_open ap_core -revision ap_core
create_timing_netlist
read_sdc
update_timing_netlist

set pixels [get_registers {*|pixel_*}]
puts "=== PIXEL REGISTERS ==="
puts "Count: [get_collection_size $pixels]"

foreach_in_collection reg $pixels {
    puts [get_node_info -name $reg]
}

puts "=== PIXEL CLOCK PATHS ==="
report_timing -setup \
    -from [get_clocks *] \
    -to $pixels \
    -npaths 20 \
    -file venture_pixel_clock_paths.txt

puts "=== CLOCK INVENTORY ==="
foreach_in_collection clk [get_clocks *] {
    puts [get_clock_info -name $clk]
}

delete_timing_netlist
project_close
