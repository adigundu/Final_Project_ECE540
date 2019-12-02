set_property SRC_FILE_INFO {cfile:n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.xdc rfile:../ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:clk_wiz_0/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
