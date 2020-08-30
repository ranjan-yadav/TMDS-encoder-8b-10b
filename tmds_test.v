module tmds_test;

reg disp_ena;
reg [1:0]control;
reg [7:0]d_in;
reg clk;
wire [9:0]q_out;

tmds_encoder dut(disp_ena,control,d_in,clk,q_out);

initial
clk = 1'b0;
always
#50 clk = ~clk;

initial
begin
disp_ena=1'b0;
control=2'b11;
d_in=8'b01010101;

#100;
disp_ena=1'b1;
control=2'b01;
d_in=8'b11001100;

#100;
disp_ena=1'b1;
control=2'b11;
d_in=8'b11001100;

#100;
disp_ena=1'b1;
control=2'b00;
d_in=8'b11001100;

#100;
disp_ena=1'b1;
control=2'b10;
d_in=8'b11001100;

end

initial
#500 $finish;
endmodule
