`timescale 1ns/1ns

module slotMachine_top_tb(
		output [7:0] disp1 [0:1],
		output [7:0] disp2 [0:1],
		output [7:0] disp3 [0:1],
		output buzzer
);

logic clk;
logic start_stop;
logic reset;

FSM UUT(
	.clk(clk),
	.reset(reset),
	.start_stop(start_stop),
	.disp1(disp1),
	.disp2(disp2),
	.disp3(disp3),
	.buzzer(buzzer)
);

initial begin
	clk = 1'b0;
	reset = 1'b0;
	start_stop = 1'b0;
	#15 //it's in set so lights should all be equal (seed value). Set looks good.
	start_stop = 1'b1; 
	#20 //regardless of how long it's high, 01 should only be read once so only 1 state change. 
	
	start_stop = 1'b0; //recall stop is only read when start_stop is 01.
	#150000; //so now it should be in run? so lights should be switching a lot. 
	//see when to stop for a win scenario...
	start_stop = 1'b1;
	#20;
	start_stop = 1'b0;
	#5000; //so now it's in win so buzzer should be clk signal
	start_stop = 1'b1;
	#20;
	start_stop = 1'b0;
	#2000; //to show start/stop does nothing in win state
	reset = 1'b1;
	#20;
	reset = 1'b0;
	#2000;
	start_stop = 1'b1;
	#20;
	start_stop = 1'b0;
	#5000;
	reset = 1'b1;
	#20;
	reset = 1'b0;
	#2000; //to go from set to run and back to set
	
	//takes 170,000 ns.
	start_stop = 1'b1;
	#20;
	start_stop = 1'b0;
	#5000;
	start_stop = 1'b1;
	#20;
	start_stop = 1'b0;
	#5000;
	reset = 1'b1;
	#20;
	reset = 1'b0;
	#2000; //to go from set to run to stop to reset.
	//takes 183,000 ns.
	
end

//always begin
	//#100 start_stop = ~start_stop;
	//#1000 reset = ~reset;
//end

always begin
	#10 clk = ~clk;
end


endmodule