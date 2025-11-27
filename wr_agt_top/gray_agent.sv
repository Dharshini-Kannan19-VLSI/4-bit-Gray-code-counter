class gray_agent extends uvm_agent;
  `uvm_component_utils(gray_agent)

  gray_driver drv;
  gray_monitor mon;
  gray_sequencer seqr;
  gray_agent_config agt_cfg;

  function new(string name="gray_agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(gray_agent_config)::get(this,"","gray_agent_config",agt_cfg))
      `uvm_fatal("NOCFG","Agent config not found")

    mon  = gray_monitor::type_id::create("mon",this);
    if (agt_cfg.is_active == UVM_ACTIVE) begin
      drv  = gray_driver::type_id::create("drv",this);
      seqr = gray_sequencer::type_id::create("seqr",this);
    end
  endfunction
 
  function void connect_phase(uvm_phase phase);
     if (agt_cfg.is_active == UVM_ACTIVE)
          begin
            drv.seq_item_port.connect(seqr.seq_item_export);
          end
    endfunction

endclass