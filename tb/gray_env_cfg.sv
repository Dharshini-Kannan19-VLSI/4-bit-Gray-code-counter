class gray_env_cfg extends uvm_object;
  `uvm_object_utils(gray_env_cfg)
  
  bit has_gray_agent = 1;
  bit has_gray_scoreboard = 1;
  virtual gray_if vif;
  gray_agent_config agt_cfg;

  function new(string name="gray_env_cfg");
    super.new(name);
  endfunction
  
 

endclass

