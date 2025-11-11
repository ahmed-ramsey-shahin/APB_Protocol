onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /master_tb/pclk
add wave -noupdate /master_tb/preset_n
add wave -noupdate -expand -group Requester /master_tb/master_transfer
add wave -noupdate -expand -group Requester /master_tb/master_select
add wave -noupdate -expand -group Requester /master_tb/master_address
add wave -noupdate -expand -group Requester /master_tb/master_read_write
add wave -noupdate -expand -group Requester /master_tb/master_write_data
add wave -noupdate -expand -group Requester /master_tb/master_strobe
add wave -noupdate -expand -group Requester /master_tb/master_protection
add wave -noupdate -expand -group Master /master_tb/DUT/cs
add wave -noupdate -expand -group Master /master_tb/penable
add wave -noupdate -expand -group Master /master_tb/psel
add wave -noupdate -expand -group Master /master_tb/paddr
add wave -noupdate -expand -group Master /master_tb/pwrite
add wave -noupdate -expand -group Master /master_tb/pwdata
add wave -noupdate -expand -group Master /master_tb/pstrb
add wave -noupdate -expand -group Master /master_tb/pprot
add wave -noupdate -expand -group Master /master_tb/slave_data_ready
add wave -noupdate -expand -group Master /master_tb/slave_read_data
add wave -noupdate -expand -group Master /master_tb/slave_error
add wave -noupdate -expand -group Slave /master_tb/pready
add wave -noupdate -expand -group Slave /master_tb/prdata
add wave -noupdate -expand -group Slave /master_tb/pslverr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
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
