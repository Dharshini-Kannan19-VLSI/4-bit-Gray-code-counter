class gray_seq_base extends uvm_sequence #(gray_txn);
  `uvm_object_utils(gray_seq_base)

  function new(string name="gray_seq_base");
    super.new(name);
  endfunction

endclass

class gray_seq extends gray_seq_base;
  `uvm_object_utils(gray_seq)

  function new(string name="gray_seq");
    super.new(name);
  endfunction
  
  task body();
    gray_txn req;
    repeat(16) begin
      req = gray_txn::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask
endclass
