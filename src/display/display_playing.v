`include "header.v"

module display_playing(
	input wire[`BOARD_SIZE-1:0] board,
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

	localparam [11:0] BRICK_COLOR[0:7] = {
		12'hACA, //EMPTY
		12'hF00, //I red
		12'h00F, //J blue
		12'hF90, //L orange
		12'hFF0, //O yellow
		12'hF0F, //S magenta
		12'h0FF, //T cyan
		12'h0F0  //Z green
	};

	/*
	*                                      
	*            				         .
	*    22 23  24 	25 	26  27  28  29  30  31  32  33
	*    11 12  13 	14 	15  16  16  17  18  19  20  21 
	*     0  1   2 	 3   4   5   6   7   8   9  10  11
	*/
	wire [9:0] idx, idy, id, idyy;
	assign idx  = (x_cnt - SX) / BLOCK_SIZE;
	assign idy  = (y_cnt - SY) / BLOCK_SIZE;
	assign idyy = `BOARD_H - idy - 1; // reverse, our y is from bottom to top
	assign id   = idx + idyy * `BOARD_W;
	wire [`BRICK_LEN-1:0] block = `GET_BLOCK(board, id);

	wire [9:0] x = x_cnt - (SX + idx * BLOCK_SIZE);
	wire [9:0] y = y_cnt - (SY + idy * BLOCK_SIZE);

	always @(*) begin
		{vgaRed, vgaGreen, vgaBlue} = {12'h0}; // TODO:background

		if( SX <= x_cnt && x_cnt < SX+BLOCK_SIZE*`BOARD_W && SY <= y_cnt && y_cnt < SY+BLOCK_SIZE*`BOARD_H) begin
			// reserve some space between two blocks
			if( 3<=x && x<17 && 3<=y && y<17) {vgaRed, vgaGreen, vgaBlue} = BRICK_COLOR[block];
		end
	end

endmodule

