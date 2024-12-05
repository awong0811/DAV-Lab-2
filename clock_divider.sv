module clock_divider #(base_speed=26'd50000000) (
	input clk,
	input [25:0] speed,
	input reset,
	output logic outClk
);

logic [2:0] shift_reg = 3'b0;
logic[25:0] counter = 26'b0;
logic outClk_d = 1'b0;
logic [25:0] ratio = 26'b0;

always_comb begin
	ratio = base_speed/speed;
	if (shift_reg[2:0]==3'b001) begin
		outClk_d = 0;
	end else if (counter < ratio/2) begin
		outClk_d = 0;
	end else
		outClk_d = 1;
end

always_ff @(posedge clk) begin
	shift_reg <= {shift_reg[1:0], reset};
	if (counter == ratio-1) begin
		counter <= 26'd0;
		outClk <= 1'd0;
	end else if (shift_reg[2:0]==3'b001) begin
		counter <= 26'd0;
		outClk <= 1'd0;
	end else begin
		counter <= counter + 26'd1;
	end
	outClk <= outClk_d;
end
endmodule