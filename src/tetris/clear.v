// NOTE: This code assumes that `BOARD_H = 20
`include "header.v"

module clear(
  input clk,
  input rst,
  input wire[`BOARD_SIZE-1:0] cur_board,
  output wire[`CLEAR_LEN-1:0] num_to_clear,
  output reg[`BOARD_SIZE-1:0] nxt_board
);

  reg[4:0] ctr, ctr_nx;
  reg[4:0] first_to_clear;
  reg[`BOARD_SIZE-1:0] nxt_board_nx;
  always @(posedge clk or posedge rst) begin
    first_to_clear <= rst ? 0 : 
                      first_to_clear + 1 < `BOARD_H &&
                      (&`GET_ROW_FILL(cur_board, first_to_clear)) == 1 &&
                      (&`GET_ROW_FILL(cur_board, first_to_clear + 1)) == 1 ? first_to_clear + 1 :
                                                                             first_to_clear;
    ctr <= rst ? 0 : ctr_nx;
    nxt_board <= rst ? cur_board : nxt_board_nx;
  end

  assign num_to_clear = (first_to_clear + 0 < `BOARD_H ? &`GET_ROW_FILL(cur_board, first_to_clear + 0) : 0) +
                        (first_to_clear + 1 < `BOARD_H ? &`GET_ROW_FILL(cur_board, first_to_clear + 1) : 0) +
                        (first_to_clear + 2 < `BOARD_H ? &`GET_ROW_FILL(cur_board, first_to_clear + 2) : 0) +
                        (first_to_clear + 3 < `BOARD_H ? &`GET_ROW_FILL(cur_board, first_to_clear + 3) : 0);

  wire[`BOARD_W-1:0] row_emptied = 0;
  wire[`BOARD_WPLEN-1:0] row_dummy = 0;

  always @(ctr) begin
    ctr_nx = ctr + 1 < `BOARD_H ? ctr + 1 : `BOARD_H;
    nxt_board_nx = nxt_board;
    if (ctr < `BOARD_H && first_to_clear <= ctr) begin
      `GET_ROW_TYPE(nxt_board_nx, ctr) = ctr + num_to_clear < `BOARD_H ? `GET_ROW_TYPE(nxt_board, ctr + num_to_clear) : row_dummy;
      `GET_ROW_FILL(nxt_board_nx, ctr) = ctr + num_to_clear < `BOARD_H ? `GET_ROW_FILL(nxt_board, ctr + num_to_clear) : row_emptied; 
    end
  end

endmodule
