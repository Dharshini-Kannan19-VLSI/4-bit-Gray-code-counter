class gray_sequencer extends uvm_sequencer #(gray_txn);
  `uvm_component_utils(gray_sequencer)

  function new(string name="gray_sequencer", uvm_component parent=null);
    super.new(name,parent);
  endfunction
endclass