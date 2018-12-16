`include "header.v"

module test_show_bricks(	
	input clk,
	input rst,		// btnc
	input btnU,
	input btnD,
	input btnL,
	input btnR,

	// keyboard 
	inout wire PS2CLK,
	input wire PS2DATA,

	// vga 
	output wire [3:0] vgaRed,
	output wire [3:0] vgaGreen,
	output wire [3:0] vgaBlue,
	output wire hsync,
	output wire vsync
);

	reg [`BOARD_SIZE-1:0] board;
	wire[`STATE_LEN-1:0] state = `PLAYING;

	display display_inst(
		.clk(clk),
		.rst(rst),
		.state(state),
		.board(board),
		.vgaRed(vgaRed),
		.vgaGreen(vgaGreen),
		.vgaBlue(vgaBlue),
		.hsync(hsync),
		.vsync(vsync)
	);

	wire clk_div16, clk_div22;
	clock_divider #(.n(16)) inst_div16(clk, clk_div16);
	clock_divider #(.n(22)) inst_div22(clk, clk_div22);

	// btn: rst
	wire rst_depounced, rst_1plus;
	debounced inst_de_rst(.pb_debounced(rst_depounced), .pb(rst), .clk(clk_div16));
	oneplus inst_1plus_rst(.pb_debounced(rst_depounced), .pb_1pulse(rst_1plus), .clk(clk_div22));

	// btn: btnD
	wire btnD_depounced, btnD_1plus;
	debounced inst_de_btnD(.pb_debounced(btnD_depounced), .pb(btnD), .clk(clk_div16));
	oneplus inst_1plus_btnD(.pb_debounced(btnD_depounced), .pb_1pulse(btnD_1plus), .clk(clk_div22));

	// btn: btnU
	wire btnU_depounced, btnU_1plus;
	debounced inst_de_btnU(.pb_debounced(btnU_depounced), .pb(btnU), .clk(clk_div16));
	oneplus inst_1plus_btnU(.pb_debounced(btnU_depounced), .pb_1pulse(btnU_1plus), .clk(clk_div22));

	// btn: btnL
	wire btnL_depounced, btnL_1plus;
	debounced inst_de_btnL(.pb_debounced(btnL_depounced), .pb(btnL), .clk(clk_div16));
	oneplus inst_1plus_btnL(.pb_debounced(btnL_depounced), .pb_1pulse(btnL_1plus), .clk(clk_div22));

	// btn: btnR
	wire btnR_depounced, btnR_1plus;
	debounced inst_de_btnR(.pb_debounced(btnR_depounced), .pb(btnR), .clk(clk_div16));
	oneplus inst_1plus_btnR(.pb_debounced(btnR_depounced), .pb_1pulse(btnR_1plus), .clk(clk_div22));

	reg [`BRICK_LEN-1:0] brick_type, brick_type_nx;
	reg [`DIR_LEN-1:0] dir, dir_nx;

	always @(posedge clk_div22, posedge rst_1plus) begin
		if(rst_1plus == 1'b1) begin
			brick_type <= `BRICK_I;
			dir <= 0;
		end
		else begin
			brick_type <= brick_type_nx;
			dir <= dir_nx;
		end
	end

	always @(*) begin
		dir_nx = dir;
		brick_type_nx = brick_type;

		if(btnU_1plus) begin
			brick_type_nx = brick_type==7? 1:brick_type + 1;
		end
		if(btnD_1plus) begin
			brick_type_nx = brick_type==1? 7:brick_type - 1;
		end

		if(btnL_1plus) begin
			dir_nx = dir==3? 0:dir + 1;
		end
		if(btnR_1plus) begin
			dir_nx = dir==0? 3:dir - 1;
		end
	end

	wire [`POS_LEN-1:0] cur_pos = `MAKE_POS(6, 10);
	wire [`POS_LEN-1:0] pos1, pos2, pos3, pos0;
	wire [`BRICK_POS_LEN-1:0] brick_pos;

	brick(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_pos)
	);

	assign pos0 = `BRICK_GET_POS(brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(brick_pos, 3);

	always @(*) begin
		board = 0;
		board[`POS2EXP(pos0)] = brick_type;
		board[`POS2EXP(pos1)] = brick_type;
		board[`POS2EXP(pos2)] = brick_type;
		board[`POS2EXP(pos3)] = brick_type;
	end
endmodule
