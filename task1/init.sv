module init(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            output logic [7:0] addr, output logic [7:0] wrdata, output logic wren);


logic [9:0] i;


always @(posedge clk or negedge rst_n) begin



if (!rst_n) begin
i = 0;
rdy = 1;
end

else begin

if (rdy && en && rst_n) begin //begin rdy (init only ready right after reset),  not during reset and init is requested


if (i != 10'd256) begin //begin cond
addr = i;
wrdata = i;
wren = 1;
end //end i!= 8'd256

else if (i==10'd256) begin

rdy = 0;
wren = 1'bz;
wrdata = 8'dz;
addr = 8'dz;

end // deassert rdy in the end

i += 1;

end // end if (rdy && en &&rst_n)


end


end




endmodule: init
