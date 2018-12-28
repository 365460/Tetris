// This code assumes that `BOARD_H = 20
`include "header.v"

module drop(
	input wire[`BOARD_SIZE-1:0] cur_board,
	input wire[`POS_LEN-1:0] pos,
	input wire[`BRICK_LEN-1:0] brick_type,
	input wire[`DIR_LEN-1:0] dir,
	output wire[`POS_LEN-1:0] new_pos
);

	wire [`BRICK_POS_LEN-1:0] brick_pos;

	brick inst_b0(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(pos),
		.brick_pos(brick_pos)
	);

	wire [`POS_LEN-1:0] pos0 = `BRICK_GET_POS(brick_pos, 0);
	wire [`POS_LEN-1:0] pos1 = `BRICK_GET_POS(brick_pos, 1);
	wire [`POS_LEN-1:0] pos2 = `BRICK_GET_POS(brick_pos, 2);
	wire [`POS_LEN-1:0] pos3 = `BRICK_GET_POS(brick_pos, 3);

	wire [`POS_LEN-1:0] pos0_1 = pos0  -  1 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_1 = pos1  -  1 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_1 = pos2  -  1 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_1 = pos3  -  1 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_2 = pos0  -  2 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_2 = pos1  -  2 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_2 = pos2  -  2 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_2 = pos3  -  2 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_3 = pos0  -  3 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_3 = pos1  -  3 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_3 = pos2  -  3 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_3 = pos3  -  3 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_4 = pos0  -  4 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_4 = pos1  -  4 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_4 = pos2  -  4 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_4 = pos3  -  4 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_5 = pos0  -  5 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_5 = pos1  -  5 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_5 = pos2  -  5 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_5 = pos3  -  5 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_6 = pos0  -  6 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_6 = pos1  -  6 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_6 = pos2  -  6 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_6 = pos3  -  6 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_7 = pos0  -  7 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_7 = pos1  -  7 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_7 = pos2  -  7 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_7 = pos3  -  7 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_8 = pos0  -  8 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_8 = pos1  -  8 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_8 = pos2  -  8 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_8 = pos3  -  8 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_9 = pos0  -  9 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_9 = pos1  -  9 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_9 = pos2  -  9 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_9 = pos3  -  9 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_10 = pos0 - 10 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_10 = pos1 - 10 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_10 = pos2 - 10 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_10 = pos3 - 10 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_11 = pos0 - 11 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_11 = pos1 - 11 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_11 = pos2 - 11 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_11 = pos3 - 11 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_12 = pos0 - 12 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_12 = pos1 - 12 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_12 = pos2 - 12 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_12 = pos3 - 12 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_13 = pos0 - 13 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_13 = pos1 - 13 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_13 = pos2 - 13 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_13 = pos3 - 13 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_14 = pos0 - 14 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_14 = pos1 - 14 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_14 = pos2 - 14 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_14 = pos3 - 14 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_15 = pos0 - 15 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_15 = pos1 - 15 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_15 = pos2 - 15 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_15 = pos3 - 15 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_16 = pos0 - 16 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_16 = pos1 - 16 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_16 = pos2 - 16 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_16 = pos3 - 16 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_17 = pos0 - 17 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_17 = pos1 - 17 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_17 = pos2 - 17 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_17 = pos3 - 17 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_18 = pos0 - 18 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_18 = pos1 - 18 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_18 = pos2 - 18 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_18 = pos3 - 18 * (1 << 5);
	wire [`POS_LEN-1:0] pos0_19 = pos0 - 19 * (1 << 5);
	wire [`POS_LEN-1:0] pos1_19 = pos1 - 19 * (1 << 5);
	wire [`POS_LEN-1:0] pos2_19 = pos2 - 19 * (1 << 5);
	wire [`POS_LEN-1:0] pos3_19 = pos3 - 19 * (1 << 5);


	wire [8:0] id0_1 = `POS2ID(pos0_1);
	wire [8:0] id1_1 = `POS2ID(pos1_1);
	wire [8:0] id2_1 = `POS2ID(pos2_1);
	wire [8:0] id3_1 = `POS2ID(pos3_1);
	wire [8:0] id0_2 = `POS2ID(pos0_2);
	wire [8:0] id1_2 = `POS2ID(pos1_2);
	wire [8:0] id2_2 = `POS2ID(pos2_2);
	wire [8:0] id3_2 = `POS2ID(pos3_2);
	wire [8:0] id0_3 = `POS2ID(pos0_3);
	wire [8:0] id1_3 = `POS2ID(pos1_3);
	wire [8:0] id2_3 = `POS2ID(pos2_3);
	wire [8:0] id3_3 = `POS2ID(pos3_3);
	wire [8:0] id0_4 = `POS2ID(pos0_4);
	wire [8:0] id1_4 = `POS2ID(pos1_4);
	wire [8:0] id2_4 = `POS2ID(pos2_4);
	wire [8:0] id3_4 = `POS2ID(pos3_4);
	wire [8:0] id0_5 = `POS2ID(pos0_5);
	wire [8:0] id1_5 = `POS2ID(pos1_5);
	wire [8:0] id2_5 = `POS2ID(pos2_5);
	wire [8:0] id3_5 = `POS2ID(pos3_5);
	wire [8:0] id0_6 = `POS2ID(pos0_6);
	wire [8:0] id1_6 = `POS2ID(pos1_6);
	wire [8:0] id2_6 = `POS2ID(pos2_6);
	wire [8:0] id3_6 = `POS2ID(pos3_6);
	wire [8:0] id0_7 = `POS2ID(pos0_7);
	wire [8:0] id1_7 = `POS2ID(pos1_7);
	wire [8:0] id2_7 = `POS2ID(pos2_7);
	wire [8:0] id3_7 = `POS2ID(pos3_7);
	wire [8:0] id0_8 = `POS2ID(pos0_8);
	wire [8:0] id1_8 = `POS2ID(pos1_8);
	wire [8:0] id2_8 = `POS2ID(pos2_8);
	wire [8:0] id3_8 = `POS2ID(pos3_8);
	wire [8:0] id0_9 = `POS2ID(pos0_9);
	wire [8:0] id1_9 = `POS2ID(pos1_9);
	wire [8:0] id2_9 = `POS2ID(pos2_9);
	wire [8:0] id3_9 = `POS2ID(pos3_9);
	wire [8:0] id0_10 = `POS2ID(pos0_10);
	wire [8:0] id1_10 = `POS2ID(pos1_10);
	wire [8:0] id2_10 = `POS2ID(pos2_10);
	wire [8:0] id3_10 = `POS2ID(pos3_10);
	wire [8:0] id0_11 = `POS2ID(pos0_11);
	wire [8:0] id1_11 = `POS2ID(pos1_11);
	wire [8:0] id2_11 = `POS2ID(pos2_11);
	wire [8:0] id3_11 = `POS2ID(pos3_11);
	wire [8:0] id0_12 = `POS2ID(pos0_12);
	wire [8:0] id1_12 = `POS2ID(pos1_12);
	wire [8:0] id2_12 = `POS2ID(pos2_12);
	wire [8:0] id3_12 = `POS2ID(pos3_12);
	wire [8:0] id0_13 = `POS2ID(pos0_13);
	wire [8:0] id1_13 = `POS2ID(pos1_13);
	wire [8:0] id2_13 = `POS2ID(pos2_13);
	wire [8:0] id3_13 = `POS2ID(pos3_13);
	wire [8:0] id0_14 = `POS2ID(pos0_14);
	wire [8:0] id1_14 = `POS2ID(pos1_14);
	wire [8:0] id2_14 = `POS2ID(pos2_14);
	wire [8:0] id3_14 = `POS2ID(pos3_14);
	wire [8:0] id0_15 = `POS2ID(pos0_15);
	wire [8:0] id1_15 = `POS2ID(pos1_15);
	wire [8:0] id2_15 = `POS2ID(pos2_15);
	wire [8:0] id3_15 = `POS2ID(pos3_15);
	wire [8:0] id0_16 = `POS2ID(pos0_16);
	wire [8:0] id1_16 = `POS2ID(pos1_16);
	wire [8:0] id2_16 = `POS2ID(pos2_16);
	wire [8:0] id3_16 = `POS2ID(pos3_16);
	wire [8:0] id0_17 = `POS2ID(pos0_17);
	wire [8:0] id1_17 = `POS2ID(pos1_17);
	wire [8:0] id2_17 = `POS2ID(pos2_17);
	wire [8:0] id3_17 = `POS2ID(pos3_17);
	wire [8:0] id0_18 = `POS2ID(pos0_18);
	wire [8:0] id1_18 = `POS2ID(pos1_18);
	wire [8:0] id2_18 = `POS2ID(pos2_18);
	wire [8:0] id3_18 = `POS2ID(pos3_18);
	wire [8:0] id0_19 = `POS2ID(pos0_19);
	wire [8:0] id1_19 = `POS2ID(pos1_19);
	wire [8:0] id2_19 = `POS2ID(pos2_19);
	wire [8:0] id3_19 = `POS2ID(pos3_19);

	wire valid_pos1  =  1 > pos0 >> 5 || 1 > pos1 >> 5 || 1 > pos2 >> 5 || 1 > pos3 >> 5 ? 0 :                
						`IS_VALID_POS(pos0_1) & `IS_VALID_POS(pos1_1) & `IS_VALID_POS(pos2_1) & `IS_VALID_POS(pos3_1) 
						 & `IS_ALL_BLOCK_FREE(cur_board, id0_1, id1_1, id2_1, id3_1);
	wire valid_pos2  =  2 > pos0 >> 5 || 2 > pos1 >> 5 || 2 > pos2 >> 5 || 2 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_2) & `IS_VALID_POS(pos1_2) & `IS_VALID_POS(pos2_2) & `IS_VALID_POS(pos3_2) 
		                & `IS_ALL_BLOCK_FREE(cur_board, id0_2, id1_2, id2_2, id3_2);
	wire valid_pos3  =  3 > pos0 >> 5 || 3 > pos1 >> 5 || 3 > pos2 >> 5 || 3 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_3) & `IS_VALID_POS(pos1_3) & `IS_VALID_POS(pos2_3) & `IS_VALID_POS(pos3_3) 
					    & `IS_ALL_BLOCK_FREE(cur_board, id0_3, id1_3, id2_3, id3_3);
	wire valid_pos4  =  4 > pos0 >> 5 || 4 > pos1 >> 5 || 4 > pos2 >> 5 || 4 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_4) & `IS_VALID_POS(pos1_4) & `IS_VALID_POS(pos2_4) & `IS_VALID_POS(pos3_4) 
					    & `IS_ALL_BLOCK_FREE(cur_board, id0_4, id1_4, id2_4, id3_4);
	wire valid_pos5  =  5 > pos0 >> 5 || 5 > pos1 >> 5 || 5 > pos2 >> 5 || 5 > pos3 >> 5 ? 0 :                
			            `IS_VALID_POS(pos0_5) & `IS_VALID_POS(pos1_5) & `IS_VALID_POS(pos2_5) & `IS_VALID_POS(pos3_5) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_5, id1_5, id2_5, id3_5);
	wire valid_pos6  =  6 > pos0 >> 5 || 6 > pos1 >> 5 || 6 > pos2 >> 5 || 6 > pos3 >> 5 ? 0 :                
			            `IS_VALID_POS(pos0_6) & `IS_VALID_POS(pos1_6) & `IS_VALID_POS(pos2_6) & `IS_VALID_POS(pos3_6) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_6, id1_6, id2_6, id3_6);
	wire valid_pos7  =  7 > pos0 >> 5 || 7 > pos1 >> 5 || 7 > pos2 >> 5 || 7 > pos3 >> 5 ? 0 :                
			            `IS_VALID_POS(pos0_7) & `IS_VALID_POS(pos1_7) & `IS_VALID_POS(pos2_7) & `IS_VALID_POS(pos3_7) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_7, id1_7, id2_7, id3_7);
	wire valid_pos8  =  8 > pos0 >> 5 || 8 > pos1 >> 5 || 8 > pos2 >> 5 || 8 > pos3 >> 5 ? 0 :                
			            `IS_VALID_POS(pos0_8) & `IS_VALID_POS(pos1_8) & `IS_VALID_POS(pos2_8) & `IS_VALID_POS(pos3_8) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_8, id1_8, id2_8, id3_8);
	wire valid_pos9  =  9 > pos0 >> 5 || 9 > pos1 >> 5 || 9 > pos2 >> 5 || 9 > pos3 >> 5 ? 0 :                
			            `IS_VALID_POS(pos0_9) & `IS_VALID_POS(pos1_9) & `IS_VALID_POS(pos2_9) & `IS_VALID_POS(pos3_9) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_9, id1_9, id2_9, id3_9);
	wire valid_pos10  =  10 > pos0 >> 5 || 10 > pos1 >> 5 || 10 > pos2 >> 5 || 10 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_10) & `IS_VALID_POS(pos1_10) & `IS_VALID_POS(pos2_10) & `IS_VALID_POS(pos3_10) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_10, id1_10, id2_10, id3_10);
	wire valid_pos11  =  11 > pos0 >> 5 || 11 > pos1 >> 5 || 11 > pos2 >> 5 || 11 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_11) & `IS_VALID_POS(pos1_11) & `IS_VALID_POS(pos2_11) & `IS_VALID_POS(pos3_11) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_11, id1_11, id2_11, id3_11);
	wire valid_pos12  =  12 > pos0 >> 5 || 12 > pos1 >> 5 || 12 > pos2 >> 5 || 12 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_12) & `IS_VALID_POS(pos1_12) & `IS_VALID_POS(pos2_12) & `IS_VALID_POS(pos3_12) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_12, id1_12, id2_12, id3_12);
	wire valid_pos13  =  13 > pos0 >> 5 || 13 > pos1 >> 5 || 13 > pos2 >> 5 || 13 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_13) & `IS_VALID_POS(pos1_13) & `IS_VALID_POS(pos2_13) & `IS_VALID_POS(pos3_13) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_13, id1_13, id2_13, id3_13);
	wire valid_pos14  =  14 > pos0 >> 5 || 14 > pos1 >> 5 || 14 > pos2 >> 5 || 14 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_14) & `IS_VALID_POS(pos1_14) & `IS_VALID_POS(pos2_14) & `IS_VALID_POS(pos3_14) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_14, id1_14, id2_14, id3_14);
	wire valid_pos15  =  15 > pos0 >> 5 || 15 > pos1 >> 5 || 15 > pos2 >> 5 || 15 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_15) & `IS_VALID_POS(pos1_15) & `IS_VALID_POS(pos2_15) & `IS_VALID_POS(pos3_15) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_15, id1_15, id2_15, id3_15);
	wire valid_pos16  =  16 > pos0 >> 5 || 16 > pos1 >> 5 || 16 > pos2 >> 5 || 16 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_16) & `IS_VALID_POS(pos1_16) & `IS_VALID_POS(pos2_16) & `IS_VALID_POS(pos3_16) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_16, id1_16, id2_16, id3_16);
	wire valid_pos17  =  17 > pos0 >> 5 || 17 > pos1 >> 5 || 17 > pos2 >> 5 || 17 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_17) & `IS_VALID_POS(pos1_17) & `IS_VALID_POS(pos2_17) & `IS_VALID_POS(pos3_17) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_17, id1_17, id2_17, id3_17);
	wire valid_pos18  =  18 > pos0 >> 5 || 18 > pos1 >> 5 || 18 > pos2 >> 5 || 18 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_18) & `IS_VALID_POS(pos1_18) & `IS_VALID_POS(pos2_18) & `IS_VALID_POS(pos3_18) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_18, id1_18, id2_18, id3_18);
	wire valid_pos19  =  19 > pos0 >> 5 || 19 > pos1 >> 5 || 19 > pos2 >> 5 || 19 > pos3 >> 5 ? 0 :                
					    `IS_VALID_POS(pos0_19) & `IS_VALID_POS(pos1_19) & `IS_VALID_POS(pos2_19) & `IS_VALID_POS(pos3_19) 
						& `IS_ALL_BLOCK_FREE(cur_board, id0_19, id1_19, id2_19, id3_19);

	wire valid_to_19 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14 & valid_pos15 & valid_pos16 & valid_pos17 & valid_pos18 & valid_pos19;
	wire valid_to_18 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14 & valid_pos15 & valid_pos16 & valid_pos17 & valid_pos18;
	wire valid_to_17 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14 & valid_pos15 & valid_pos16 & valid_pos17;
	wire valid_to_16 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14 & valid_pos15 & valid_pos16;
	wire valid_to_15 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14 & valid_pos15;
	wire valid_to_14 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13 & valid_pos14;
	wire valid_to_13 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12 & valid_pos13;
	wire valid_to_12 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11 & valid_pos12;
	wire valid_to_11 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10 & valid_pos11;
	wire valid_to_10 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9 & valid_pos10;
	wire valid_to_9 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8 & valid_pos9;
	wire valid_to_8 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7 & valid_pos8;
	wire valid_to_7 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6 & valid_pos7;
	wire valid_to_6 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5 & valid_pos6;
	wire valid_to_5 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4 & valid_pos5;
	wire valid_to_4 = valid_pos1 & valid_pos2 & valid_pos3 & valid_pos4;
	wire valid_to_3 = valid_pos1 & valid_pos2 & valid_pos3;
	wire valid_to_2 = valid_pos1 & valid_pos2;
	wire valid_to_1 = valid_pos1;

	assign new_pos = valid_to_19 ? pos - 19 * (1<<5):
				  valid_to_18 ? pos - 18 * (1<<5):
				  valid_to_17 ? pos - 17 * (1<<5):
				  valid_to_16 ? pos - 16 * (1<<5):
				  valid_to_15 ? pos - 15 * (1<<5):
				  valid_to_14 ? pos - 14 * (1<<5):
				  valid_to_13 ? pos - 13 * (1<<5):
				  valid_to_12 ? pos - 12 * (1<<5):
				  valid_to_11 ? pos - 11 * (1<<5):
				  valid_to_10 ? pos - 10 * (1<<5):
				  valid_to_9  ? pos - 9 * (1<<5):
				  valid_to_8  ? pos - 8 * (1<<5):
				  valid_to_7  ? pos - 7 * (1<<5):
				  valid_to_6  ? pos - 6 * (1<<5):
				  valid_to_5  ? pos - 5 * (1<<5):
				  valid_to_4  ? pos - 4 * (1<<5):
				  valid_to_3  ? pos - 3 * (1<<5):
				  valid_to_2  ? pos - 2 * (1<<5):
				  valid_to_1  ? pos - 1 * (1<<5): pos;
endmodule
