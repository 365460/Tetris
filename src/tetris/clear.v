// This code assumes that `BOARD_H = 20
`include "header.v"

module clear(
	input wire[`BOARD_SIZE-1:0] cur_board,
    output wire[2:0] num_to_clear,
	output wire[`BOARD_SIZE-1:0] new_board
);
    
    wire[4:0] first_to_clear = &`GET_ROW_FILL(cur_board,  0) ?  0 :
                               &`GET_ROW_FILL(cur_board,  1) ?  1 :
                               &`GET_ROW_FILL(cur_board,  2) ?  2 :
                               &`GET_ROW_FILL(cur_board,  3) ?  3 :
                               &`GET_ROW_FILL(cur_board,  4) ?  4 :
                               &`GET_ROW_FILL(cur_board,  5) ?  5 :
                               &`GET_ROW_FILL(cur_board,  6) ?  6 :
                               &`GET_ROW_FILL(cur_board,  7) ?  7 :
                               &`GET_ROW_FILL(cur_board,  8) ?  8 :
                               &`GET_ROW_FILL(cur_board,  9) ?  9 :
                               &`GET_ROW_FILL(cur_board, 10) ? 10 :
                               &`GET_ROW_FILL(cur_board, 11) ? 11 :
                               &`GET_ROW_FILL(cur_board, 12) ? 12 :
                               &`GET_ROW_FILL(cur_board, 13) ? 13 :
                               &`GET_ROW_FILL(cur_board, 14) ? 14 :
                               &`GET_ROW_FILL(cur_board, 15) ? 15 :
                               &`GET_ROW_FILL(cur_board, 16) ? 16 :
                               &`GET_ROW_FILL(cur_board, 17) ? 17 :
                               &`GET_ROW_FILL(cur_board, 18) ? 18 :
                               &`GET_ROW_FILL(cur_board, 19) ? 19 : `BOARD_H;

    wire[3:0] pattern_to_clear = first_to_clear == `BOARD_H ? 0 :
                                 1 << 0 | // first_to_clear
                                 (first_to_clear + 1 < `BOARD_H && &`GET_ROW_FILL(cur_board, first_to_clear + 1)) << 1 |
                                 (first_to_clear + 2 < `BOARD_H && &`GET_ROW_FILL(cur_board, first_to_clear + 2)) << 2 |
                                 (first_to_clear + 3 < `BOARD_H && &`GET_ROW_FILL(cur_board, first_to_clear + 3)) << 3;

    assign num_to_clear = (pattern_to_clear >> 0 & 1) + 
                          (pattern_to_clear >> 1 & 1) + 
                          (pattern_to_clear >> 2 & 1) + 
                          (pattern_to_clear >> 3 & 1);

    wire[4:0] ref0 =  0 < first_to_clear ?  0 :
                      0 + (1 +
                        (first_to_clear + 1 <=  0 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  0 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  0 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref1 =  1 < first_to_clear ?  1 :
                      1 + (1 +
                        (first_to_clear + 1 <=  1 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  1 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  1 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref2 =  2 < first_to_clear ?  2 :
                      2 + (1 +
                        (first_to_clear + 1 <=  2 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  2 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  2 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref3 =  3 < first_to_clear ?  3 :
                      3 + (1 +
                        (first_to_clear + 1 <=  3 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  3 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  3 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref4 =  4 < first_to_clear ?  4 :
                      4 + (1 +
                        (first_to_clear + 1 <=  4 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  4 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  4 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref5 =  5 < first_to_clear ?  5 :
                      5 + (1 +
                        (first_to_clear + 1 <=  5 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  5 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  5 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref6 =  6 < first_to_clear ?  6 :
                      6 + (1 +
                        (first_to_clear + 1 <=  6 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  6 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  6 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref7 =  7 < first_to_clear ?  7 :
                      7 + (1 +
                        (first_to_clear + 1 <=  7 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  7 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  7 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref8 =  8 < first_to_clear ?  8 :
                      8 + (1 +
                        (first_to_clear + 1 <=  8 && pattern_to_clear >> 1 & 1) +
                        (first_to_clear + 2 <=  8 && pattern_to_clear >> 2 & 1) +
                        (first_to_clear + 3 <=  8 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref9 =  9 < first_to_clear ?  9 :
                      9 + (1 +
                         (first_to_clear + 1 <=  9 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <=  9 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <=  9 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref10 = 10 < first_to_clear ? 10 :
                      10 + (1 +
                         (first_to_clear + 1 <= 10 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 10 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 10 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref11 = 11 < first_to_clear ? 11 :
                      11 + (1 +
                         (first_to_clear + 1 <= 11 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 11 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 11 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref12 = 12 < first_to_clear ? 12 :
                      12 + (1 +
                         (first_to_clear + 1 <= 12 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 12 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 12 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref13 = 13 < first_to_clear ? 13 :
                      13 + (1 +
                         (first_to_clear + 1 <= 13 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 13 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 13 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref14 = 14 < first_to_clear ? 14 :
                      14 + (1 +
                         (first_to_clear + 1 <= 14 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 14 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 14 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref15 = 15 < first_to_clear ? 15 :
                      15 + (1 +
                         (first_to_clear + 1 <= 15 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 15 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 15 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref16 = 16 < first_to_clear ? 16 :
                      16 + (1 +
                         (first_to_clear + 1 <= 16 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 16 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 16 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref17 = 17 < first_to_clear ? 17 :
                      17 + (1 +
                         (first_to_clear + 1 <= 17 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 17 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 17 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref18 = 18 < first_to_clear ? 18 :
                      18 + (1 +
                         (first_to_clear + 1 <= 18 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 18 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 18 && pattern_to_clear >> 3 & 1));
    wire[4:0] ref19 = 19 < first_to_clear ? 19 :
                      19 + (1 +
                         (first_to_clear + 1 <= 19 && pattern_to_clear >> 1 & 1) +
                         (first_to_clear + 2 <= 19 && pattern_to_clear >> 2 & 1) +
                         (first_to_clear + 3 <= 19 && pattern_to_clear >> 3 & 1));
    
    assign new_board = {
                         ref19 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref19),
                         ref18 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref18),
                         ref17 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref17),
                         ref16 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref16),
                         ref15 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref15),
                         ref14 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref14),
                         ref13 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref13),
                         ref12 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref12),
                         ref11 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref11),
                         ref10 >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board, ref10),
                         ref9  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref9),
                         ref8  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref8),
                         ref7  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref7),
                         ref6  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref6),
                         ref5  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref5),
                         ref4  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref4),
                         ref3  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref3),
                         ref2  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref2),
                         ref1  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref1),
                         ref0  >= `BOARD_H ? 12'b0 : `GET_ROW_FILL(cur_board,  ref0)
                       };

endmodule