`timescale 1ns/1ns // time units of 1ns with 1ns precision

module clock_divider_tb(output logic clksignal);
    reg clock;
	 logic [19:0] counter;
	 logic rst;
	 
    clock_divider UUT(clock, 20'd10000000, rst, clksignal);	 
	 
    initial begin
		clock = 0;
		counter = 0;
		rst = 0;
    end
	 
	 always begin
		#5 clock = ~clock;
	 end
	 
	 initial begin
		#100 rst = 1;
		#5000 $stop;
	end
	 
endmodule