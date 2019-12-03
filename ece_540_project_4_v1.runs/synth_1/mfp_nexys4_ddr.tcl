# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache N:/ECE540/540FinalProject/.Xil/Vivado-10048-caplab12/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config  -ruleid {1}  -id {Synth 8-4442}  -string {{CRITICAL WARNING: [Synth 8-4442] BlackBox module map1_1 has unconnected pin addrb[13]}}  -suppress 
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir N:/ECE540/540FinalProject/ece_540_project_4_v1.cache/wt [current_project]
set_property parent.project_path N:/ECE540/540FinalProject/ece_540_project_4_v1.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths n:/ECE540/Downloads/proj2_release_f19/ece540_ip_repo/rojobot31 [current_project]
set_property ip_output_repo c:/Users/bupbup/ece_540_project_4/ece_540_project_2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files N:/ECE540/540FinalProject/yourmap.coe
add_files N:/ECE540/540FinalProject/coe/map1.coe
add_files N:/ECE540/540FinalProject/coe/map2.coe
add_files N:/ECE540/540FinalProject/coe/map3.coe
add_files N:/ECE540/540FinalProject/coe/map4.coe
read_verilog {
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_const.vh
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_config.vh
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dsp_const.vh
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mmu.vh
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_const.vh
}
read_verilog -library xil_defaultlib -sv {
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/new/addr_scaler.sv
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/new/colorizer.sv
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/new/dtg.sv
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/new/icon.sv
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/Final_Project_ECE540-bots_on_new_map_integration/Scoreboard/scoreboard.sv
}
read_verilog -library xil_defaultlib {
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/RAMB4K_S16.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/RAMB4K_S2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/RAMB4K_S8.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/Downloads/proj2_release_f19/ece540_ip_repo/rojobot31/src/bot31_if.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/Downloads/proj2_release_f19/ece540_ip_repo/rojobot31/src/bot31_pgm.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/new/bot31_pgm2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/Downloads/proj2_release_f19/ece540_ip_repo/rojobot31/src/bot31_top.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/d_wsram_2k2way_xilinx.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/dataram_2k2way_xilinx.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/debounce.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/i_wsram_2k2way_xilinx.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/Downloads/proj2_release_f19/ece540_ip_repo/rojobot31/src/kcpsm6.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_alu_dsp_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_alu_shft_32bit.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_bistctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_biu.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cache_cmp.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cache_mux.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cdmm.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cdmm_ctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cdmm_mpustub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_clock_buf.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_clock_nogate.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_clockandlatch.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_clockxnorgate.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cop1_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cop2_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_core.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cp1_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cp2_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpu.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_antitamper_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_eicoffset_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_guest_srs1.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_guest_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_pc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_pc_top.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_prid.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_root_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_sps_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_srs1.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cpz_watch_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cscramble_scanio_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cscramble_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_cscramble_tpl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dc_bistctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc_fb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc_mb_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc_parity_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc_spmb_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dcc_spstub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_dspram_ext_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp_add_simple.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp_buf_misc_pro.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp_clz.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp_clz_16b.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_edp_clz_4b.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_and2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_area.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_async_rec.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_async_snd.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_brk21.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_bus32mux2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_dbrk.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_fifo_1r1w_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_gate.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_ibrk.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_mux2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_pdttcb_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tap.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tap_dasam.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tap_fdc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tap_pcsam.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tck.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ejt_tripsync.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_fpuclk1_nogate.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_gf_mux2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_glue.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ic.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ic_bistctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc_mb_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc_parity_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc_spmb_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc_spstub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_icc_umips_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_ispram_ext_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mdl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mdl_add_simple.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mdl_ctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mdl_dp.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mmuc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mpc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mpc_ctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mpc_dec.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_mpc_exc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_rf_reg.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_rf_rngc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_rf_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_siu.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_siu_int_sync.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_spram_top.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_collector.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_cpy.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_ctl.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_dtlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_itlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_jtlb16.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_jtlb16entries.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_jtlb1entry.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_jtlb4entries.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_utlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_tlb_utlbentry.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_top.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_udi_custom.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/m14k_udi_scanio_stub.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/mfp_ahb_b_ram.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_gpio.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/mfp_ahb_p_ram.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_sevenseg_display.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_sevensegdec.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_sevensegtimer.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ahb_withloader.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_ejtag_reset.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_srec_parser.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_srec_parser_to_ahb_lite_bridge.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_sys.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/mfp_uart_receiver.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_c.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_ngc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_s.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_wide.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_wide_tlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_cregister_wide_utlb.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_latchn.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux16.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_10.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_13.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_24.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_3.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_4.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_5.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_6.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_8.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux1hot_9.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux4.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_mux8.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_register.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_register_c.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_register_ngc.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_register_s.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/mvp_ucregister_wide.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_b0.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_b1.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_b2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_b3.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_p0.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_p1.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_p2.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/system/memories/ram_p3.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/bupbup/ece_540_project_4/ece_540_project_2.srcs/sources_1/imports/rtl_up/core/tagram_2k2way_xilinx.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/Final_Project_ECE540-bots_on_new_map_integration/Worldselect/worldselect.v
  N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/imports/nexys4_ddr/mfp_nexys4_ddr.v
}
read_ip -quiet N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

read_ip -quiet N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map1/map1.xci
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map1/map1_ooc.xdc]

read_ip -quiet N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map2/map2.xci
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map2/map2_ooc.xdc]

read_ip -quiet N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map3/map3.xci
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map3/map3_ooc.xdc]

read_ip -quiet N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map4/map4.xci
set_property used_in_implementation false [get_files -all n:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/sources_1/ip/map4/map4_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/constrs_1/imports/nexys4_ddr/mfp_nexys4_ddr.xdc
set_property used_in_implementation false [get_files N:/ECE540/540FinalProject/ece_540_project_4_v1.srcs/constrs_1/imports/nexys4_ddr/mfp_nexys4_ddr.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top mfp_nexys4_ddr -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef mfp_nexys4_ddr.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file mfp_nexys4_ddr_utilization_synth.rpt -pb mfp_nexys4_ddr_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
