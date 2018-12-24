// This code assumes that `BOARD_H = 20
`include "header.v"

module drop(
  input wire[`BOARD_SIZE-1:0] cur_board,
  input wire[`POS_LEN-1:0] pos,
  input wire[`BRICK_LEN-1:0] brick_type,
  input wire[`DIR_LEN-1:0] dir,
  output wire[`BOARD_H-1:0] shift
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

  wire [`POS_LEN-1:0] pos01 = pos0  -  1 * (1 << 5);
  wire [`POS_LEN-1:0] pos11 = pos1  -  1 * (1 << 5);
  wire [`POS_LEN-1:0] pos21 = pos2  -  1 * (1 << 5);
  wire [`POS_LEN-1:0] pos31 = pos3  -  1 * (1 << 5);
  wire [`POS_LEN-1:0] pos02 = pos0  -  2 * (1 << 5);
  wire [`POS_LEN-1:0] pos12 = pos1  -  2 * (1 << 5);
  wire [`POS_LEN-1:0] pos22 = pos2  -  2 * (1 << 5);
  wire [`POS_LEN-1:0] pos32 = pos3  -  2 * (1 << 5);
  wire [`POS_LEN-1:0] pos03 = pos0  -  3 * (1 << 5);
  wire [`POS_LEN-1:0] pos13 = pos1  -  3 * (1 << 5);
  wire [`POS_LEN-1:0] pos23 = pos2  -  3 * (1 << 5);
  wire [`POS_LEN-1:0] pos33 = pos3  -  3 * (1 << 5);
  wire [`POS_LEN-1:0] pos04 = pos0  -  4 * (1 << 5);
  wire [`POS_LEN-1:0] pos14 = pos1  -  4 * (1 << 5);
  wire [`POS_LEN-1:0] pos24 = pos2  -  4 * (1 << 5);
  wire [`POS_LEN-1:0] pos34 = pos3  -  4 * (1 << 5);
  wire [`POS_LEN-1:0] pos05 = pos0  -  5 * (1 << 5);
  wire [`POS_LEN-1:0] pos15 = pos1  -  5 * (1 << 5);
  wire [`POS_LEN-1:0] pos25 = pos2  -  5 * (1 << 5);
  wire [`POS_LEN-1:0] pos35 = pos3  -  5 * (1 << 5);
  wire [`POS_LEN-1:0] pos06 = pos0  -  6 * (1 << 5);
  wire [`POS_LEN-1:0] pos16 = pos1  -  6 * (1 << 5);
  wire [`POS_LEN-1:0] pos26 = pos2  -  6 * (1 << 5);
  wire [`POS_LEN-1:0] pos36 = pos3  -  6 * (1 << 5);
  wire [`POS_LEN-1:0] pos07 = pos0  -  7 * (1 << 5);
  wire [`POS_LEN-1:0] pos17 = pos1  -  7 * (1 << 5);
  wire [`POS_LEN-1:0] pos27 = pos2  -  7 * (1 << 5);
  wire [`POS_LEN-1:0] pos37 = pos3  -  7 * (1 << 5);
  wire [`POS_LEN-1:0] pos08 = pos0  -  8 * (1 << 5);
  wire [`POS_LEN-1:0] pos18 = pos1  -  8 * (1 << 5);
  wire [`POS_LEN-1:0] pos28 = pos2  -  8 * (1 << 5);
  wire [`POS_LEN-1:0] pos38 = pos3  -  8 * (1 << 5);
  wire [`POS_LEN-1:0] pos09 = pos0  -  9 * (1 << 5);
  wire [`POS_LEN-1:0] pos19 = pos1  -  9 * (1 << 5);
  wire [`POS_LEN-1:0] pos29 = pos2  -  9 * (1 << 5);
  wire [`POS_LEN-1:0] pos39 = pos3  -  9 * (1 << 5);
  wire [`POS_LEN-1:0] pos010 = pos0 - 10 * (1 << 5);
  wire [`POS_LEN-1:0] pos110 = pos1 - 10 * (1 << 5);
  wire [`POS_LEN-1:0] pos210 = pos2 - 10 * (1 << 5);
  wire [`POS_LEN-1:0] pos310 = pos3 - 10 * (1 << 5);
  wire [`POS_LEN-1:0] pos011 = pos0 - 11 * (1 << 5);
  wire [`POS_LEN-1:0] pos111 = pos1 - 11 * (1 << 5);
  wire [`POS_LEN-1:0] pos211 = pos2 - 11 * (1 << 5);
  wire [`POS_LEN-1:0] pos311 = pos3 - 11 * (1 << 5);
  wire [`POS_LEN-1:0] pos012 = pos0 - 12 * (1 << 5);
  wire [`POS_LEN-1:0] pos112 = pos1 - 12 * (1 << 5);
  wire [`POS_LEN-1:0] pos212 = pos2 - 12 * (1 << 5);
  wire [`POS_LEN-1:0] pos312 = pos3 - 12 * (1 << 5);
  wire [`POS_LEN-1:0] pos013 = pos0 - 13 * (1 << 5);
  wire [`POS_LEN-1:0] pos113 = pos1 - 13 * (1 << 5);
  wire [`POS_LEN-1:0] pos213 = pos2 - 13 * (1 << 5);
  wire [`POS_LEN-1:0] pos313 = pos3 - 13 * (1 << 5);
  wire [`POS_LEN-1:0] pos014 = pos0 - 14 * (1 << 5);
  wire [`POS_LEN-1:0] pos114 = pos1 - 14 * (1 << 5);
  wire [`POS_LEN-1:0] pos214 = pos2 - 14 * (1 << 5);
  wire [`POS_LEN-1:0] pos314 = pos3 - 14 * (1 << 5);
  wire [`POS_LEN-1:0] pos015 = pos0 - 15 * (1 << 5);
  wire [`POS_LEN-1:0] pos115 = pos1 - 15 * (1 << 5);
  wire [`POS_LEN-1:0] pos215 = pos2 - 15 * (1 << 5);
  wire [`POS_LEN-1:0] pos315 = pos3 - 15 * (1 << 5);
  wire [`POS_LEN-1:0] pos016 = pos0 - 16 * (1 << 5);
  wire [`POS_LEN-1:0] pos116 = pos1 - 16 * (1 << 5);
  wire [`POS_LEN-1:0] pos216 = pos2 - 16 * (1 << 5);
  wire [`POS_LEN-1:0] pos316 = pos3 - 16 * (1 << 5);
  wire [`POS_LEN-1:0] pos017 = pos0 - 17 * (1 << 5);
  wire [`POS_LEN-1:0] pos117 = pos1 - 17 * (1 << 5);
  wire [`POS_LEN-1:0] pos217 = pos2 - 17 * (1 << 5);
  wire [`POS_LEN-1:0] pos317 = pos3 - 17 * (1 << 5);
  wire [`POS_LEN-1:0] pos018 = pos0 - 18 * (1 << 5);
  wire [`POS_LEN-1:0] pos118 = pos1 - 18 * (1 << 5);
  wire [`POS_LEN-1:0] pos218 = pos2 - 18 * (1 << 5);
  wire [`POS_LEN-1:0] pos318 = pos3 - 18 * (1 << 5);
  wire [`POS_LEN-1:0] pos019 = pos0 - 19 * (1 << 5);
  wire [`POS_LEN-1:0] pos119 = pos1 - 19 * (1 << 5);
  wire [`POS_LEN-1:0] pos219 = pos2 - 19 * (1 << 5);
  wire [`POS_LEN-1:0] pos319 = pos3 - 19 * (1 << 5);

  assign valid_pos1  =  1 > pos0 >> 5 || 1 > pos1 >> 5 || 1 > pos2 >> 5 || 1 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos01) & `IS_VALID_POS(pos11) & `IS_VALID_POS(pos21) & `IS_VALID_POS(pos31) &
                      `GET_BLOCK_FILL(cur_board, pos01) & `GET_BLOCK_FILL(cur_board, pos11) & `GET_BLOCK_FILL(cur_board, pos21) & `GET_BLOCK_FILL(cur_board, pos31);
  assign valid_pos2  =  2 > pos0 >> 5 || 2 > pos1 >> 5 || 2 > pos2 >> 5 || 2 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos02) & `IS_VALID_POS(pos12) & `IS_VALID_POS(pos22) & `IS_VALID_POS(pos32) &
                      `GET_BLOCK_FILL(cur_board, pos02) & `GET_BLOCK_FILL(cur_board, pos12) & `GET_BLOCK_FILL(cur_board, pos22) & `GET_BLOCK_FILL(cur_board, pos32);
  assign valid_pos3  =  3 > pos0 >> 5 || 3 > pos1 >> 5 || 3 > pos2 >> 5 || 3 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos03) & `IS_VALID_POS(pos13) & `IS_VALID_POS(pos23) & `IS_VALID_POS(pos33) &
                      `GET_BLOCK_FILL(cur_board, pos03) & `GET_BLOCK_FILL(cur_board, pos13) & `GET_BLOCK_FILL(cur_board, pos23) & `GET_BLOCK_FILL(cur_board, pos33);
  assign valid_pos4  =  4 > pos0 >> 5 || 4 > pos1 >> 5 || 4 > pos2 >> 5 || 4 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos04) & `IS_VALID_POS(pos14) & `IS_VALID_POS(pos24) & `IS_VALID_POS(pos34) &
                      `GET_BLOCK_FILL(cur_board, pos04) & `GET_BLOCK_FILL(cur_board, pos14) & `GET_BLOCK_FILL(cur_board, pos24) & `GET_BLOCK_FILL(cur_board, pos34);
  assign valid_pos5  =  5 > pos0 >> 5 || 5 > pos1 >> 5 || 5 > pos2 >> 5 || 5 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos05) & `IS_VALID_POS(pos15) & `IS_VALID_POS(pos25) & `IS_VALID_POS(pos35) &
                      `GET_BLOCK_FILL(cur_board, pos05) & `GET_BLOCK_FILL(cur_board, pos15) & `GET_BLOCK_FILL(cur_board, pos25) & `GET_BLOCK_FILL(cur_board, pos35);
  assign valid_pos6  =  6 > pos0 >> 5 || 6 > pos1 >> 5 || 6 > pos2 >> 5 || 6 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos06) & `IS_VALID_POS(pos16) & `IS_VALID_POS(pos26) & `IS_VALID_POS(pos36) &
                      `GET_BLOCK_FILL(cur_board, pos06) & `GET_BLOCK_FILL(cur_board, pos16) & `GET_BLOCK_FILL(cur_board, pos26) & `GET_BLOCK_FILL(cur_board, pos36);
  assign valid_pos7  =  7 > pos0 >> 5 || 7 > pos1 >> 5 || 7 > pos2 >> 5 || 7 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos07) & `IS_VALID_POS(pos17) & `IS_VALID_POS(pos27) & `IS_VALID_POS(pos37) &
                      `GET_BLOCK_FILL(cur_board, pos07) & `GET_BLOCK_FILL(cur_board, pos17) & `GET_BLOCK_FILL(cur_board, pos27) & `GET_BLOCK_FILL(cur_board, pos37);
  assign valid_pos8  =  8 > pos0 >> 5 || 8 > pos1 >> 5 || 8 > pos2 >> 5 || 8 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos08) & `IS_VALID_POS(pos18) & `IS_VALID_POS(pos28) & `IS_VALID_POS(pos38) &
                      `GET_BLOCK_FILL(cur_board, pos08) & `GET_BLOCK_FILL(cur_board, pos18) & `GET_BLOCK_FILL(cur_board, pos28) & `GET_BLOCK_FILL(cur_board, pos38);
  assign valid_pos9  =  9 > pos0 >> 5 || 9 > pos1 >> 5 || 9 > pos2 >> 5 || 9 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos09) & `IS_VALID_POS(pos19) & `IS_VALID_POS(pos29) & `IS_VALID_POS(pos39) &
                      `GET_BLOCK_FILL(cur_board, pos09) & `GET_BLOCK_FILL(cur_board, pos19) & `GET_BLOCK_FILL(cur_board, pos29) & `GET_BLOCK_FILL(cur_board, pos39);
  assign valid_pos10 = 10 > pos0 >> 5 || 10 > pos1 >> 5 || 10 > pos2 >> 5 || 10 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos010) & `IS_VALID_POS(pos110) & `IS_VALID_POS(pos210) & `IS_VALID_POS(pos311) &
                      `GET_BLOCK_FILL(cur_board, pos010) & `GET_BLOCK_FILL(cur_board, pos110) & `GET_BLOCK_FILL(cur_board, pos210) & `GET_BLOCK_FILL(cur_board, pos311);
  assign valid_pos11 = 11 > pos0 >> 5 || 11 > pos1 >> 5 || 11 > pos2 >> 5 || 11 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos011) & `IS_VALID_POS(pos111) & `IS_VALID_POS(pos211) & `IS_VALID_POS(pos311) &
                      `GET_BLOCK_FILL(cur_board, pos011) & `GET_BLOCK_FILL(cur_board, pos111) & `GET_BLOCK_FILL(cur_board, pos211) & `GET_BLOCK_FILL(cur_board, pos311);
  assign valid_pos12 = 12 > pos0 >> 5 || 12 > pos1 >> 5 || 12 > pos2 >> 5 || 12 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos012) & `IS_VALID_POS(pos112) & `IS_VALID_POS(pos212) & `IS_VALID_POS(pos312) &
                      `GET_BLOCK_FILL(cur_board, pos012) & `GET_BLOCK_FILL(cur_board, pos112) & `GET_BLOCK_FILL(cur_board, pos212) & `GET_BLOCK_FILL(cur_board, pos312);
  assign valid_pos13 = 13 > pos0 >> 5 || 13 > pos1 >> 5 || 13 > pos2 >> 5 || 13 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos013) & `IS_VALID_POS(pos113) & `IS_VALID_POS(pos213) & `IS_VALID_POS(pos313) &
                      `GET_BLOCK_FILL(cur_board, pos013) & `GET_BLOCK_FILL(cur_board, pos113) & `GET_BLOCK_FILL(cur_board, pos213) & `GET_BLOCK_FILL(cur_board, pos313);
  assign valid_pos14 = 14 > pos0 >> 5 || 14 > pos1 >> 5 || 14 > pos2 >> 5 || 14 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos014) & `IS_VALID_POS(pos114) & `IS_VALID_POS(pos214) & `IS_VALID_POS(pos314) &
                      `GET_BLOCK_FILL(cur_board, pos014) & `GET_BLOCK_FILL(cur_board, pos114) & `GET_BLOCK_FILL(cur_board, pos214) & `GET_BLOCK_FILL(cur_board, pos314);
  assign valid_pos15 = 15 > pos0 >> 5 || 15 > pos1 >> 5 || 15 > pos2 >> 5 || 15 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos015) & `IS_VALID_POS(pos115) & `IS_VALID_POS(pos215) & `IS_VALID_POS(pos315) &
                      `GET_BLOCK_FILL(cur_board, pos015) & `GET_BLOCK_FILL(cur_board, pos115) & `GET_BLOCK_FILL(cur_board, pos215) & `GET_BLOCK_FILL(cur_board, pos315);
  assign valid_pos16 = 16 > pos0 >> 5 || 16 > pos1 >> 5 || 16 > pos2 >> 5 || 16 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos016) & `IS_VALID_POS(pos116) & `IS_VALID_POS(pos216) & `IS_VALID_POS(pos316) &
                      `GET_BLOCK_FILL(cur_board, pos016) & `GET_BLOCK_FILL(cur_board, pos116) & `GET_BLOCK_FILL(cur_board, pos216) & `GET_BLOCK_FILL(cur_board, pos316);
  assign valid_pos17 = 17 > pos0 >> 5 || 17 > pos1 >> 5 || 17 > pos2 >> 5 || 17 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos017) & `IS_VALID_POS(pos117) & `IS_VALID_POS(pos217) & `IS_VALID_POS(pos317) &
                      `GET_BLOCK_FILL(cur_board, pos017) & `GET_BLOCK_FILL(cur_board, pos117) & `GET_BLOCK_FILL(cur_board, pos217) & `GET_BLOCK_FILL(cur_board, pos317);
  assign valid_pos18 = 18 > pos0 >> 5 || 18 > pos1 >> 5 || 18 > pos2 >> 5 || 18 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos018) & `IS_VALID_POS(pos118) & `IS_VALID_POS(pos218) & `IS_VALID_POS(pos318) &
                      `GET_BLOCK_FILL(cur_board, pos018) & `GET_BLOCK_FILL(cur_board, pos118) & `GET_BLOCK_FILL(cur_board, pos218) & `GET_BLOCK_FILL(cur_board, pos318);
  assign valid_pos19 = 19 > pos0 >> 5 || 19 > pos1 >> 5 || 19 > pos2 >> 5 || 19 > pos3 >> 5 ? 0 :                
                      `IS_VALID_POS(pos019) & `IS_VALID_POS(pos119) & `IS_VALID_POS(pos219) & `IS_VALID_POS(pos319) &
                      `GET_BLOCK_FILL(cur_board, pos019) & `GET_BLOCK_FILL(cur_board, pos119) & `GET_BLOCK_FILL(cur_board, pos219) & `GET_BLOCK_FILL(cur_board, pos319);

  assign shift   = !valid_pos1  ?  0 :
                   !valid_pos2  ?  1 : 
                   !valid_pos3  ?  2 : 
                   !valid_pos4  ?  3 : 
                   !valid_pos5  ?  4 : 
                   !valid_pos6  ?  5 : 
                   !valid_pos7  ?  6 : 
                   !valid_pos8  ?  7 : 
                   !valid_pos9  ?  8 : 
                   !valid_pos10 ?  9 : 
                   !valid_pos11 ? 10 : 
                   !valid_pos12 ? 11 : 
                   !valid_pos13 ? 12 : 
                   !valid_pos14 ? 13 : 
                   !valid_pos15 ? 14 : 
                   !valid_pos16 ? 15 : 
                   !valid_pos17 ? 16 : 
                   !valid_pos18 ? 17 : 
                   !valid_pos19 ? 18 : 19;

endmodule
