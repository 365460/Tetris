`include "header.v"

module collision_check(
	input wire[`BOARD_SIZE-1:0] board,
	input wire[`POS_LEN-1:0] pos,
	input wire[`BRICK_LEN-1:0] brick_type,
	input wire[`DIR_LEN-1:0] dir,
	output wire is_collided
);

	wire [`POS_LEN-1:0] pos1, pos2, pos3, pos0;
	wire [`BRICK_POS_LEN-1:0] brick_pos;

	brick inst_b(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(pos),
		.brick_pos(brick_pos)
	);

	assign pos0 = `BRICK_GET_POS(brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(brick_pos, 3);

	wire valid_pos;
	assign valid_pos = `IS_VALID_POS(pos0) && `IS_VALID_POS(pos1) && `IS_VALID_POS(pos2) && `IS_VALID_POS(pos3);
	assign is_collided = !(valid_pos && (board[`POS2EXP(pos0)]==0) && (board[`POS2EXP(pos1)]==0) 
						&& (board[`POS2EXP(pos2)]==0) && (board[`POS2EXP(pos3)]==0));
endmodule
