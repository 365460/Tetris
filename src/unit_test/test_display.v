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
		.board(board),
		.vgaRed(vgaRed),
		.vgaGreen(vgaGreen),
		.vgaBlue(vgaBlue),
		.hsync(hsync),
		.vsync(vsync)
	);

	always @(posedge rst) begin
		if(rst == 1'b1) begin
			`SET_BLOCK_TYPE(board, 1, `BRICK_I);
			`SET_BLOCK_TYPE(board, 2, `BRICK_J);
			`SET_BLOCK_TYPE(board, 3, `BRICK_L);
			`SET_BLOCK_TYPE(board, 4, `BRICK_O);
			`SET_BLOCK_TYPE(board, 5, `BRICK_S);
			`SET_BLOCK_TYPE(board, 6, `BRICK_T);
			`SET_BLOCK_TYPE(board, 7, `BRICK_Z);

			`SET_BLOCK_TYPE(board, 31, `BRICK_I);
			`SET_BLOCK_TYPE(board, 32, `BRICK_J);
			`SET_BLOCK_TYPE(board, 33, `BRICK_L);
			`SET_BLOCK_TYPE(board, 34, `BRICK_O);
			`SET_BLOCK_TYPE(board, 35, `BRICK_S);
			`SET_BLOCK_TYPE(board, 36, `BRICK_T);
			`SET_BLOCK_TYPE(board, 37, `BRICK_Z);
		end
	end

endmodule
