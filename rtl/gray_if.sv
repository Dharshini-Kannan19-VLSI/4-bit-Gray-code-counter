interface gray_if(input logic clk);
  logic rst;
  logic [3:0] gray_count;

  clocking drv_cb @(posedge clk);
      output rst;
      input gray_count;
  endclocking

  clocking mon_cb @(posedge clk);
      input rst;
      input gray_count;
  endclocking

   modport DRV_MP (clocking drv_cb);

   modport MON_MP (clocking mon_cb);



//assertions

/*
property p_reset;
  @(posedge clk)|->(gray_count==4'b0000);
endproperty

assert property(p_reset) else
   $error("gray_counter:reset failed ,gray_count!=0);

*/


endinterface



