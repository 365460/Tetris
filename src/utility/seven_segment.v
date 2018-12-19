
module seven_segment(DISPLAY, DIGIT, clk, dig1, dig2, dig3, dig4);
	output [6:0] DISPLAY;
	output [3:0] DIGIT;
	input clk;
	input [3:0] dig1; 
	input [3:0] dig2;
	input [3:0] dig3;
	input [3:0] dig4;

	reg [4:0] value, next_value;
	reg [3:0] DIGIT, next_DIGIT;
	reg [6:0] DISPLAY;

	always @(posedge clk) begin
		DIGIT = next_DIGIT;
		value = next_value;
	end

	always @(*) begin
		case(DIGIT)
			4'b1110: begin
				next_value = dig2;
				next_DIGIT = 4'B1101;
			end
			4'b1101: begin
				next_value = dig3;
				next_DIGIT = 4'B1011;
			end
			4'b1011: begin
				next_value = dig4;
				next_DIGIT = 4'B0111;
			end
			4'b0111: begin
				next_value = dig1;
				next_DIGIT = 4'B1110;
			end
			default: begin
				next_value = dig1;
				next_DIGIT = 4'B1110;
			end
		endcase
	end

	always @(*) begin
		case(value)
			5'd0: DISPLAY = 7'b1000000;
			5'd1: DISPLAY = 7'b1111001;
			5'd2: DISPLAY = 7'b0100100;
			5'd3: DISPLAY = 7'b0110000;
			5'd4: DISPLAY = 7'b0011001;
			5'd5: DISPLAY = 7'b0010010;
			5'd6: DISPLAY = 7'b0000010;
			5'd7: DISPLAY = 7'b1111000;
			5'd8: DISPLAY = 7'b0000000;
			5'd9: DISPLAY = 7'b0010000;
			//`DASH_CODE:  DISPLAY = 7'b0111111;
			//`EMPTY_CODE:     DISPLAY = 7'b1111111;
			//`UP1_CODE:       DISPLAY = 7'b1011100;  // up
			//`UP2_CODE:       DISPLAY = 7'b0101011;   // down
			//`UNDERLINE_CODE: DISPLAY = 7'b1110111;
			//`DOWN1_CODE:     DISPLAY = 7'b0011101;  // up
			//`DOWN2_CODE:     DISPLAY = 7'b1100011;  // down
			default: DISPLAY = 7'b1111111;
		endcase
	end
endmodule
