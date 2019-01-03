`include "header.v"

module fall(
	input wire clk, // 100MHZ
	input wire rst,
    input wire[`LEVEL_LEN-1:0] level,
	output wire timeout
);

	localparam [33:0] SPEED[1:0] = {
		34'd100_000_000, // 1sec
		34'd050_000_000  // 0.5 sec
	};

	reg [33:0] cnt, cnt_nx;

	
	wire rst_1plus;
	oneplus inst_1plus_rst(.pb_debounced(rst), .pb_1pulse(rst_1plus), .clk(clk));

	always @(posedge clk or posedge rst_1plus) begin
		if(rst_1plus) cnt <= 0;
		else cnt <= cnt_nx;
	end

	assign timeout = (cnt == SPEED[level]);

	always @(*) begin
		if(cnt == SPEED[level]) begin
			cnt_nx = cnt;
		end
		else begin 
			cnt_nx = cnt + 1;
		end
	end

endmodule
