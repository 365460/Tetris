`include "header.v"

module display_playing(
	input wire clk,
	input wire rst,

	input wire[`BOARD_SIZE-1:0] board,
	input wire[`BRICK_LEN-1:0] cur_brick_type,
	input wire[`BRICK_POS_LEN-1:0] cur_brick_pos,
	input wire[`BRICK_POS_LEN-1:0] shadow_brick_pos,
	input wire[`LEVEL_LEN-1:0] level,
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

	reg [`BRICK_LEN-1:0] block_color_id;

	wire [9:0] x = x_cnt - (SX + idx * BLOCK_SIZE);
	wire [9:0] y = y_cnt - (SY + idy * BLOCK_SIZE);


	wire [`POS_LEN-1:0] pos0, pos1, pos2, pos3;
	wire [`POS_LEN-1:0] spos0, spos1, spos2, spos3;

	assign pos0 = `BRICK_GET_POS(cur_brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(cur_brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(cur_brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(cur_brick_pos, 3);

	assign spos0 = `BRICK_GET_POS(shadow_brick_pos, 0);
	assign spos1 = `BRICK_GET_POS(shadow_brick_pos, 1);
	assign spos2 = `BRICK_GET_POS(shadow_brick_pos, 2);
	assign spos3 = `BRICK_GET_POS(shadow_brick_pos, 3);

	// pick color
	always @(*) begin
		if( id == `POS2ID(pos0) || id == `POS2ID(pos1) || id == `POS2ID(pos2) || id == `POS2ID(pos3) ) block_color_id = cur_brick_type;
		else if( id == `POS2ID(spos0) || id == `POS2ID(spos1) || id == `POS2ID(spos2) || id == `POS2ID(spos3) ) block_color_id = 8;
		else if( `GET_BLOCK_FILL(board, id) == 1) block_color_id = 9;
		else block_color_id = 0;
	end

	reg [4:0] index, index_nx;
	reg [33:0] cnt, cnt_nx;

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			cnt = 0;
			index = 0;
		end
		else begin
			cnt = cnt_nx;
			index = index_nx;
		end
	end

    localparam [33:0] SPEED[0:14] = {
		100_000_00*5,
		 90_000_00*5,
		 80_000_00*5,
		 70_000_00*5,
		 60_000_00*5,
		 50_000_00*5,
		 40_000_00*5,
		 30_000_00*5,
		 20_000_00*5,
		 10_000_00*5,
		  9_000_00*5,
		  8_000_00*5,
		  7_000_00*5,
		  6_000_00*5,
		  5_000_00*5
	};

	always @(*) begin
		index_nx = index;
		if(cnt >= SPEED[level]) begin
			cnt_nx = 0;
			if(index == 6) index_nx = 0;
			else index_nx = index + 1;
		end 
		else cnt_nx = cnt + 1;
	end

	always @(*) begin
		{vgaRed, vgaGreen, vgaBlue} = {12'h0}; // TODO:background

		if( SX <= x_cnt && x_cnt < SX+BLOCK_SIZE*`BOARD_W && SY <= y_cnt && y_cnt < SY+BLOCK_SIZE*`BOARD_H) begin
			// reserve some space between two blocks
			if( 3<=x && x<17 && 3<=y && y<17) begin
				if(block_color_id == 9) begin
					{vgaRed, vgaGreen, vgaBlue} = BRICK_COLOR[1 + (index + (y-3)/2) % 7];
				end
				else {vgaRed, vgaGreen, vgaBlue} = BRICK_COLOR[block_color_id];
			end
		end
	end

endmodule

