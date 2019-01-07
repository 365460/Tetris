`include "header.v"

module fall(
	input wire clk, // 100MHZ
	input wire rst,
    input wire[`LEVEL_LEN-1:0] level,
	output wire timeout
);

    //wire [33:0] SPEED = level < 10 ? 100_000_000 - level * 10_000_000 : 10_000_000 - (level - 9) * 1_000_000;
    localparam [33:0] SPEED[0:14] = {
		100_000_000,
		 80_000_000,
		 60_000_000,
		 40_000_000,
		 20_000_000,
		  9_000_000,
		  8_000_000,
		  7_000_000,
		  6_000_000,
		  5_000_000,
		  4_000_000,
		  3_000_000,
		  2_000_000,
		  1_000_000,
		  1_000_000
	};

	reg [26:0] cnt, cnt_nx;

	wire rst_1plus;
	oneplus inst_1plus_rst(.pb_debounced(rst), .pb_1pulse(rst_1plus), .clk(clk));

	always @(posedge clk or posedge rst_1plus) begin
		if(rst_1plus) cnt <= 0;
		else cnt <= cnt_nx;
	end

	assign timeout = (cnt >= SPEED[level]);

	always @(*) begin
		if(cnt >= SPEED[level]) begin
			cnt_nx = cnt;
		end
		else begin 
			cnt_nx = cnt + 1;
		end
	end

endmodule
