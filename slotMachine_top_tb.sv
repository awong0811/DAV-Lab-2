`timescale 1ns/1ns

module slotMachine_top_tb(
		output [7:0] lights [0:5],
		output buzzer
);

logic clk;
logic start_stop;
logic reset;

slotMachine_top UUT(
	.clk(clk),
	.reset(reset),
	.start_stop(start_stop),
	.lights(lights),
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
	
	
	//so it's not changing right now, I'm guessing it's because the clk speeds for each clock module is rlly rlly slow...
	//The state has changed, but the slot module output hasn't since it updates based on the divided clk speed. 
	//first change appears at around 10 mil which is half of the period of a 50 Hz signal :)
	//second number changes at 20 mil (25Hz is half of 50Hz so makes sense)
	//my longest one doesn't work...could it be my fsm?
	//either it's my clock divider or 100kHz kills my slot machine lol oh ok I'm a fool lol, it should change
	//at 5000 and 15000. distance between each change is one period, NOT half a period.
	//distance between every positive tick is ALWAYS one period. REMEMBER this for LIFE.
	
	//ok ill write code :(
end

always begin
	#10 clk = ~clk;
end


endmodule