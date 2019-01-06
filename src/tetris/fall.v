`include "header.v"

module fall(
	input wire clk, // 100MHZ
	input wire rst,
    input wire[`LEVEL_LEN-1:0] level,
	output wire timeout
);

    wire [26:0] SPEED = level < 10 ? 100_000_000 - level * 10_000_000 : 10_000_000 - (level - 9) * 1_000_000;

	reg [26:0] cnt, cnt_nx;

	wire rst_1plus;
	oneplus inst_1plus_rst(.pb_debounced(rst), .pb_1pulse(rst_1plus), .clk(clk));

	always @(posedge clk or posedge rst_1plus) begin
		if(rst_1plus) cnt <= 0;
		else cnt <= cnt_nx;
	end

	assign timeout = (cnt == SPEED);

	always @(*) begin
		if(cnt == SPEED) begin
			cnt_nx = cnt;
		end
		else begin 
			cnt_nx = cnt + 1;
		end
	end

endmodule
