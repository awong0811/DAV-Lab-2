`timescale 1ns/1ns // time units of 1ns with 1ns precision

module clock_divider_tb(output logic clksignal);
    reg clock = 1'b0;
	 logic [19:0] counter = 20'b0;
	 logic rst = 1'b0;	 
    clock_divider UUT(clock, 20'd1000000, rst, clksignal);	 
	
	 
	 always begin
		#10 clock = ~clock;
	 end
	 
	 initial begin
		#500 rst = 1;
		#500;
		#500 rst = 0;
		#5000 $stop;
	end
	 
endmodule