module tb_init();


logic clk, rst_n, en, rdy, wren;
logic [7:0] addr, wrdata;

init init (clk, rst_n, en, rdy, addr, wrdata, wren);

integer j = 0;



initial begin

en = 0;
rst_n = 1;
#10;

rst_n = 0;
#10;
assert (init.i == 0) $display ("Success");
else $error ("wrong i initial");

rst_n = 1;
#10;



en = 1;
clk = 0;
#10;
clk = 1;
#10;

for (j=0; j<256;j++) begin
  assert(init.i == (j+1) ) $display("Success");
  else $error ("Wrong i, i is %d ", init.i);
  assert(wrdata == j) $display ("Success");
  else $error ("Wrong i for wrdata ");
  assert (addr == j) $display ("Success");
  else $error ("wrong addr");
  assert(wren == 1) $display ("Success");
  else $error ("wren not 1");
  clk = 0;
  #10;
  clk = 1;
  #10;
end

assert (wren == 0) $display ("Success");
else  $error ("wren is not 0 in the end");

assert (rdy == 0) $display ("Success");
else $error ("rdy is not 0 in the end");


end


endmodule: tb_init
