 // This code assumes that `BOARD_H = 20
`include "header.v"

module clear(
	input wire[`BOARD_SIZE-1:0] cur_board,
    output wire[4:0] num_to_clear,
	output wire[`BOARD_SIZE-1:0] new_board
);
    
    wire filled0 = &`GET_ROW_FILL(cur_board, 0);
    wire filled1 = &`GET_ROW_FILL(cur_board, 1);
    wire filled2 = &`GET_ROW_FILL(cur_board, 2);
    wire filled3 = &`GET_ROW_FILL(cur_board, 3);
    wire filled4 = &`GET_ROW_FILL(cur_board, 4);
    wire filled5 = &`GET_ROW_FILL(cur_board, 5);
    wire filled6 = &`GET_ROW_FILL(cur_board, 6);
    wire filled7 = &`GET_ROW_FILL(cur_board, 7);
    wire filled8 = &`GET_ROW_FILL(cur_board, 8);
    wire filled9 = &`GET_ROW_FILL(cur_board, 9);
    wire filled10 = &`GET_ROW_FILL(cur_board, 10);
    wire filled11 = &`GET_ROW_FILL(cur_board, 11);
    wire filled12 = &`GET_ROW_FILL(cur_board, 12);
    wire filled13 = &`GET_ROW_FILL(cur_board, 13);
    wire filled14 = &`GET_ROW_FILL(cur_board, 14);
    wire filled15 = &`GET_ROW_FILL(cur_board, 15);
    wire filled16 = &`GET_ROW_FILL(cur_board, 16);
    wire filled17 = &`GET_ROW_FILL(cur_board, 17);
    wire filled18 = &`GET_ROW_FILL(cur_board, 18);
    wire filled19 = &`GET_ROW_FILL(cur_board, 19);
    
    assign num_to_clear = filled0 + filled1 + filled2 + filled3 + filled4 + filled5 + filled6 + filled7 + filled8 + filled9 + filled10 + filled11 + filled12 + filled13 + filled14 + filled15 + filled16 + filled17 + filled18 + filled19;
    
    wire[4:0] ref0 = !filled0 ? 0 : !filled1 ? 1 : !filled2 ? 2 : !filled3 ? 3 : !filled4 ? 4 :
                     !filled5 ? 5 : !filled6 ? 6 : !filled7 ? 7 : !filled8 ? 8 : !filled9 ? 9 :
                     !filled10 ? 10 : !filled11 ? 11 : !filled12 ? 12 : !filled13 ? 13 : !filled14 ? 14 :
                     !filled15 ? 15 : !filled16 ? 16 : !filled17 ? 17 : !filled18 ? 18 : !filled19 ? 19 : 20;
    wire[4:0] ref1 = !filled0 && ref0 < 0 ? 0 : !filled1 && ref0 < 1 ? 1 : !filled2 && ref0 < 2 ? 2 : !filled3 && ref0 < 3 ? 3 : !filled4 && ref0 < 4 ? 4 : !filled5 && ref0 < 5 ? 5 : !filled6 && ref0 < 6 ? 6 : !filled7 && ref0 < 7 ? 7 : !filled8 && ref0 < 8 ? 8 : !filled9 && ref0 < 9 ? 9 : !filled10 && ref0 < 10 ? 10 : !filled11 && ref0 < 11 ? 11 : !filled12 && ref0 < 12 ? 12 : !filled13 && ref0 < 13 ? 13 : !filled14 && ref0 < 14 ? 14 : !filled15 && ref0 < 15 ? 15 : !filled16 && ref0 < 16 ? 16 : !filled17 && ref0 < 17 ? 17 : !filled18 && ref0 < 18 ? 18 : !filled19 && ref0 < 19 ? 19 : 20;
    wire[4:0] ref2 = !filled0 && ref1 < 0 ? 0 : !filled1 && ref1 < 1 ? 1 : !filled2 && ref1 < 2 ? 2 : !filled3 && ref1 < 3 ? 3 : !filled4 && ref1 < 4 ? 4 : !filled5 && ref1 < 5 ? 5 : !filled6 && ref1 < 6 ? 6 : !filled7 && ref1 < 7 ? 7 : !filled8 && ref1 < 8 ? 8 : !filled9 && ref1 < 9 ? 9 : !filled10 && ref1 < 10 ? 10 : !filled11 && ref1 < 11 ? 11 : !filled12 && ref1 < 12 ? 12 : !filled13 && ref1 < 13 ? 13 : !filled14 && ref1 < 14 ? 14 : !filled15 && ref1 < 15 ? 15 : !filled16 && ref1 < 16 ? 16 : !filled17 && ref1 < 17 ? 17 : !filled18 && ref1 < 18 ? 18 : !filled19 && ref1 < 19 ? 19 : 20;
    wire[4:0] ref3 = !filled0 && ref2 < 0 ? 0 : !filled1 && ref2 < 1 ? 1 : !filled2 && ref2 < 2 ? 2 : !filled3 && ref2 < 3 ? 3 : !filled4 && ref2 < 4 ? 4 : !filled5 && ref2 < 5 ? 5 : !filled6 && ref2 < 6 ? 6 : !filled7 && ref2 < 7 ? 7 : !filled8 && ref2 < 8 ? 8 : !filled9 && ref2 < 9 ? 9 : !filled10 && ref2 < 10 ? 10 : !filled11 && ref2 < 11 ? 11 : !filled12 && ref2 < 12 ? 12 : !filled13 && ref2 < 13 ? 13 : !filled14 && ref2 < 14 ? 14 : !filled15 && ref2 < 15 ? 15 : !filled16 && ref2 < 16 ? 16 : !filled17 && ref2 < 17 ? 17 : !filled18 && ref2 < 18 ? 18 : !filled19 && ref2 < 19 ? 19 : 20;
    wire[4:0] ref4 = !filled0 && ref3 < 0 ? 0 : !filled1 && ref3 < 1 ? 1 : !filled2 && ref3 < 2 ? 2 : !filled3 && ref3 < 3 ? 3 : !filled4 && ref3 < 4 ? 4 : !filled5 && ref3 < 5 ? 5 : !filled6 && ref3 < 6 ? 6 : !filled7 && ref3 < 7 ? 7 : !filled8 && ref3 < 8 ? 8 : !filled9 && ref3 < 9 ? 9 : !filled10 && ref3 < 10 ? 10 : !filled11 && ref3 < 11 ? 11 : !filled12 && ref3 < 12 ? 12 : !filled13 && ref3 < 13 ? 13 : !filled14 && ref3 < 14 ? 14 : !filled15 && ref3 < 15 ? 15 : !filled16 && ref3 < 16 ? 16 : !filled17 && ref3 < 17 ? 17 : !filled18 && ref3 < 18 ? 18 : !filled19 && ref3 < 19 ? 19 : 20;
    wire[4:0] ref5 = !filled0 && ref4 < 0 ? 0 : !filled1 && ref4 < 1 ? 1 : !filled2 && ref4 < 2 ? 2 : !filled3 && ref4 < 3 ? 3 : !filled4 && ref4 < 4 ? 4 : !filled5 && ref4 < 5 ? 5 : !filled6 && ref4 < 6 ? 6 : !filled7 && ref4 < 7 ? 7 : !filled8 && ref4 < 8 ? 8 : !filled9 && ref4 < 9 ? 9 : !filled10 && ref4 < 10 ? 10 : !filled11 && ref4 < 11 ? 11 : !filled12 && ref4 < 12 ? 12 : !filled13 && ref4 < 13 ? 13 : !filled14 && ref4 < 14 ? 14 : !filled15 && ref4 < 15 ? 15 : !filled16 && ref4 < 16 ? 16 : !filled17 && ref4 < 17 ? 17 : !filled18 && ref4 < 18 ? 18 : !filled19 && ref4 < 19 ? 19 : 20;
    wire[4:0] ref6 = !filled0 && ref5 < 0 ? 0 : !filled1 && ref5 < 1 ? 1 : !filled2 && ref5 < 2 ? 2 : !filled3 && ref5 < 3 ? 3 : !filled4 && ref5 < 4 ? 4 : !filled5 && ref5 < 5 ? 5 : !filled6 && ref5 < 6 ? 6 : !filled7 && ref5 < 7 ? 7 : !filled8 && ref5 < 8 ? 8 : !filled9 && ref5 < 9 ? 9 : !filled10 && ref5 < 10 ? 10 : !filled11 && ref5 < 11 ? 11 : !filled12 && ref5 < 12 ? 12 : !filled13 && ref5 < 13 ? 13 : !filled14 && ref5 < 14 ? 14 : !filled15 && ref5 < 15 ? 15 : !filled16 && ref5 < 16 ? 16 : !filled17 && ref5 < 17 ? 17 : !filled18 && ref5 < 18 ? 18 : !filled19 && ref5 < 19 ? 19 : 20;
    wire[4:0] ref7 = !filled0 && ref6 < 0 ? 0 : !filled1 && ref6 < 1 ? 1 : !filled2 && ref6 < 2 ? 2 : !filled3 && ref6 < 3 ? 3 : !filled4 && ref6 < 4 ? 4 : !filled5 && ref6 < 5 ? 5 : !filled6 && ref6 < 6 ? 6 : !filled7 && ref6 < 7 ? 7 : !filled8 && ref6 < 8 ? 8 : !filled9 && ref6 < 9 ? 9 : !filled10 && ref6 < 10 ? 10 : !filled11 && ref6 < 11 ? 11 : !filled12 && ref6 < 12 ? 12 : !filled13 && ref6 < 13 ? 13 : !filled14 && ref6 < 14 ? 14 : !filled15 && ref6 < 15 ? 15 : !filled16 && ref6 < 16 ? 16 : !filled17 && ref6 < 17 ? 17 : !filled18 && ref6 < 18 ? 18 : !filled19 && ref6 < 19 ? 19 : 20;
    wire[4:0] ref8 = !filled0 && ref7 < 0 ? 0 : !filled1 && ref7 < 1 ? 1 : !filled2 && ref7 < 2 ? 2 : !filled3 && ref7 < 3 ? 3 : !filled4 && ref7 < 4 ? 4 : !filled5 && ref7 < 5 ? 5 : !filled6 && ref7 < 6 ? 6 : !filled7 && ref7 < 7 ? 7 : !filled8 && ref7 < 8 ? 8 : !filled9 && ref7 < 9 ? 9 : !filled10 && ref7 < 10 ? 10 : !filled11 && ref7 < 11 ? 11 : !filled12 && ref7 < 12 ? 12 : !filled13 && ref7 < 13 ? 13 : !filled14 && ref7 < 14 ? 14 : !filled15 && ref7 < 15 ? 15 : !filled16 && ref7 < 16 ? 16 : !filled17 && ref7 < 17 ? 17 : !filled18 && ref7 < 18 ? 18 : !filled19 && ref7 < 19 ? 19 : 20;
    wire[4:0] ref9 = !filled0 && ref8 < 0 ? 0 : !filled1 && ref8 < 1 ? 1 : !filled2 && ref8 < 2 ? 2 : !filled3 && ref8 < 3 ? 3 : !filled4 && ref8 < 4 ? 4 : !filled5 && ref8 < 5 ? 5 : !filled6 && ref8 < 6 ? 6 : !filled7 && ref8 < 7 ? 7 : !filled8 && ref8 < 8 ? 8 : !filled9 && ref8 < 9 ? 9 : !filled10 && ref8 < 10 ? 10 : !filled11 && ref8 < 11 ? 11 : !filled12 && ref8 < 12 ? 12 : !filled13 && ref8 < 13 ? 13 : !filled14 && ref8 < 14 ? 14 : !filled15 && ref8 < 15 ? 15 : !filled16 && ref8 < 16 ? 16 : !filled17 && ref8 < 17 ? 17 : !filled18 && ref8 < 18 ? 18 : !filled19 && ref8 < 19 ? 19 : 20;
    wire[4:0] ref10 = !filled0 && ref9 < 0 ? 0 : !filled1 && ref9 < 1 ? 1 : !filled2 && ref9 < 2 ? 2 : !filled3 && ref9 < 3 ? 3 : !filled4 && ref9 < 4 ? 4 : !filled5 && ref9 < 5 ? 5 : !filled6 && ref9 < 6 ? 6 : !filled7 && ref9 < 7 ? 7 : !filled8 && ref9 < 8 ? 8 : !filled9 && ref9 < 9 ? 9 : !filled10 && ref9 < 10 ? 10 : !filled11 && ref9 < 11 ? 11 : !filled12 && ref9 < 12 ? 12 : !filled13 && ref9 < 13 ? 13 : !filled14 && ref9 < 14 ? 14 : !filled15 && ref9 < 15 ? 15 : !filled16 && ref9 < 16 ? 16 : !filled17 && ref9 < 17 ? 17 : !filled18 && ref9 < 18 ? 18 : !filled19 && ref9 < 19 ? 19 : 20;
    wire[4:0] ref11 = !filled0 && ref10 < 0 ? 0 : !filled1 && ref10 < 1 ? 1 : !filled2 && ref10 < 2 ? 2 : !filled3 && ref10 < 3 ? 3 : !filled4 && ref10 < 4 ? 4 : !filled5 && ref10 < 5 ? 5 : !filled6 && ref10 < 6 ? 6 : !filled7 && ref10 < 7 ? 7 : !filled8 && ref10 < 8 ? 8 : !filled9 && ref10 < 9 ? 9 : !filled10 && ref10 < 10 ? 10 : !filled11 && ref10 < 11 ? 11 : !filled12 && ref10 < 12 ? 12 : !filled13 && ref10 < 13 ? 13 : !filled14 && ref10 < 14 ? 14 : !filled15 && ref10 < 15 ? 15 : !filled16 && ref10 < 16 ? 16 : !filled17 && ref10 < 17 ? 17 : !filled18 && ref10 < 18 ? 18 : !filled19 && ref10 < 19 ? 19 : 20;
    wire[4:0] ref12 = !filled0 && ref11 < 0 ? 0 : !filled1 && ref11 < 1 ? 1 : !filled2 && ref11 < 2 ? 2 : !filled3 && ref11 < 3 ? 3 : !filled4 && ref11 < 4 ? 4 : !filled5 && ref11 < 5 ? 5 : !filled6 && ref11 < 6 ? 6 : !filled7 && ref11 < 7 ? 7 : !filled8 && ref11 < 8 ? 8 : !filled9 && ref11 < 9 ? 9 : !filled10 && ref11 < 10 ? 10 : !filled11 && ref11 < 11 ? 11 : !filled12 && ref11 < 12 ? 12 : !filled13 && ref11 < 13 ? 13 : !filled14 && ref11 < 14 ? 14 : !filled15 && ref11 < 15 ? 15 : !filled16 && ref11 < 16 ? 16 : !filled17 && ref11 < 17 ? 17 : !filled18 && ref11 < 18 ? 18 : !filled19 && ref11 < 19 ? 19 : 20;
    wire[4:0] ref13 = !filled0 && ref12 < 0 ? 0 : !filled1 && ref12 < 1 ? 1 : !filled2 && ref12 < 2 ? 2 : !filled3 && ref12 < 3 ? 3 : !filled4 && ref12 < 4 ? 4 : !filled5 && ref12 < 5 ? 5 : !filled6 && ref12 < 6 ? 6 : !filled7 && ref12 < 7 ? 7 : !filled8 && ref12 < 8 ? 8 : !filled9 && ref12 < 9 ? 9 : !filled10 && ref12 < 10 ? 10 : !filled11 && ref12 < 11 ? 11 : !filled12 && ref12 < 12 ? 12 : !filled13 && ref12 < 13 ? 13 : !filled14 && ref12 < 14 ? 14 : !filled15 && ref12 < 15 ? 15 : !filled16 && ref12 < 16 ? 16 : !filled17 && ref12 < 17 ? 17 : !filled18 && ref12 < 18 ? 18 : !filled19 && ref12 < 19 ? 19 : 20;
    wire[4:0] ref14 = !filled0 && ref13 < 0 ? 0 : !filled1 && ref13 < 1 ? 1 : !filled2 && ref13 < 2 ? 2 : !filled3 && ref13 < 3 ? 3 : !filled4 && ref13 < 4 ? 4 : !filled5 && ref13 < 5 ? 5 : !filled6 && ref13 < 6 ? 6 : !filled7 && ref13 < 7 ? 7 : !filled8 && ref13 < 8 ? 8 : !filled9 && ref13 < 9 ? 9 : !filled10 && ref13 < 10 ? 10 : !filled11 && ref13 < 11 ? 11 : !filled12 && ref13 < 12 ? 12 : !filled13 && ref13 < 13 ? 13 : !filled14 && ref13 < 14 ? 14 : !filled15 && ref13 < 15 ? 15 : !filled16 && ref13 < 16 ? 16 : !filled17 && ref13 < 17 ? 17 : !filled18 && ref13 < 18 ? 18 : !filled19 && ref13 < 19 ? 19 : 20;
    wire[4:0] ref15 = !filled0 && ref14 < 0 ? 0 : !filled1 && ref14 < 1 ? 1 : !filled2 && ref14 < 2 ? 2 : !filled3 && ref14 < 3 ? 3 : !filled4 && ref14 < 4 ? 4 : !filled5 && ref14 < 5 ? 5 : !filled6 && ref14 < 6 ? 6 : !filled7 && ref14 < 7 ? 7 : !filled8 && ref14 < 8 ? 8 : !filled9 && ref14 < 9 ? 9 : !filled10 && ref14 < 10 ? 10 : !filled11 && ref14 < 11 ? 11 : !filled12 && ref14 < 12 ? 12 : !filled13 && ref14 < 13 ? 13 : !filled14 && ref14 < 14 ? 14 : !filled15 && ref14 < 15 ? 15 : !filled16 && ref14 < 16 ? 16 : !filled17 && ref14 < 17 ? 17 : !filled18 && ref14 < 18 ? 18 : !filled19 && ref14 < 19 ? 19 : 20;
    wire[4:0] ref16 = !filled0 && ref15 < 0 ? 0 : !filled1 && ref15 < 1 ? 1 : !filled2 && ref15 < 2 ? 2 : !filled3 && ref15 < 3 ? 3 : !filled4 && ref15 < 4 ? 4 : !filled5 && ref15 < 5 ? 5 : !filled6 && ref15 < 6 ? 6 : !filled7 && ref15 < 7 ? 7 : !filled8 && ref15 < 8 ? 8 : !filled9 && ref15 < 9 ? 9 : !filled10 && ref15 < 10 ? 10 : !filled11 && ref15 < 11 ? 11 : !filled12 && ref15 < 12 ? 12 : !filled13 && ref15 < 13 ? 13 : !filled14 && ref15 < 14 ? 14 : !filled15 && ref15 < 15 ? 15 : !filled16 && ref15 < 16 ? 16 : !filled17 && ref15 < 17 ? 17 : !filled18 && ref15 < 18 ? 18 : !filled19 && ref15 < 19 ? 19 : 20;
    wire[4:0] ref17 = !filled0 && ref16 < 0 ? 0 : !filled1 && ref16 < 1 ? 1 : !filled2 && ref16 < 2 ? 2 : !filled3 && ref16 < 3 ? 3 : !filled4 && ref16 < 4 ? 4 : !filled5 && ref16 < 5 ? 5 : !filled6 && ref16 < 6 ? 6 : !filled7 && ref16 < 7 ? 7 : !filled8 && ref16 < 8 ? 8 : !filled9 && ref16 < 9 ? 9 : !filled10 && ref16 < 10 ? 10 : !filled11 && ref16 < 11 ? 11 : !filled12 && ref16 < 12 ? 12 : !filled13 && ref16 < 13 ? 13 : !filled14 && ref16 < 14 ? 14 : !filled15 && ref16 < 15 ? 15 : !filled16 && ref16 < 16 ? 16 : !filled17 && ref16 < 17 ? 17 : !filled18 && ref16 < 18 ? 18 : !filled19 && ref16 < 19 ? 19 : 20;
    wire[4:0] ref18 = !filled0 && ref17 < 0 ? 0 : !filled1 && ref17 < 1 ? 1 : !filled2 && ref17 < 2 ? 2 : !filled3 && ref17 < 3 ? 3 : !filled4 && ref17 < 4 ? 4 : !filled5 && ref17 < 5 ? 5 : !filled6 && ref17 < 6 ? 6 : !filled7 && ref17 < 7 ? 7 : !filled8 && ref17 < 8 ? 8 : !filled9 && ref17 < 9 ? 9 : !filled10 && ref17 < 10 ? 10 : !filled11 && ref17 < 11 ? 11 : !filled12 && ref17 < 12 ? 12 : !filled13 && ref17 < 13 ? 13 : !filled14 && ref17 < 14 ? 14 : !filled15 && ref17 < 15 ? 15 : !filled16 && ref17 < 16 ? 16 : !filled17 && ref17 < 17 ? 17 : !filled18 && ref17 < 18 ? 18 : !filled19 && ref17 < 19 ? 19 : 20;
    wire[4:0] ref19 = !filled0 && ref18 < 0 ? 0 : !filled1 && ref18 < 1 ? 1 : !filled2 && ref18 < 2 ? 2 : !filled3 && ref18 < 3 ? 3 : !filled4 && ref18 < 4 ? 4 : !filled5 && ref18 < 5 ? 5 : !filled6 && ref18 < 6 ? 6 : !filled7 && ref18 < 7 ? 7 : !filled8 && ref18 < 8 ? 8 : !filled9 && ref18 < 9 ? 9 : !filled10 && ref18 < 10 ? 10 : !filled11 && ref18 < 11 ? 11 : !filled12 && ref18 < 12 ? 12 : !filled13 && ref18 < 13 ? 13 : !filled14 && ref18 < 14 ? 14 : !filled15 && ref18 < 15 ? 15 : !filled16 && ref18 < 16 ? 16 : !filled17 && ref18 < 17 ? 17 : !filled18 && ref18 < 18 ? 18 : !filled19 && ref18 < 19 ? 19 : 20;

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
