# Set design and testbench variables
set mod {../rtl/APB_Slave.sv APB_Slave}
set top {slave_tb.sv slave_tb}
set extra_compile_files {}
set wave_file slave_wave.do

proc start {args} {
    global mod top extra_compile_files wave_file

    if {[lsearch -exact $args -save_wave] >= 0} {
        write format wave -window .main_pane.wave.interior.cs.body.pw.wf $wave_file
        return
    }

    puts "Simulate mode ON"
    # Compile design, testbench, and the extra files
    eval [list vlog +cover -covercells] $extra_compile_files [lindex $mod 0] [lindex $top 0]

    # Start the simulator
    vsim -voptargs=+acc work.[lindex $top 1] -cover
    
    if {[lsearch -exact $args -coverage] >= 0} {
        # Switch layout to simulate if -cover does not exist
        layout load Coverage
        # Save coverage db on exit
        coverage save [lindex $mod 1].ucdb -onexit -du [lindex $mod 1] -du [lindex $mod 1]_if
    } else {
        layout load Simulate
    }

    radix unsigned
    run 0

    # Add all waves
    if {[lsearch -exact $args -no_wave] >= 0} {
        add wave *
    } else {
        do $wave_file
    }

    # Run simulation
    run -all

    if {([lsearch -exact $args -report] >= 0) && ([lsearch -exact $args -coverage] >= 0)} {
        # quit simulation and generate coverage report
        coverage report -assert -detail -output assertion_report.txt
        coverage report -detail -cvg -directive -comments -output fcover_report.txt {}
        quit -sim
        vcover report [lindex $mod 1].ucdb -details -annotate -all -output ccover_report.txt
    }
}
