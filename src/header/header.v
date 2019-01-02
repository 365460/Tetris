`ifndef HEADER_H
`define HEADER_H

	/* FSM */
	`define STATE_LEN 3
	`define START   `STATE_LEN'd0
	`define PLAYING `STATE_LEN'd1

	/* Brick */
	`define BRICK_LEN 4
	`define BRICK_I `BRICK_LEN'd1
	`define BRICK_J `BRICK_LEN'd2
	`define BRICK_L `BRICK_LEN'd3
	`define BRICK_O `BRICK_LEN'd4
	`define BRICK_S `BRICK_LEN'd5
	`define BRICK_T `BRICK_LEN'd6
	`define BRICK_Z `BRICK_LEN'd7
	`define BRICK_SHADOW `BRICK_LEN'd8

	`define DIR_LEN 2

	/* board size */
	`define BOARD_H 20
	`define BOARD_W 12 // TOTAL BOARD_H * BOARD_W blocks in board
	// total bits = bits for each block to store brick_type + one bit for each block to represent if it is filled
	`define BOARD_SIZE (`BOARD_H * `BOARD_W )

	//`define GET_BLOCK_TYPE(board, id) 	   board[id * `BRICK_LEN +: `BRICK_LEN]
	//`define SET_BLOCK_TYPE(board, id, val) board[id * `BRICK_LEN +: `BRICK_LEN] = val
	`define GET_BLOCK_FILL(board, id)      board[id]
	`define SET_BLOCK_FILL(board, id, val) board[id] = val
	`define IS_ALL_BLOCK_FREE(board, id0, id1, id2, id3) \
		((`GET_BLOCK_FILL(board, id0)==0) && (`GET_BLOCK_FILL(board, id1)==0) && (`GET_BLOCK_FILL(board, id2)==0) && (`GET_BLOCK_FILL(board, id3)==0))
	// return BOARD_W bits
	`define GET_ROW_FILL(board,  row)      board[row * `BOARD_W +: `BOARD_W]
	`define PLACE_BLOCKS_TO_BOARD(board, id0, id1, id2, id3, val) `SET_BLOCK_FILL(board, id0, 1); \
																	 `SET_BLOCK_FILL(board, id1, 1); \
																	 `SET_BLOCK_FILL(board, id2, 1); \
																	 `SET_BLOCK_FILL(board, id3, 1); 

	/* 2D coordinate (x,y) */
	`define POS_LEN 10 // wire [9:0] pos = 10'b_y(5 bits)_x(5 bits)
	`define GETX(pos) pos[0 +:5]
	`define GETY(pos) pos[5 +:5]
	`define SETX(pos, val) pos[0 +:5] = val
	`define SETY(pos, val) pos[5 +:5] = val
	`define MAKE_POS(x, y) ( (y << (`POS_LEN>>1)) | x )
	`define POS2ID(pos) (`GETY(pos)*`BOARD_W + `GETX(pos))
	//`define POS2EXP(pos) `POS2ID(pos)*`BRICK_LEN +: `BRICK_LEN                   // get brick type from the board.  decrepit!
	`define IS_VALID_POS(pos) (`GETX(pos) < `BOARD_W && `GETY(pos) < `BOARD_H)

	/* A structure to store the blocks of bricks. Each type of bricks has four blocks */
	`define BRICK_POS_LEN `POS_LEN*4
	`define BRICK_GET_POS(POSs, id) 	 POSs[id*`POS_LEN +: `POS_LEN] // id from 0 to 3
	`define BRICK_SET_POS(POSs, id, val) POSs[id*`POS_LEN +: `POS_LEN] = val

	`define NEW_BLOCK_POS `MAKE_POS(6, 18)

	/* Keyboard */
	`define KEY_PRESS_LEN 7
	`define KEY_UP      0
	`define KEY_DOWN    1
	`define KEY_LEFT    2
	`define KEY_RIGHT   3
	`define KEY_SPACE   4
	`define KEY_RIGHT_1 5
	`define KEY_RIGHT_3 6

	`define KEY_UP_CODE    9'b0_0111_0101 // right_8 => 75
	`define KEY_DOWN_CODE  9'b0_0111_0010 // E072
	`define KEY_LEFT_CODE  9'b0_0110_1011 // E06B
	`define KEY_RIGHT_CODE 9'b1_0111_0100 // E074 v
	`define KEY_SPACE_CODE 9'b0_0010_1001 // 29   v
	`define KEY_RIGHT_1_CODE 9'b0_0110_1001 // right_1 => 69
	`define KEY_RIGHT_3_CODE 9'b0_0111_1010 // right_3 => 7A

`endif
