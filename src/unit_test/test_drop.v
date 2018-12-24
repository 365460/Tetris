`include "header.v"

/* Keyboard mapping
* space: place the brick
* arrow: control the brick
* right_1, right_3: change the brick type and direction
*/
module test_collision(	
	input clk,
	input rst,		// btnc

	// keyboard 
	inout PS2CLK,
	inout PS2DATA,

	output[4:0] led,
	output [3:0] DIGIT,
	output [6:0] DISPLAY,

	// vga 
	output wire [3:0] vgaRed,
	output wire [3:0] vgaGreen,
	output wire [3:0] vgaBlue,
	output wire hsync,
	output wire vsync
);
	wire main_clk, clk_div16, key_sensitive_clk;
	clock_divider #(.n(16)) inst_div16(clk, clk_div16);
	clock_divider #(.n(18)) inst_div22(clk, main_clk);
	clock_divider #(.n(23)) inst_div23(clk, key_sensitive_clk);

	// btn: rst
	wire rst_depounced, rst_1plus;
	debounced inst_de_rst(.pb_debounced(rst_depounced), .pb(rst), .clk(clk_div16));
	oneplus inst_1plus_rst(.pb_debounced(rst_depounced), .pb_1pulse(rst_1plus), .clk(main_clk));

	wire [`KEY_PRESS_LEN-1:0] key_press_1plus;
	assign led[0] = key_press_1plus[`KEY_UP];
	assign led[1] = key_press_1plus[`KEY_DOWN];
	assign led[2] = key_press_1plus[`KEY_LEFT];
	assign led[3] = key_press_1plus[`KEY_RIGHT];
	//assign led[4] = key_press_1plus[`KEY_SPACE];

	wire [8:0] last_change;
	keyboard key(
		.PS2CLK(PS2CLK),
		.PS2DATA(PS2DATA),
		.clk(clk),
		.rst(rst_1plus),
		.key_sensitive_clk(key_sensitive_clk),
		.clk_1plus(main_clk),
		.key_press_1plus(key_press_1plus),

		.last_change(last_change) // for debug
	);

	reg [`BOARD_SIZE-1:0] board_to, board_to_nx;  // store the placed bricks
	reg [`BOARD_SIZE-1:0] board; // board_to + current brick(unplaced)

	wire [`POS_LEN-1:0] pos1, pos2, pos3, pos0;
	wire [`BRICK_POS_LEN-1:0] brick_pos; // store the positions of the current brick

	reg[`POS_LEN-1:0] cur_pos, cur_pos_nx;
	reg [`BRICK_LEN-1:0] brick_type, brick_type_nx;
	reg [`DIR_LEN-1:0] dir, dir_nx;

	reg[`POS_LEN-1:0] try_pos, try_pos_nx;
	reg [`BRICK_LEN-1:0] try_brick_type, try_brick_type_nx;
	reg [`DIR_LEN-1:0] try_dir, try_dir_nx;

	wire is_collided_nx;
	reg is_collided;

    wire drop_shift_nx;
    reg drop_shift;

	localparam WAIT    = 2'd1;
	localparam CAL_POS = 2'd0;
	localparam PLACE   = 2'd2;

	reg [1:0] state, state_nx;

	brick inst_brick(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_pos)
	);

	assign pos0 = `BRICK_GET_POS(brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(brick_pos, 3);

    assign spos0 = pos0 - drop_shift * 32;
    assign spos1 = pos1 - drop_shift * 32;
    assign spos2 = pos2 - drop_shift * 32;
    assign spos3 = pos3 - drop_shift * 32;

	// add the current brick to the board
	always @(*) begin
		board = board_to;
		`PLACE_BLOCKS_TO_BOARD(board, `POS2ID(pos0), `POS2ID(pos1), `POS2ID(pos2), `POS2ID(pos3), brick_type);
	end

	display display_inst(
		.clk(clk),
		.rst(rst),
		.state(`PLAYING),
		.board(board), // board = board_to + current brick
		.vgaRed(vgaRed),
		.vgaGreen(vgaGreen),
		.vgaBlue(vgaBlue),
		.hsync(hsync),
		.vsync(vsync)
	);

	seven_segment seven(
		.DISPLAY(DISPLAY),
		.DIGIT(DIGIT),
		.clk(clk_div16),
		.dig1(last_change[0 +: 4]),
		.dig2(last_change[4 +: 4]),
		.dig3({3'b0, last_change[8]}),
		.dig4(state)
	);

	collision_check inst_collision_check(
		.board(board_to),
		.pos(try_pos_nx),
		.brick_type(try_brick_type_nx),
		.dir(try_dir_nx),
		.is_collided(is_collided_nx)
	);

    drop inst_drop(
        .cur_board(board_to),
        .pos(try_pos_nx),
        .brick_type(try_brick_type_nx),
        .dir(try_dir_nx),
        .new_pos(drop_shift_nx)
    );

	assign led[4] = !is_collided;

	always @(posedge main_clk or posedge rst_1plus) begin
		if(rst_1plus == 1'b1) begin
			state <= WAIT;

			board_to <= 0;

			is_collided <= 0;
            
            drop_shift <= 0;

			cur_pos <= `MAKE_POS(6, 10);
			brick_type <= `BRICK_I;
			dir <= 0;

			try_pos<= `MAKE_POS(6, 10);
			try_brick_type <= `BRICK_I;
			try_dir <= 0;
		end
		else begin
			state <= state_nx;

			board_to <= board_to_nx;

			is_collided <= is_collided_nx;

            drop_shift <= drop_shift_nx;

			cur_pos <= cur_pos_nx;
			brick_type <= brick_type_nx;
			dir <= dir_nx;

			try_pos <= try_pos_nx;
			try_brick_type <= try_brick_type_nx;
			try_dir <= try_dir_nx;
		end
	end

	always @(*) begin
		{cur_pos_nx, dir_nx, brick_type_nx} = {cur_pos, dir, brick_type};

		{try_pos_nx, try_dir_nx, try_brick_type_nx} = {cur_pos, dir, brick_type};

		state_nx = state;
		board_to_nx = board_to;

		case(state) 
			WAIT: begin
				if(key_press_1plus[`KEY_UP]) begin 
					try_pos_nx = `MAKE_POS(`GETX(cur_pos), `GETY(cur_pos)+1);
					state_nx = CAL_POS;
				end
				if(key_press_1plus[`KEY_DOWN]) begin 
					try_pos_nx = `MAKE_POS(`GETX(cur_pos), `GETY(cur_pos)-1);
					state_nx = CAL_POS;
				end
				if(key_press_1plus[`KEY_RIGHT]) begin 
					try_pos_nx = `MAKE_POS(`GETX(cur_pos_nx)+1, `GETY(cur_pos_nx));
					state_nx = CAL_POS;
				end
				if(key_press_1plus[`KEY_LEFT]) begin 
					try_pos_nx = `MAKE_POS(`GETX(cur_pos_nx)-1, `GETY(cur_pos_nx));
					state_nx = CAL_POS;
				end
				if(key_press_1plus[`KEY_RIGHT_1]) begin
					try_dir_nx = dir+1;
					state_nx = CAL_POS;
				end
				if(key_press_1plus[`KEY_RIGHT_3]) begin
					state_nx = CAL_POS;
					if(brick_type == 7) try_brick_type_nx = 1;
					else try_brick_type_nx = brick_type + 1;
				end
				if(key_press_1plus[`KEY_SPACE]) state_nx = PLACE;
			end

			CAL_POS: begin
				if(is_collided == 0) {cur_pos_nx, dir_nx, brick_type_nx} = {try_pos, try_dir, try_brick_type};
				state_nx = WAIT;
			end

			// place the current brick to the board_to
			PLACE: begin
				`PLACE_BLOCKS_TO_BOARD(board_to_nx, `POS2ID(spos0), `POS2ID(spos1), `POS2ID(spos2), `POS2ID(spos3), brick_type);

				state_nx = WAIT;
				// generate the new brick ( we haven't checked if the position of the new brick is valid. )
				{cur_pos_nx, dir_nx, brick_type_nx} = {`MAKE_POS(6, 18), `DIR_LEN'b0, `BRICK_I};
			end
		endcase
	end

endmodule
