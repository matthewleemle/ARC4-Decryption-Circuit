`timescale 1ps / 1ps
module tb_task2();


logic clk;
logic [3:0] key;
logic [9:0] sw, ledr;
logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5;

integer i;

task2 task2 (clk, key, sw, hex0, hex1, hex2, hex3, hex4, hex5, ledr);



initial begin

sw = 10'h00033C;




key[3] = 1;
#10;
key[3] = 0;
#10;
key[3] = 1;
#10;


for (i=0;i<1000000000;i++) begin
clk = 1;
#10;
clk = 0;
#10;
end


end


endmodule: tb_task2
