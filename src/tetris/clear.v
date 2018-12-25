// NOTE: This code assumes that `BOARD_H = 20
`include "header.v"

module clear(
  input clk,
  input rst,
  input wire[`BOARD_SIZE-1:0] cur_board,
  output wire[`CLEAR_LEN-1:0] num_to_clear,
  output wire[`BOARD_SIZE-1:0] nxt_board
);

  wire[`BOARD_W-1:0] row_filled = (1 << `BOARD_W) - 1;

  reg[4:0] ctr, ctr_nx;
  reg[4:0] first_to_clear;
  always @(posedge clk or posedge rst) begin
    first_to_clear <= rst ? `BOARD_H - 1 : 
                      0 < first_to_clear &&
                      !`GET_ROW_FILL(cur_board, first_to_clear) &&
                      `GET_ROW_FILL(cur_board, first_to_clear - 1) == row_filled ? first_to_clear - 1 :
                                                                                   first_to_clear;
    ctr <= rst ? 0 : ctr_nx;
  end

  assign num_to_clear = (first_to_clear >= 0 ? `GET_ROW_FILL(cur_board, first_to_clear - 0) == row_filled : 0) +
                        (first_to_clear >= 1 ? `GET_ROW_FILL(cur_board, first_to_clear - 1) == row_filled : 0) +
                        (first_to_clear >= 2 ? `GET_ROW_FILL(cur_board, first_to_clear - 2) == row_filled : 0) +
                        (first_to_clear >= 3 ? `GET_ROW_FILL(cur_board, first_to_clear - 3) == row_filled : 0);

  wire[`BOARD_W-1:0] row_emptied = (1 << `BOARD_W) - 1;
  wire[`BOARD_WPLEN-1:0] row_dummy = (1 << `BOARD_WPLEN) - 1;

  reg[`BOARD_SIZE-1:0] nxt_board_nx;
  assign nxt_board = nxt_board_nx;
  always @(*) begin
    ctr_nx <= ctr + 1 < `BOARD_H ? ctr + 1 : `BOARD_H;
    nxt_board_nx <= ctr == `BOARD_H ? nxt_board : 
                    ((nxt_board | row_dummy << ctr * `BOARD_W * `BRICK_LEN | row_filled << `BOARD_H * `BOARD_W * `BRICK_LEN + ctr * `BOARD_W) ^

                    (row_dummy << ctr * `BOARD_W * `BRICK_LEN | row_filled << `BOARD_H * `BOARD_W * `BRICK_LEN + ctr * `BOARD_W)) | // up to here clears the two rows

                    (ctr < first_to_clear ? `GET_ROW_TYPE(cur_board, ctr) : ctr + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(cur_board, ctr + num_to_clear) : row_dummy)
                      << ctr * `BOARD_W * `BRICK_LEN |

                    (ctr < first_to_clear ? `GET_ROW_FILL(cur_board, ctr) : ctr + num_to_clear < `BOARD_H ? `GET_ROW_FILL(cur_board, ctr + num_to_clear) : row_emptied)
                      << `BOARD_H * `BOARD_W * `BRICK_LEN + ctr * `BOARD_W;
  end

endmodule
