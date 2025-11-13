onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /slave_tb/pclk
add wave -noupdate /slave_tb/preset_n
add wave -noupdate -expand -group Master /slave_tb/psel
add wave -noupdate -expand -group Master /slave_tb/penable
add wave -noupdate -expand -group Master /slave_tb/paddr
add wave -noupdate -expand -group Master /slave_tb/pwrite
add wave -noupdate -expand -group Master /slave_tb/pwdata
add wave -noupdate -expand -group Master /slave_tb/pstrb
add wave -noupdate -expand -group Master /slave_tb/pprot
add wave -noupdate -expand -group Slave /slave_tb/DUT/cs
add wave -noupdate -expand -group Slave /slave_tb/slave_address
add wave -noupdate -expand -group Slave /slave_tb/slave_read_write
add wave -noupdate -expand -group Slave /slave_tb/slave_write_data
add wave -noupdate -expand -group Slave /slave_tb/slave_strobe
add wave -noupdate -expand -group Slave /slave_tb/slave_protection
add wave -noupdate -expand -group Slave /slave_tb/master_data_ready
add wave -noupdate -expand -group Slave /slave_tb/pready
add wave -noupdate -expand -group Slave /slave_tb/prdata
add wave -noupdate -expand -group Slave /slave_tb/pslverr
add wave -noupdate -expand -group Completer /slave_tb/slave_data_valid
add wave -noupdate -expand -group Completer /slave_tb/slave_read_data
add wave -noupdate -expand -group Completer /slave_tb/slave_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 184
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {61 ns}
