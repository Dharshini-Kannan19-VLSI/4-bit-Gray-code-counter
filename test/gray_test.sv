class gray_test_base extends uvm_test;
  `uvm_component_utils(gray_test_base)

  gray_env env;
  gray_env_cfg m_cfg;

  int has_gray_agent = 1;
  int no_of_gray_agent=1;
  int has_gray_scoreboard = 1;
  
  function new(string name="gray_test_base", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_cfg = gray_env_cfg::type_id::create("m_cfg");
    if(!uvm_config_db#(virtual gray_if)::get(this,"","vif",m_cfg.vif))
       `uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db")
  
    uvm_config_db#(gray_env_cfg)::set(this, "*", "gray_env_cfg", m_cfg);
    env = gray_env::type_id::create("env",this);

    m_cfg.has_gray_agent = 1;
    m_cfg.has_gray_scoreboard = 1;

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
  endfunction
endclass

class gray_test extends gray_test_base;
  `uvm_component_utils(gray_test)
 
  function new(string name="gray_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    gray_seq seq;
    phase.raise_objection(this);
     begin
        seq = gray_seq::type_id::create("seq");
        seq.start(env.agt.seqr);
        #100;
     end
    phase.drop_objection(this);
  endtask

endclass
