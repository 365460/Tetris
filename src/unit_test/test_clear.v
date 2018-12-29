`include "header.v"

/* Keyboard mapping
* space: place the brick
* arrow: control the brick
* right_1, right_3: change the brick type and direction
*/
module test_clear(	
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
	clock_divider #(.n(13)) inst_div16(clk, clk_div16);
	clock_divider #(.n(15)) inst_div22(clk, main_clk);
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

	wire is_collided_nx;
	reg is_collided;

	localparam WAIT    = 2'd1;
	localparam CAL_POS = 2'd0;
	localparam PLACE   = 2'd2;
	localparam CLEAR   = 2'd3;

	reg [1:0] state, state_nx;

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

	assign pos0 = `BRICK_GET_POS(brick_pos, 0);
	assign pos1 = `BRICK_GET_POS(brick_pos, 1);
	assign pos2 = `BRICK_GET_POS(brick_pos, 2);
	assign pos3 = `BRICK_GET_POS(brick_pos, 3);
	
	assign spos0 = `BRICK_GET_POS(shadow_brick_pos, 0);
    assign spos1 = `BRICK_GET_POS(shadow_brick_pos, 1);
    assign spos2 = `BRICK_GET_POS(shadow_brick_pos, 2);
    assign spos3 = `BRICK_GET_POS(shadow_brick_pos, 3);

	display display_inst(
		.clk(clk),
		.rst(rst),
		.state(`PLAYING),
		.board(board),
		.cur_brick_type(brick_type),
		.cur_brick_pos(brick_pos),
		.shadow_brick_pos(shadow_brick_pos),
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
		.board(board),
		.pos(try_pos_nx),
		.brick_type(try_brick_type_nx),
		.dir(try_dir_nx),
		.is_collided(is_collided_nx)
	);
	
	wire[4:0] num_to_clear;
	wire[`BOARD_SIZE-1:0] cleared_board;
	
	clear inst_clear(
	     .cur_board(board),
	     .num_to_clear(num_to_clear),
	     .new_board(cleared_board)
	);

	assign led[4] = !is_collided;

	always @(posedge main_clk or posedge rst_1plus) begin
		if(rst_1plus == 1'b1) begin
			state <= WAIT;

			board <= 0;

			is_collided <= 0;

			cur_pos <= `MAKE_POS(6, 10);
			brick_type <= `BRICK_I;
			dir <= 0;

			try_pos <= `MAKE_POS(6, 10);
			try_brick_type <= `BRICK_I;
			try_dir <= 0;

		end
		else begin
			state <= state_nx;

			board <= board_nx;

			is_collided <= is_collided_nx;

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
		board_nx = board;

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

			// place the current brick to the board
			PLACE: begin
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos0), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos1), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos2), 1); 
				`SET_BLOCK_FILL(board_nx, `POS2ID(spos3), 1); 

				state_nx = CLEAR;
				// generate the new brick ( we haven't checked if the position of the new brick is valid. )
				
			end
			CLEAR: begin
			    state_nx = WAIT;
			    board_nx = cleared_board;
			    {cur_pos_nx, dir_nx, brick_type_nx} = {`MAKE_POS(6, 18), `DIR_LEN'b0, `BRICK_I};
			end
		endcase
	end

endmodule
