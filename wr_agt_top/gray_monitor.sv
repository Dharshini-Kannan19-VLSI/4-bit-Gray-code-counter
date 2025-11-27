class gray_monitor extends uvm_component;
  `uvm_component_utils(gray_monitor)
 
  virtual gray_if vif;
  gray_env_cfg m_cfg;
  uvm_analysis_port #(gray_txn) ap;

  function new(string name="gray_monitor", uvm_component parent=null);
    super.new(name,parent);
    ap = new("ap",this);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);

    if(!uvm_config_db#(gray_env_cfg)::get(this, "*", "gray_env_cfg", m_cfg))
      `uvm_fatal("CONFIG","No Configuration set for monitor")
  endfunction
  
  function void connect_phase(uvm_phase phase);
           vif = m_cfg.vif;
           if(vif == null) begin
            `uvm_fatal(get_type_name(), "Virtual interface is null")
           end
  endfunction

  task run_phase(uvm_phase phase);
    gray_txn tx;
    forever begin
          @(vif.mon_cb);
        if(!vif.mon_cb.rst)
         begin
          tx = gray_txn::type_id::create("tx");
          tx.rst=vif.mon_cb.rst;
          @(vif.mon_cb);
          tx.gray_count = vif.mon_cb.gray_count; 
            @(vif.mon_cb);
          ap.write(tx);
         end
    end
  endtask
endclass