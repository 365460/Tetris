`include "header.v"

module test_display(	
	input clk,
	input rst,		// btnc

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
		.cur_brick_type(-1),
		.cur_brick_pos(-1),
		.shadow_brick_pos(-1),
		.board(board),
		.vgaRed(vgaRed),
		.vgaGreen(vgaGreen),
		.vgaBlue(vgaBlue),
		.hsync(hsync),
		.vsync(vsync)
	);

	always @(posedge rst) begin
		if(rst == 1'b1) begin
			`SET_BLOCK_FILL(board, 1, 1);
			`SET_BLOCK_FILL(board, 2, 1);
			`SET_BLOCK_FILL(board, 3, 1);
			`SET_BLOCK_FILL(board, 4, 1);
			`SET_BLOCK_FILL(board, 5, 1);
			`SET_BLOCK_FILL(board, 6, 1);
			`SET_BLOCK_FILL(board, 7, 1);

			`SET_BLOCK_FILL(board, 31, 1);
			`SET_BLOCK_FILL(board, 32, 1);
			`SET_BLOCK_FILL(board, 33, 1);
			`SET_BLOCK_FILL(board, 34, 1);
			`SET_BLOCK_FILL(board, 35, 1);
			`SET_BLOCK_FILL(board, 36, 1);
			`SET_BLOCK_FILL(board, 37, 1);
		end
	end

endmodule
