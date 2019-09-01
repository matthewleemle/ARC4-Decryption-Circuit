module ksa(input logic clk, input logic rst_n,
           input logic en, output logic rdy,
           input logic [23:0] key,
           output logic [7:0] addr, input logic [7:0] rddata, output logic [7:0] wrdata, output logic wren);


           reg [8:0] i;

           reg [3:0] state; // state 1,2 is read s[i], state 3 is compute, write into j, state 4,5 is to read s[j]
                            // state 6 is to swap the values and write s[j] into s[i] // state 7 tmp_si into s[j]
           reg [11:0] j;

           reg [8:0] tmp_si;
           reg [8:0] tmp_sj;

           reg [23:0] key_index;

           reg [23:0] key_index2;
           reg [23:0] sum;


    always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
         i <= 0;
         j <= 0;
         rdy <= 1;
         state <= 4'd1;
         end

    else begin
         if (rdy && en && rst_n) begin //begin rdy (init only ready right after reset),  not during reset and init is requested

           if (i!=9'd256) begin

                if (state == 4'd1) begin
                addr <= i;
                wren <= 0; //read
                state <= 4'd2;
                end

                else if (state == 4'd2) begin
                state <= 4'd3;
                end

                else if(state == 4'd3) begin
                tmp_si <= rddata; //tmp_si contains s[i]
                state <= 4'd4;
                end

                else if (state == 4'd4) begin // start reading s[j]

                key_index = i%3'd3;
                key_index *= 4'd8;
                key_index = 5'd23 - key_index;

                sum = j + tmp_si + key[key_index -: 8];
                j <= sum % 9'd256; // compute new j
                state <= 4'd5;
                end

                else if (state == 4'd5) begin
                addr <= j;
                state <= 4'd6;
                end

                else if (state == 4'd6) begin
                state <= 4'd7;
                end

                else if (state == 4'd7) begin // rddata contains s[j]
                tmp_sj <= rddata;
                state <= 4'd8;
                end

                else if (state == 4'd8) begin
                wrdata <= tmp_si;
                addr <= j;
                wren <= 1;

                state <= 4'd9;
                end

                else if (state == 4'd9) begin
                wrdata <= tmp_sj;
                addr <= i;
                state <= 4'd10;
                end

                else if (state == 4'd10) begin
                i++;
                state <= 4'd1;
                end

          end


      else
                  if (i == 9'd256) begin
                  i <= 0;
                  j <= 0;
                  rdy <= 0; // deassert; end of loop
                  wren <= 1'bz; //stop writing
                  addr <= 8'dz;
                  wrdata <= 8'dz;


                  end





        end // end if (rdy && en &&rst_n)

  end

end //end always


endmodule: ksa
