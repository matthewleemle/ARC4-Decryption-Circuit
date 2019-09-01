
`timescale 1ps / 1ps


module tb_task1();

logic clk;
logic [3:0] key;
logic [9:0] SW, LEDR;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

task1 task1 (clk, key, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);

integer i;

initial begin

key[3] = 1;
#10;
key[3] = 0;
#10;
key[3] = 1;
#10;

for (i=0; i<300;i++) begin
  clk = 1;
  #10;
  clk = 0;
  #10;
end


assert (task1.rdy==0) $display("Success");
else $error ("rdy still 1");

assert (task1.en==0) $display ("Success");
else $error ("en still 1");

end

endmodule: tb_task1
