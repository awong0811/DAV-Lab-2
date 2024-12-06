module slot_machine(
    input clock,
    input running,
    input reset,
    output logic [3:0] shift_reg
);

logic [2:0] reset_shift_reg = 3'b0;

always_ff @(posedge clock) begin
    reset_shift_reg <= {shift_reg[1:0], reset};
    if (reset_shift_reg == 3'b001) begin // reset is 001
        shift_reg <= 4'b0100; // Initial values: A=0, B=1, C=0, D=0
    end else begin // reset is not 001 so is not resetting at this very moment
        shift_reg <= {shift_reg[1] ^ shift_reg[0], shift_reg[3:1]};
    end
end
endmodule