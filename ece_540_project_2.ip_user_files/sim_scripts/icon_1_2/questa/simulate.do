onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib icon_1_opt

do {wave.do}

view wave
view structure
view signals

do {icon_1.udo}

run -all

quit -force
