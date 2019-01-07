`include "header.v"

module display_start(
	input wire clk,
	input wire rst,
	input wire [9:0] x_cnt,
	input wire [9:0] y_cnt,

	output reg [3:0] vgaRed,
	output reg [3:0] vgaGreen,
	output reg [3:0] vgaBlue
);

	localparam BLOCK_SIZE = 20; // pixel
	// top-left corner
	localparam SX = 200;
	localparam SY = 40;

	localparam [11:0] BRICK_COLOR[0:9] = {
		12'hACA, //EMPTY
		12'hF00, //I red
		12'h00F, //J blue
		12'hF90, //L orange
		12'hFF0, //O yellow
		12'hF0F, //S magenta
		12'h0FF, //T cyan
		12'h0F0, //Z green
		12'h777, //shadow gray
		12'h720  //filled block brown
	};

	wire [9:0] idx, idy, id, idyy;
	assign idx  = (x_cnt - SX) / BLOCK_SIZE;
	assign idy  = (y_cnt - SY) / BLOCK_SIZE;
	assign idyy = `BOARD_H - idy - 1; // reverse, our y is from bottom to top
	assign id   = idx + idyy * `BOARD_W;

	wire [9:0] x = x_cnt - (SX + idx * BLOCK_SIZE);
	wire [9:0] y = y_cnt - (SY + idy * BLOCK_SIZE);

	always @(*) begin
		{vgaRed, vgaGreen, vgaBlue} = {12'h0}; // TODO:background

		if( SX <= x_cnt && x_cnt < SX+BLOCK_SIZE*`BOARD_W && SY <= y_cnt && y_cnt < SY+BLOCK_SIZE*`BOARD_H) begin
			// reserve some space between two blocks
			if( 3<=x && x<17 && 3<=y && y<17) begin
				{vgaRed, vgaGreen, vgaBlue} = BRICK_COLOR[0];
			end
		end
	end

endmodule

