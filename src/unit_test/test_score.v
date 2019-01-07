`include "header.v"

/* Keyboard mapping
* space: place the brick
* arrow: control the brick
*/
module test_score(	
	input clk,
	input rst,		// btnc

	// keyboard 
	inout PS2CLK,
	inout PS2DATA,

	input [15:0] SW,
	output [15:0] led,
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
	clock_divider #(.n(12)) inst_clk_div16(clk, clk_div16);
	clock_divider #(.n(13)) inst_clk_main(clk, main_clk);
	clock_divider #(.n(23)) inst_clk_key(clk, key_sensitive_clk);

	// btn: rst
	wire rst_depounced, rst_1plus;
	debounced inst_de_rst(.pb_debounced(rst_depounced), .pb(rst), .clk(clk_div16));
	oneplus inst_1plus_rst(.pb_debounced(rst_depounced), .pb_1pulse(rst_1plus), .clk(main_clk));

	reg [`BOARD_SIZE-1:0] board, board_nx; 

	wire [`POS_LEN-1:0] pos1, pos2, pos3, pos0;
	wire [`POS_LEN-1:0] spos1, spos2, spos3, spos0;
	wire [`BRICK_POS_LEN-1:0] brick_pos; // store the positions of the current brick
	wire [`BRICK_POS_LEN-1:0] shadow_brick_pos; // store the positions of the shadow brick

	reg [`POS_LEN-1:0] cur_pos, cur_pos_nx;
	reg [`BRICK_LEN-1:0] brick_type, brick_type_nx;
	reg [`DIR_LEN-1:0] dir, dir_nx;

	reg [`POS_LEN-1:0] try_pos, try_pos_nx;
	reg [`BRICK_LEN-1:0] try_brick_type, try_brick_type_nx;
	reg [`DIR_LEN-1:0] try_dir, try_dir_nx;

	wire [`POS_LEN-1:0] shadow_pos;

	reg [`BRICK_LEN-1:0] next_brick_type, next_brick_type_nx;
	wire [`BRICK_LEN-1:0] ra_brick_type;

	wire is_collided_nx, is_collided_next_nx;
	reg is_collided, is_collided_next;

	wire [4:0] num_to_clear;
	wire [`BOARD_SIZE-1:0] cleared_board;

    reg [13:0] score, score_nx; // score affects level, level affects speed
    reg [1:0] streaks, streaks_nx; // done x clears in a row, then score += [3, x].min + cleared_line
    reg [`LEVEL_LEN-1:0] cur_level;
	
	wire [`LEVEL_LEN-1:0] debug_level = {SW[3], SW[2], SW[1], SW[0]};
	always @(*) begin
		if( (score / 20) + debug_level < 16) cur_level = score/20 + debug_level;
		else if( (score/20) < 16) cur_level = score/20;
		else cur_level = 15;
	end

	reg [2:0] state, state_nx;

	localparam WAIT           = 3'd0;
	localparam CAL_POS        = 3'd1;
	localparam PLACE          = 3'd2;
	localparam CLEAR          = 3'd3;
	localparam GEN_NEW_BLOCK  = 3'd4;
	localparam JUDGE_GAMEOVER = 3'd5;
	localparam START          = 3'd6;

	reg [`EVENT_LEN-1:0] event_received, event_received_nx;
	wire [`EVENT_LEN-1:0] event_out;

	event_controller inst_event_controller(
		.clk(clk),                 // 100 MHZ
		.main_clk(main_clk),
		.key_sensitive_clk(key_sensitive_clk),
		.rst(rst_1plus),
		.PS2CLK(PS2CLK),
		.PS2DATA(PS2DATA),
		.level(cur_level),
		.event_received(event_received),
		.event_out(event_out)
	);

	wire[`STATE_LEN-1:0] display_state;
	assign display_state = (state == START? `START:`PLAYING);

	display display_inst(
		.clk(clk),
		.rst(rst),
		.state(display_state),

		.board(board),
		.cur_brick_type(brick_type),
		.cur_brick_pos(brick_pos),
		.shadow_brick_pos(shadow_brick_pos),
		.level(cur_level),

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
		.dig4(score / 1000),
		.dig3(score / 100 % 10),
		.dig2(score / 10 % 10),
		.dig1(score % 10)
	);

	brick inst_brick(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_pos)
	);

	brick inst_brick_shadow(
		.brick_type(brick_type),
		.dir(dir),
		.cur_pos(shadow_pos),
		.brick_pos(shadow_brick_pos)
	);

	drop inst_drop(
		 .cur_board(board),
		 .pos(cur_pos),
		 .brick_type(brick_type),
		 .dir(dir),
	  	 .new_pos(shadow_pos)
	);

	random_number #(.LENGTH(`BRICK_LEN-1), .FROM(1), .TO(7)) inst_random_number(
		.rst(rst_1plus),
		.clk(clk),
		.num(ra_brick_type)
	);

	collision_check inst_collision_check(
		.board(board),
		.pos(try_pos_nx),
		.brick_type(try_brick_type_nx),
		.dir(try_dir_nx),
		.is_collided(is_collided_nx)
	);

	collision_check inst_collision_check_next_block(
		.board(board),
		.pos(`NEW_BLOCK_POS),
		.brick_type(next_brick_type_nx),
		.dir(0),
		.is_collided(is_collided_next_nx)
	);
	
	clear inst_clear(
	     .cur_board(board),
	     .num_to_clear(num_to_clear),
	     .new_board(cleared_board)
	);

	assign pos0 = `BRICK_GET_POS(brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(brick_pos, 3);
	
	assign spos0 = `BRICK_GET_POS(shadow_brick_pos, 0);
    assign spos1 = `BRICK_GET_POS(shadow_brick_pos, 1);
    assign spos2 = `BRICK_GET_POS(shadow_brick_pos, 2);
    assign spos3 = `BRICK_GET_POS(shadow_brick_pos, 3);

	assign led[ 0] =  0 <= cur_level;
	assign led[ 1] =  1 <= cur_level;
	assign led[ 2] =  2 <= cur_level;
	assign led[ 3] =  3 <= cur_level;
	assign led[ 4] =  4 <= cur_level;
	assign led[ 5] =  5 <= cur_level;
	assign led[ 6] =  6 <= cur_level;
	assign led[ 7] =  7 <= cur_level;
	assign led[ 8] =  8 <= cur_level;
	assign led[ 9] =  9 <= cur_level;
	assign led[10] = 10 <= cur_level;
	assign led[11] = 11 <= cur_level;
	assign led[12] = 12 <= cur_level;
	assign led[13] = 13 <= cur_level;
	assign led[14] = 14 <= cur_level;
	assign led[15] = 15 <= cur_level;
                
	always @(posedge main_clk or posedge rst_1plus) begin
		if(rst_1plus == 1'b1) begin
			state <= START;

			board <= 0;

			is_collided <= 0;
			is_collided_next <= 0;

			cur_pos <= `MAKE_POS(6, 10);
			brick_type <= `BRICK_I;
			dir <= 0;

			try_pos <= `MAKE_POS(6, 10);
			try_brick_type <= `BRICK_I;
			try_dir <= 0;

			next_brick_type <= 1;

			event_received <= 0;

            score <= 0;
            streaks <= 0;
		end
		else begin
			state <= state_nx;

			board <= board_nx;

			is_collided <= is_collided_nx;
			is_collided_next <= is_collided_next_nx;

			cur_pos <= cur_pos_nx;
			brick_type <= brick_type_nx;
			dir <= dir_nx;

			try_pos <= try_pos_nx;
			try_brick_type <= try_brick_type_nx;
			try_dir <= try_dir_nx;

			next_brick_type <= next_brick_type_nx;

			event_received <= event_received_nx;

            score <= score_nx;
            streaks <= streaks_nx;
		end
	end

	always @(*) begin
		{cur_pos_nx, dir_nx, brick_type_nx} = {cur_pos, dir, brick_type};

		{try_pos_nx, try_dir_nx, try_brick_type_nx} = {cur_pos, dir, brick_type};

		state_nx = state;
		board_nx = board;

        score_nx = score;
        streaks_nx = streaks;

		next_brick_type_nx = next_brick_type;

		event_received_nx = 0;
		case(state) 
			START: begin
				if(event_out[`EVENT_KEY_SPACE]) begin
					event_received_nx[`EVENT_KEY_SPACE] = 1;

					state_nx = WAIT;
				end
			end
			WAIT: begin
				if(event_out[`EVENT_KEY_UP]) begin    // rotate the brick
					try_dir_nx = dir + 1;
					event_received_nx[`EVENT_KEY_UP] = 1;

					state_nx = CAL_POS;
				end
				else if(event_out[`EVENT_KEY_DOWN]) begin  // move
					try_pos_nx = `MAKE_POS(`GETX(cur_pos), `GETY(cur_pos)-1);
					event_received_nx[`EVENT_KEY_DOWN] = 1;

					state_nx = CAL_POS;
				end
				else if(event_out[`EVENT_KEY_RIGHT]) begin // move
					try_pos_nx = `MAKE_POS(`GETX(cur_pos_nx)+1, `GETY(cur_pos_nx));
					event_received_nx[`EVENT_KEY_RIGHT] = 1;

					state_nx = CAL_POS;
				end
				else if(event_out[`EVENT_KEY_LEFT]) begin  // move
					try_pos_nx = `MAKE_POS(`GETX(cur_pos_nx)-1, `GETY(cur_pos_nx));
					event_received_nx[`EVENT_KEY_LEFT] = 1;

					state_nx = CAL_POS;
				end
				else if(event_out[`EVENT_KEY_SPACE]) begin 
					event_received_nx[`EVENT_KEY_SPACE] = 1;

					state_nx = PLACE;
				end
				else if(event_out[`EVENT_FALL]) begin
					try_pos_nx = `MAKE_POS(`GETX(cur_pos), `GETY(cur_pos)-1);
					event_received_nx[`EVENT_FALL] = 1;

					state_nx = CAL_POS;
				end
			end

			CAL_POS: begin
				if(is_collided == 0) {cur_pos_nx, dir_nx, brick_type_nx} = {try_pos, try_dir, try_brick_type};
				state_nx = WAIT;
			end

			// place the current brick to the board
			PLACE: begin
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos0), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos1), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos2), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos3), 1); 

				state_nx = CLEAR;
			end

			CLEAR: begin
			    board_nx = cleared_board;
                score_nx = score + num_to_clear + streaks;
                streaks_nx = num_to_clear == 0 ? 0 : streaks < 3 ? streaks + 1 : 3;
			    state_nx = GEN_NEW_BLOCK;
			end

			GEN_NEW_BLOCK: begin
				next_brick_type_nx = ra_brick_type;
				state_nx = JUDGE_GAMEOVER;
			end

			JUDGE_GAMEOVER: begin
				if(is_collided_next) begin
					// game over
					board_nx = 0;
                    score_nx = 0;
                    streaks_nx = 0;
					{cur_pos_nx, dir_nx, brick_type_nx} = {`NEW_BLOCK_POS, `DIR_LEN'b0, next_brick_type};
					state_nx = START;
				end
				else begin
					{cur_pos_nx, dir_nx, brick_type_nx} = {`NEW_BLOCK_POS, `DIR_LEN'b0, next_brick_type};
					state_nx = WAIT;
				end

			end
		endcase
	end

endmodule
