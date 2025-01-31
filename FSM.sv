module FSM (
	input logic clk,
	input logic reset,
	input logic start_stop,
	output [7:0] disp1 [0:1],
	output [7:0] disp2 [0:1],
	output [7:0] disp3 [0:1],
	output logic buzzer
);

logic [2:0] shift_reg = 3'b0;
logic [2:0] shift_start_stop = 3'b0;
logic [3:0] numbers [0:2];// = '{4'b0,4'b0,4'b0};
logic running;
assign running = current_state==RUN;

logic clksignal1;// = 0;
logic clksignal2;// = 0;
logic clksignal3;// = 0;
logic clksignal4;
clock_divider UUT1(clk, 26'd1, ~reset, clksignal1);
clock_divider UUT2(clk, 26'd5, ~reset, clksignal2);
clock_divider UUT3(clk, 26'd9, ~reset, clksignal3);
clock_divider UUT10(clk, 26'd10000, ~reset, clksignal4);

logic rst_slots;
assign rst_slots = (current_state == SET);
slot_machine UUT7(clksignal1, running, rst_slots, numbers[0]); // in case this is wrong first param used to be clk
slot_machine UUT8(clksignal2, running, rst_slots, numbers[1]);
slot_machine UUT9(clksignal3, running, rst_slots, numbers[2]);

seven_segment_display UUT4(numbers[0], disp1);
seven_segment_display UUT5(numbers[1], disp2);
seven_segment_display UUT6(numbers[2], disp3);

typedef enum logic [1:0] {
	SET = 2'b00,
	RUN = 2'b01,
	STOP = 2'b10,
	WIN = 2'b11
} state_t;

state_t current_state=SET;
state_t next_state=SET;

always_ff @(posedge clk) begin
	shift_reg <= {shift_reg[1:0], ~reset};
	shift_start_stop <= {shift_start_stop[1:0], ~start_stop};
	current_state <= next_state;
//	if (current_state==RUN) begin
//		running <= 1'b1;
//		rst_slots <= 1'b0; // added
//	end
//	else
//		running <= 1'b0;
//	if (current_state==SET)
//		rst_slots <= 1'b1;
end

always_comb begin
	next_state = current_state;
	case (current_state)
		SET: begin
			if (shift_start_stop==3'b001 && shift_reg!=3'b001)
				next_state = RUN;
			else
				next_state = SET;
		end
		RUN: begin
			if (shift_start_stop==3'b001 && shift_reg!=3'b001)
				next_state = STOP;
			else if (shift_start_stop!=3'b001 && shift_reg==3'b001)
				next_state = SET;
			else
				next_state = RUN;
		end
		STOP: begin
			if (numbers[0] == numbers[1] && numbers[0] == numbers[2] && numbers[1]==numbers[2])
				next_state = WIN;
			else if (shift_reg==3'b001)
				next_state = SET;
			else
				next_state = STOP;
		end
		WIN: begin
			if (shift_reg==3'b001)
				next_state = SET;
		end
	endcase
end
assign buzzer = (current_state == 2'b11) ? clksignal4 : 1'b0;
endmodule