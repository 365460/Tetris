// NOTE: This code assumes that `BOARD_H = 20
`include "header.v"

module clear(
  input wire[`BOARD_SIZE-1:0] cur_board,
  output wire[`CLEAR_LEN-1:0] num_to_clear,
  output wire[`BOARD_SIZE-1:0] nxt_board
);

  wire [`BOARD_W-1:0] row_filled = (1 << `BOARD_W) - 1;

  wire[4:0] first_to_clear = `GET_ROW_FILL(cur_board,  0) == row_filled ?  0 :
                             `GET_ROW_FILL(cur_board,  1) == row_filled ?  1 :
                             `GET_ROW_FILL(cur_board,  2) == row_filled ?  2 :
                             `GET_ROW_FILL(cur_board,  3) == row_filled ?  3 :
                             `GET_ROW_FILL(cur_board,  4) == row_filled ?  4 :
                             `GET_ROW_FILL(cur_board,  5) == row_filled ?  5 :
                             `GET_ROW_FILL(cur_board,  6) == row_filled ?  6 :
                             `GET_ROW_FILL(cur_board,  7) == row_filled ?  7 :
                             `GET_ROW_FILL(cur_board,  8) == row_filled ?  8 :
                             `GET_ROW_FILL(cur_board,  9) == row_filled ?  9 :
                             `GET_ROW_FILL(cur_board, 10) == row_filled ? 10 :
                             `GET_ROW_FILL(cur_board, 11) == row_filled ? 11 :
                             `GET_ROW_FILL(cur_board, 12) == row_filled ? 12 :
                             `GET_ROW_FILL(cur_board, 13) == row_filled ? 13 :
                             `GET_ROW_FILL(cur_board, 14) == row_filled ? 14 :
                             `GET_ROW_FILL(cur_board, 15) == row_filled ? 15 :
                             `GET_ROW_FILL(cur_board, 16) == row_filled ? 16 :
                             `GET_ROW_FILL(cur_board, 17) == row_filled ? 17 :
                             `GET_ROW_FILL(cur_board, 18) == row_filled ? 18 :
                             `GET_ROW_FILL(cur_board, 19) == row_filled ? 19 : `BOARD_H;

  assign num_to_clear = (first_to_clear + 0 < `BOARD_H ? `GET_ROW_FILL(cur_board, first_to_clear + 0) == row_filled : 0) +
                        (first_to_clear + 1 < `BOARD_H ? `GET_ROW_FILL(cur_board, first_to_clear + 1) == row_filled : 0) +
                        (first_to_clear + 2 < `BOARD_H ? `GET_ROW_FILL(cur_board, first_to_clear + 2) == row_filled : 0) +
                        (first_to_clear + 3 < `BOARD_H ? `GET_ROW_FILL(cur_board, first_to_clear + 3) == row_filled : 0);

  wire[`BOARD_W-1:0] row_emptied = (1 << `BOARD_W) - 1;
  wire[`BOARD_WPLEN-1:0] row_dummy = (1 << `BOARD_WPLEN) - 1;

  assign nxt_board = {
                        0 < first_to_clear ? `GET_ROW_TYPE(cur_board,  0) : 0  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  0 + num_to_clear) : row_dummy,
                        1 < first_to_clear ? `GET_ROW_TYPE(cur_board,  1) : 1  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  1 + num_to_clear) : row_dummy,
                        2 < first_to_clear ? `GET_ROW_TYPE(cur_board,  2) : 2  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  2 + num_to_clear) : row_dummy,
                        3 < first_to_clear ? `GET_ROW_TYPE(cur_board,  3) : 3  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  3 + num_to_clear) : row_dummy,
                        4 < first_to_clear ? `GET_ROW_TYPE(cur_board,  4) : 4  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  4 + num_to_clear) : row_dummy,
                        5 < first_to_clear ? `GET_ROW_TYPE(cur_board,  5) : 5  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  5 + num_to_clear) : row_dummy,
                        6 < first_to_clear ? `GET_ROW_TYPE(cur_board,  6) : 6  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  6 + num_to_clear) : row_dummy,
                        7 < first_to_clear ? `GET_ROW_TYPE(cur_board,  7) : 7  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  7 + num_to_clear) : row_dummy,
                        8 < first_to_clear ? `GET_ROW_TYPE(cur_board,  8) : 8  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  8 + num_to_clear) : row_dummy,
                        9 < first_to_clear ? `GET_ROW_TYPE(cur_board,  9) : 9  + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board,  9 + num_to_clear) : row_dummy,
                       10 < first_to_clear ? `GET_ROW_TYPE(cur_board, 10) : 10 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 10 + num_to_clear) : row_dummy,
                       11 < first_to_clear ? `GET_ROW_TYPE(cur_board, 11) : 11 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 11 + num_to_clear) : row_dummy,
                       12 < first_to_clear ? `GET_ROW_TYPE(cur_board, 12) : 12 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 12 + num_to_clear) : row_dummy,
                       13 < first_to_clear ? `GET_ROW_TYPE(cur_board, 13) : 13 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 13 + num_to_clear) : row_dummy,
                       14 < first_to_clear ? `GET_ROW_TYPE(cur_board, 14) : 14 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 14 + num_to_clear) : row_dummy,
                       15 < first_to_clear ? `GET_ROW_TYPE(cur_board, 15) : 15 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 15 + num_to_clear) : row_dummy,
                       16 < first_to_clear ? `GET_ROW_TYPE(cur_board, 16) : 16 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 16 + num_to_clear) : row_dummy,
                       17 < first_to_clear ? `GET_ROW_TYPE(cur_board, 17) : 17 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 17 + num_to_clear) : row_dummy,
                       18 < first_to_clear ? `GET_ROW_TYPE(cur_board, 18) : 18 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 18 + num_to_clear) : row_dummy,
                       19 < first_to_clear ? `GET_ROW_TYPE(cur_board, 19) : 19 + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, 19 + num_to_clear) : row_dummy,

                        0 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  0 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  0 + num_to_clear) : row_emptied, 
                        1 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  1 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  1 + num_to_clear) : row_emptied, 
                        2 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  2 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  2 + num_to_clear) : row_emptied, 
                        3 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  3 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  3 + num_to_clear) : row_emptied, 
                        4 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  4 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  4 + num_to_clear) : row_emptied, 
                        5 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  5 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  5 + num_to_clear) : row_emptied, 
                        6 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  6 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  6 + num_to_clear) : row_emptied, 
                        7 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  7 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  7 + num_to_clear) : row_emptied, 
                        8 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  8 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  8 + num_to_clear) : row_emptied, 
                        9 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) :  9 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board,  9 + num_to_clear) : row_emptied, 
                       10 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 10 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 10 + num_to_clear) : row_emptied, 
                       11 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 11 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 11 + num_to_clear) : row_emptied, 
                       12 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 12 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 12 + num_to_clear) : row_emptied, 
                       13 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 13 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 13 + num_to_clear) : row_emptied, 
                       14 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 14 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 14 + num_to_clear) : row_emptied, 
                       15 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 15 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 15 + num_to_clear) : row_emptied, 
                       16 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 16 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 16 + num_to_clear) : row_emptied, 
                       17 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 17 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 17 + num_to_clear) : row_emptied, 
                       18 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 18 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 18 + num_to_clear) : row_emptied, 
                       19 < first_to_clear ? `GET_ROW_FILL(cur_board,  0) : 19 + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, 19 + num_to_clear) : row_emptied
                     };
endmodule
