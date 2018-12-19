`include "header.v"
/*
*
* IF WANT TO ADD THE NEW MAPPING, MODIFY header.v TOO.
*
* */
module keyboard(
	inout PS2CLK,
	inout PS2DATA,
	input clk,	// 100MHZ
	input rst,
	input key_sensitive_clk,
	input clk_1plus,

	output wire [`KEY_PRESS_LEN-1:0] key_press_1plus,
	output wire [8:0] last_change
);
	reg [3:0] key_num;
	wire [511:0] key_down;
	//wire [8:0] last_change;
	wire been_ready;

	KeyboardDecoder keyboard_decorded(
		.key_down(key_down),
		.last_change(last_change),
	 	.key_valid(been_ready),
		.PS2_DATA(PS2DATA),
		.PS2_CLK(PS2CLK),
		.rst(rst),
		.clk(clk)
    );

	wire [`KEY_PRESS_LEN-1:0] key_press;
	assign key_press[`KEY_UP]    = (key_down[last_change] && last_change == `KEY_UP_CODE);
	assign key_press[`KEY_DOWN]  = (key_down[last_change] && last_change == `KEY_DOWN_CODE);
	assign key_press[`KEY_LEFT]  = (key_down[last_change] && last_change == `KEY_LEFT_CODE);
	assign key_press[`KEY_RIGHT] = (key_down[last_change] && last_change == `KEY_RIGHT_CODE);
	assign key_press[`KEY_SPACE] = (key_down[last_change] && last_change == `KEY_SPACE_CODE);
	assign key_press[`KEY_RIGHT_1] = (key_down[last_change] && last_change == `KEY_RIGHT_1_CODE);
	assign key_press[`KEY_RIGHT_3] = (key_down[last_change] && last_change == `KEY_RIGHT_3_CODE);

	reg [`KEY_PRESS_LEN-1:0] key_press_input, key_press_input_nx;
	oneplus inst_1plus_1(.pb_debounced(key_press_input[`KEY_UP]),   .pb_1pulse(key_press_1plus[`KEY_UP]),   .clk(clk_1plus));
	oneplus inst_1plus_2(.pb_debounced(key_press_input[`KEY_DOWN]), .pb_1pulse(key_press_1plus[`KEY_DOWN]), .clk(clk_1plus));
	oneplus inst_1plus_3(.pb_debounced(key_press_input[`KEY_LEFT]), .pb_1pulse(key_press_1plus[`KEY_LEFT]), .clk(clk_1plus));
	oneplus inst_1plus_4(.pb_debounced(key_press_input[`KEY_RIGHT]),.pb_1pulse(key_press_1plus[`KEY_RIGHT]),.clk(clk_1plus));
	oneplus inst_1plus_5(.pb_debounced(key_press_input[`KEY_SPACE]),.pb_1pulse(key_press_1plus[`KEY_SPACE]),.clk(clk_1plus));
	oneplus inst_1plus_6(.pb_debounced(key_press_input[`KEY_RIGHT_1]),.pb_1pulse(key_press_1plus[`KEY_RIGHT_1]),.clk(clk_1plus));
	oneplus inst_1plus_7(.pb_debounced(key_press_input[`KEY_RIGHT_3]),.pb_1pulse(key_press_1plus[`KEY_RIGHT_3]),.clk(clk_1plus));

	always @(posedge key_sensitive_clk or posedge rst) begin
		if(rst) key_press_input <= 0;
		else key_press_input <= key_press_input_nx;
	end

	always @(*) begin
		key_press_input_nx = 0;
		if(key_press[`KEY_UP]    && key_press_input[`KEY_UP]    == 0) key_press_input_nx[`KEY_UP]    = 1;
		if(key_press[`KEY_DOWN]  && key_press_input[`KEY_DOWN]  == 0) key_press_input_nx[`KEY_DOWN]  = 1;
		if(key_press[`KEY_LEFT]  && key_press_input[`KEY_LEFT]  == 0) key_press_input_nx[`KEY_LEFT]  = 1;
		if(key_press[`KEY_RIGHT] && key_press_input[`KEY_RIGHT] == 0) key_press_input_nx[`KEY_RIGHT] = 1;
		if(key_press[`KEY_SPACE] && key_press_input[`KEY_SPACE] == 0) key_press_input_nx[`KEY_SPACE] = 1;
		if(key_press[`KEY_RIGHT_1] && key_press_input[`KEY_RIGHT_1] == 0) key_press_input_nx[`KEY_RIGHT_1] = 1;
		if(key_press[`KEY_RIGHT_3] && key_press_input[`KEY_RIGHT_3] == 0) key_press_input_nx[`KEY_RIGHT_3] = 1;
	end

endmodule
