`include "header.v"

module collision_check(
	input wire[`BOARD_SIZE-1:0] board,
	input wire[`POS_LEN-1:0] pos,
	input wire[`BRICK_LEN-1:0] brick_type,
	output wire is_collide
);

    assign is_collide = 0;
endmodule
