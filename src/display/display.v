`include "header.v"

module display(
	input wire clk, // 100MHZ
	input wire rst,
	input wire[`STATE_LEN-1:0] state,
	input wire[`BOARD_SIZE-1:0] board,
	input wire[`BRICK_LEN-1:0] cur_brick_type,
	input wire[`BRICK_POS_LEN-1:0] cur_brick_pos,
	input wire[`BRICK_POS_LEN-1:0] shadow_brick_pos,
	input wire[`LEVEL_LEN-1:0] level,

	output reg [3:0] vgaRed,
	output reg [3:0] vgaGreen,
	output reg [3:0] vgaBlue,
	output wire hsync,
	output wire vsync
);

	wire clk_25MHZ;
	clock_divider #(.n(2)) inst_div2(clk, clk_25MHZ);

	wire valid;
	wire [9:0] x_cnt; //640
    wire [9:0] y_cnt;  //480

    vga_controller vga_inst(
      .pclk(clk_25MHZ),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(x_cnt),
      .v_cnt(y_cnt)
    );

	wire [3:0] vgaRed_playing, vgaGreen_playing, vgaBlue_playing;
	display_playing playing(
		.clk(clk),
		.rst(rst),
		.board(board),
		.x_cnt(x_cnt),
		.y_cnt(y_cnt),
		.cur_brick_type(cur_brick_type),
		.cur_brick_pos(cur_brick_pos),
		.shadow_brick_pos(shadow_brick_pos),
		.level(level),
		.vgaRed(vgaRed_playing),
		.vgaGreen(vgaGreen_playing),
		.vgaBlue(vgaBlue_playing)
	);

	wire [3:0] vgaRed_start, vgaGreen_start, vgaBlue_start;
	display_start start(
		.clk(clk),
		.rst(rst),
		.x_cnt(x_cnt),
		.y_cnt(y_cnt),
		.vgaRed(vgaRed_start),
		.vgaGreen(vgaGreen_start),
		.vgaBlue(vgaBlue_start)
	);

	always @(*) begin
		case(state) 
			`START: begin
				{vgaRed, vgaGreen, vgaBlue} = {vgaRed_start, vgaGreen_start, vgaBlue_start};
			end
			`PLAYING: begin
				{vgaRed, vgaGreen, vgaBlue} = {vgaRed_playing, vgaGreen_playing, vgaBlue_playing};
			end
		endcase
	end

endmodule
