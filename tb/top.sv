module top;
  import uvm_pkg::*;
  import gray_pkg::*;

  logic clk;
  initial clk = 0;
  always #5 clk = ~clk;
  
  gray_if vif(clk);  

  gray_counter dut (.clk(clk),
                    .rst(vif.rst),
                    .gray_count(vif.gray_count)
                   );

  initial begin
    // set interface into config DB
    uvm_config_db#(virtual gray_if)::set(null,"*","vif",vif);
    run_test();
  end
endmodule
