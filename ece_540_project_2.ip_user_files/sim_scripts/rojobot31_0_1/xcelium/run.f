-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../ece_540_project_2.srcs/sources_1/ip/rojobot31_0_1/src/bot31_if.v" \
  "../../../../ece_540_project_2.srcs/sources_1/ip/rojobot31_0_1/src/bot31_pgm.v" \
  "../../../../ece_540_project_2.srcs/sources_1/ip/rojobot31_0_1/src/kcpsm6.v" \
  "../../../../ece_540_project_2.srcs/sources_1/ip/rojobot31_0_1/src/bot31_top.v" \
  "../../../../ece_540_project_2.srcs/sources_1/ip/rojobot31_0_1/sim/rojobot31_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

