module tb_Traffic;

logic clk;
logic reset;
logic TAORB;

logic LA_green;
logic LA_yellow;
logic LA_red;
logic LB_green;
logic LB_yellow;
logic LB_red;

Traffic dut(
    .clk(clk),
    .reset(reset),
    .TAORB(TAORB),
    .LA_green(LA_green),
    .LA_yellow(LA_yellow),
    .LA_red(LA_red),
    .LB_green(LB_green),
    .LB_yellow(LB_yellow),
    .LB_red(LB_red)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    TAORB = 1;

    #10 reset = 0;

    #40 TAORB = 0;

    #80 TAORB = 1;

    #100 $stop;
end

endmodule