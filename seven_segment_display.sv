module seven_segment_display(
	input [3:0] num_in,
	output logic [7:0] disp [0:1]
); //14 means 7 segments for each display. lower half is for lower digit.

//this is all combinational
logic [3:0] dig1 = 4'b0;
logic [3:0] dig2 = 4'b0;
 

always_comb begin
	dig1 = num_in % 4'd10;
	dig2 = num_in / 4'd10;
	
	//now we have all the digits, just need to extract now.
	case(dig1)
		4'b0000: begin
			disp[0] = 8'b11000000;
		end
		4'b0001: begin
			disp[0] = 8'b11111001;
		end
		4'b0010: begin
			disp[0] = 8'b10100100;
		end
		4'b0011: begin
			disp[0] = 8'b10110000;
		end
		4'b0100: begin
			disp[0] = 8'b10011001;
		end
		4'b0101: begin
			disp[0] = 8'b10010010;
		end
		4'b0110: begin
			disp[0] = 8'b10000010;
		end
		4'b0111: begin
			disp[0] = 8'b11111000;
		end
		4'b1000: begin
			disp[0] = 8'b10000000;
		end
		4'b1001: begin
			disp[0] = 8'b10011000;
		end
		default: begin 
			disp[0] = 8'b10000110;
			//maybe have it output E lol
		end
	endcase
	
	case(dig2)
		4'b0000: begin
			disp[1] = 8'b11000000;
		end
		4'b0001: begin
			disp[1] = 8'b11111001;
		end
		4'b0010: begin
			disp[1] = 8'b10100100;
		end
		4'b0011: begin
			disp[1] = 8'b10110000;
		end
		4'b0100: begin
			disp[1] = 8'b10011001;
		end
		4'b0101: begin
			disp[1] = 8'b10010010;
		end
		4'b0110: begin
			disp[1] = 8'b10000010;
		end
		4'b0111: begin
			disp[1] = 8'b11111000;
		end
		4'b1000: begin
			disp[1] = 8'b10000000;
		end
		4'b1001: begin
			disp[1] = 8'b10011000;
		end
		default: begin 
			disp[1] = 8'b10000110;
			//maybe have it output E lol
		end
	endcase
			
end

endmodule