class gray_agent_config extends uvm_object;
  `uvm_object_utils(gray_agent_config)

  uvm_active_passive_enum is_active = UVM_ACTIVE;
  bit has_gray_scoreboard = 1;
  bit has_gray_agent =1; 
  virtual gray_if vif= null;

  function new(string name="gray_agent_config");
    super.new(name);
  endfunction
endclass