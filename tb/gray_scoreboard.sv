class gray_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(gray_scoreboard)

  uvm_analysis_imp #(gray_txn,gray_scoreboard) ap;
  
  bit[3:0] bin_count;
  bit[3:0] exp_gray;
  
  covergroup cg_gray;
      option.per_instance = 1;

      // Coverpoint for expected Gray code
      cp_gray_count : coverpoint bin_count {
             bins e_val1 = {[0:1]}; // all possible 4-bit Gray codes
             bins e_val2 = {[2:3]};
             bins e_val3 = {[4:5]};
             bins e_val4 = {[6:7]};
             bins e_val5 = {[8:9]};
             bins e_val6 = {[10:11]};
             bins e_val7 = {[12:13]};
             bins e_val8 = {[14:15]};
            }

      // Coverpoint for actual Gray code from DUT
      cp_bin_count : coverpoint exp_gray {
             bins a_val1 = {[0:1]};
             bins a_val2 = {[2:3]};
             bins a_val3 = {[4:5]};
             bins a_val4 = {[6:7]};
             bins a_val5 = {[8:9]};
             bins a_val6 = {[10:11]};
             bins a_val7 = {[12:13]};
             bins a_val8 = {[14:15]};
            }

  

      // Cross coverage to track matched pairs
      cross cp_gray_count, cp_bin_count;

  endgroup

  function new(string name="gray_scoreboard", uvm_component parent=null);
    super.new(name,parent);
    ap = new("ap",this);
    bin_count = 0;
    cg_gray = new();
  endfunction
  
  virtual function void write(gray_txn tx);
      check_gray_code(tx);
  endfunction

  function void check_gray_code(gray_txn tx);
   bit[3:0] bin_count;
   bit[3:0] exp_gray;

    if(tx.rst)
      begin
         bin_count = 0;
      end
    else
      begin
         bin_count++;
         exp_gray={ bin_count[3],
                    bin_count[3]^bin_count[2],
                    bin_count[2]^bin_count[1],
                    bin_count[1]^bin_count[0] };
         
         cg_gray.sample();
         if(exp_gray!=tx.gray_count)
           `uvm_error("SB",$sformatf("Mismatch expected=%0d got=%0d",exp_gray,tx.gray_count))
         else
           `uvm_info("SB",$sformatf("Matched:expected=%0d got=%0d",exp_gray,tx.gray_count),UVM_LOW)
      end
  endfunction
endclass