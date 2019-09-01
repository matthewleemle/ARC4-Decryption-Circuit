module task2(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

        logic [23:0] key;
        logic [7:0] address, data, q;
        logic wren, rdy_init, en_init, en_ksa, rdy_ksa;
        logic init_started, ksa_started;

        logic [7:0] init_addr, init_data, ksa_addr, ksa_data;
        logic init_wren, ksa_wren;

        s_mem s(address, CLOCK_50, data, wren, q);

        init init (CLOCK_50, KEY[3], en_init, rdy_init, address, data, wren);

        ksa ksa(CLOCK_50, KEY[3], en_ksa, rdy_ksa, key, address, q, data, wren);

        assign key[23:10] = 0;
        assign key[9:0] = SW[9:0];

  always @(posedge CLOCK_50 or negedge KEY[3]) begin


    if (!KEY[3]) begin
    init_started = 0;
    ksa_started = 0;
    en_init = 0;
    en_ksa = 0;
    end

    else begin

    if (rdy_init == 1 && init_started == 0) begin
    en_init = 1;
    init_started = 1;
    end


    else if (init_started == 1 && rdy_ksa == 1 && rdy_init == 0) begin
     en_init = 0;
     en_ksa = 1;
     ksa_started = 1;
   end


    else if (ksa_started == 1 && rdy_ksa == 0) begin
     en_ksa = 0;
   end

end

end


    // your code here

endmodule: task2
