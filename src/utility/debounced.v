
module debounced(pb_debounced, pb, clk);
	output pb_debounced;
	input pb;
	input clk;

	reg [3:0] DFF, next_DFF;
	always @(posedge clk) begin
		DFF = next_DFF;
	end

	always @* begin
		next_DFF[3] = DFF[2];
		next_DFF[2] = DFF[1];
		next_DFF[1] = DFF[0];
		next_DFF[0] = pb;
	end
	assign pb_debounced = ((DFF==4'b1111)? 1'b1:1'b0);
endmodule
