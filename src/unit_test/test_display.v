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
			`SET_BLOCK(board, 1, `BRICK_I);
			`SET_BLOCK(board, 2, `BRICK_J);
			`SET_BLOCK(board, 3, `BRICK_L);
			`SET_BLOCK(board, 4, `BRICK_O);
			`SET_BLOCK(board, 5, `BRICK_S);
			`SET_BLOCK(board, 6, `BRICK_T);
			`SET_BLOCK(board, 7, `BRICK_Z);

			`SET_BLOCK(board, 31, `BRICK_I);
			`SET_BLOCK(board, 32, `BRICK_J);
			`SET_BLOCK(board, 33, `BRICK_L);
			`SET_BLOCK(board, 34, `BRICK_O);
			`SET_BLOCK(board, 35, `BRICK_S);
			`SET_BLOCK(board, 36, `BRICK_T);
			`SET_BLOCK(board, 37, `BRICK_Z);
		end
	end

endmodule
