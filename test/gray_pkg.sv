package gray_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
   
  `include "gray_txn.sv"
  
  `include "gray_agent_config.sv"
  `include "gray_env_cfg.sv"
   
  `include "gray_seq.sv"
  `include "gray_sequencer.sv"
  `include "gray_driver.sv"
  `include "gray_monitor.sv"
  `include "gray_agent.sv"
  `include "gray_scoreboard.sv"

  `include "gray_env.sv"
  `include "gray_test.sv"
endpackage
