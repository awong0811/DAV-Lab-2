module slot_machine(
    input clock,
    input running,
    input reset,
    output logic [3:0] shift_reg
);
	
always_ff @(posedge clock) begin
	 if (!running) begin // not running dont do anything lmao
		  shift_reg = 4'b0100;
	 end
	 if (running) begin // if it is running then we care about everything else
		  if (reset==1'b1) begin
				shift_reg <= 4'b0100; // Initial values: A=0, B=1, C=0, D=0
		  end else begin // reset is not 001 so is not resetting at this very moment
				shift_reg <= {shift_reg[1] ^ shift_reg[0], shift_reg[3:1]};
		  end
	 end
end
endmodule