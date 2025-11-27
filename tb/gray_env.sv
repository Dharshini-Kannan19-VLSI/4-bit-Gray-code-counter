class gray_env extends uvm_env;
  `uvm_component_utils(gray_env)

  gray_agent       agt;
  gray_agent_config agt_cfg;
  gray_scoreboard  sb;
  gray_env_cfg     m_cfg;

  function new(string name="gray_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(gray_env_cfg)::get(this, "", "gray_env_cfg", m_cfg))
           `uvm_fatal("GRAY_ENV", "Error in getting env config");

    if(m_cfg.has_gray_agent) begin 
         agt_cfg = gray_agent_config::type_id::create("agt_cfg");
         agt_cfg.is_active = UVM_ACTIVE; 
         uvm_config_db#(gray_agent_config)::set(this,"*","gray_agent_config",agt_cfg); 
         agt = gray_agent::type_id::create("agt",this);
       end
    if(m_cfg.has_gray_scoreboard) 
       begin
         sb = gray_scoreboard::type_id::create("sb",this);
       end 
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(m_cfg.has_gray_scoreboard)
        begin
           agt.mon.ap.connect(sb.ap);
        end
  endfunction
endclass


 
