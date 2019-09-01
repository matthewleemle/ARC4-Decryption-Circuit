module tb_ksa();

logic clk, rst_n, en, rdy, wren;
logic [23:0] key;
logic [7:0] addr, rddata, wrdata;

integer i;
integer j;
integer tmp_si;


reg [7:0] s [255:0];



ksa ksa(clk, rst_n, en, rdy, key, addr, rddata, wrdata, wren);



initial begin

$readmemh("hex1.mem", s);


key[9:0] = 10'h00033C;

j = 0;

rst_n = 1;
#10;
rst_n = 0;
#10;
rst_n = 1;
en = 1;
#10;

for (i = 0; i<256; i++) begin

j = j + s[i] + key[i%2'd3] % 9'd256;

clk = 0;
#10;
clk = 1;
#10; // state 1

clk = 0;
#10;
clk = 1;
#10; // state 2

clk = 0;
#10;
clk = 1;
#10; // state 3

clk = 0;
#10;
clk = 1;
#10; // state 4

clk = 0;
#10;
clk = 1;
#10; // state 5

clk = 0;
#10;
clk = 1;
#10; // state 6


assert (ksa.wrdata == s[j]) $display ("Success");
else $error ("wrong wrdata");

assert (addr == i ) $display ("Success");
else $error ("wrong i addr");


clk = 0;
#10;
clk = 1;
#10; // state 7

assert (ksa.wrdata == s[i]) $display ("Success");
else $error ("wrong wrdata");

assert (addr == j ) $display ("Success");
else $error ("wrong j addr");


// swap values of s[i] and s[j]
tmp_si = s[i];
s[i] = s[j];
s[j] = tmp_si;

end


end








endmodule: tb_ksa


/* j = 0
for i = 0 to 255:
    j = (j + s[i] + key[i mod keylength]) mod 256   -- for us, keylength is 3
    swap values of s[i] and s[j] */
