project_open ap_core -revision ap_core
create_timing_netlist
read_sdc
update_timing_netlist

puts "=== PIXEL REGISTER DISCOVERY ==="

set regs [get_registers *]

puts "Total matched registers: [get_collection_size $regs]"

foreach_in_collection reg $regs {
    set name [get_node_info -name $reg]
    if {[string match -nocase *pixel* $name] ||
        [string match -nocase *video* $name] ||
        [string match -nocase *rgb* $name]} {
        puts $name
    }
}

delete_timing_netlist
project_close
