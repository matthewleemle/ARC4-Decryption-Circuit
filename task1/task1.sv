module task1(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

    // your code here


    logic [7:0] address, data, q;
    logic wren, en;
    logic init_started = 0;
	 logic rdy = 0;

    s_mem s(address, CLOCK_50, data, wren, q);

    init init (CLOCK_50, KEY[3], en, rdy, address, data, wren);


    always @(posedge CLOCK_50 or negedge KEY[3]) begin

    if (!KEY[3]) begin
    en = 0;
    end

    else begin

    if (rdy == 1) begin
    en = 1;
    init_started = 1;
    end

    else if (rdy == 0 && init_started == 1) begin
    en = 0;
    end

    end



    end


endmodule: task1
