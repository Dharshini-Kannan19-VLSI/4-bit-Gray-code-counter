class gray_txn extends uvm_sequence_item;
   `uvm_object_utils(gray_txn)
    rand bit rst;
    bit [3:0] gray_count;

    function new(string name="gray_txn");
        super.new(name);
    endfunction

endclass