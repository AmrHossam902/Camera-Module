
vsim -gui work.selectdata
# vsim -gui work.selectdata 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.selectdata(selectdata_arc)
add wave -position insertpoint  \
sim:/selectdata/inc_dec \
sim:/selectdata/s \
sim:/selectdata/address \
sim:/selectdata/func
force -freeze sim:/selectdata/address 00000000 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 00001111 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 11110000 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 11111111 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 11111001 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 10010000 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 10011111 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run
force -freeze sim:/selectdata/address 10011001 0
force -freeze sim:/selectdata/inc_dec 1 0
force -freeze sim:/selectdata/s 10 0
run
force -freeze sim:/selectdata/inc_dec 0 0
run
force -freeze sim:/selectdata/s 01 0
run
force -freeze sim:/selectdata/inc_dec 1 0
run