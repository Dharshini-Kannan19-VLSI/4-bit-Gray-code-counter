class gray_driver extends uvm_driver #(gray_txn);
  `uvm_component_utils(gray_driver)

  virtual gray_if vif;
  gray_env_cfg m_cfg;

  function new(string name="gray_driver", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

   if(!uvm_config_db#(gray_env_cfg)::get(this, "*", "gray_env_cfg", m_cfg))
      `uvm_fatal("CONFIG","No Configuration set for driver")
   
  endfunction
 
  function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif = m_cfg.vif;
        
        if(vif == null) 
        begin
             `uvm_fatal(get_type_name(), "Virtual interface is null")
        end
  endfunction
  
  task run_phase(uvm_phase phase);
   gray_txn req;

    vif.drv_cb.rst <= 1;
    repeat(2) @(vif.drv_cb);
    vif.drv_cb.rst <= 0;

    forever begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
    end
  endtask
  
  task send_to_dut(gray_txn req);
     @(vif.drv_cb);
     vif.drv_cb.rst  <= req.rst;
     
     if(req.rst) begin
         repeat(2) @(vif.drv_cb);
         vif.drv_cb.rst <= 1'b0;
    end
  endtask
endclass
