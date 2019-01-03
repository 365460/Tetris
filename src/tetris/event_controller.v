`include "header.v"

module event_controller(
	input wire clk,                 // 100 MHZ
	input wire main_clk,
	input wire key_sensitive_clk,
	input wire rst,

	// keyboard
	inout PS2CLK,
	inout PS2DATA,

	input wire [`LEVEL_LEN-1:0] level,

	input wire[`EVENT_LEN-1:0] event_received,
	output reg[`EVENT_LEN-1:0] event_out
);

	wire [`KEY_PRESS_LEN-1:0] key_press_1plus;
	wire [8:0] last_change;
	wire fall_timeout;
	wire fall_rst;
	reg reset_fall_nx, reset_fall;

	reg [`EVENT_LEN-1:0] event_out_nx;

	keyboard inst_keyboard(
		.PS2CLK(PS2CLK),
		.PS2DATA(PS2DATA),
		.clk(clk),
		.rst(rst),
		.key_sensitive_clk(key_sensitive_clk),
		.clk_1plus(main_clk),
		.key_press_1plus(key_press_1plus),

		.last_change(last_change) 
	);

	fall inst_fall(
		.clk(clk), // 100MHZ
		.rst(fall_rst),
		.level(level),
		.timeout(fall_timeout)
	);

	assign fall_rst = rst | reset_fall;

	always @(posedge main_clk or posedge rst) begin
		if(rst) begin
			event_out <= 0;
			reset_fall <= 1;
		end
		else begin 
			event_out <= event_out_nx;
			reset_fall <= reset_fall_nx;
		end
	end

	always @(*) begin
		event_out_nx = event_out;
		reset_fall_nx = 0;

		if( event_received[`EVENT_KEY_UP] )    event_out_nx[`EVENT_KEY_UP] = 0;
		else if( key_press_1plus[`KEY_UP] )    event_out_nx[`EVENT_KEY_UP] = 1;

		if( event_received[`EVENT_KEY_DOWN] )  event_out_nx[`EVENT_KEY_DOWN] = 0;
		else if( key_press_1plus[`KEY_DOWN] )  event_out_nx[`EVENT_KEY_DOWN] = 1;

		if( event_received[`EVENT_KEY_RIGHT] ) event_out_nx[`EVENT_KEY_RIGHT] = 0;
		else if( key_press_1plus[`KEY_RIGHT] ) event_out_nx[`EVENT_KEY_RIGHT] = 1;

		if( event_received[`EVENT_KEY_LEFT] )  event_out_nx[`EVENT_KEY_LEFT] = 0;
		else if( key_press_1plus[`KEY_LEFT] )  event_out_nx[`EVENT_KEY_LEFT] = 1;

		if( event_received[`EVENT_KEY_SPACE] ) event_out_nx[`EVENT_KEY_SPACE] = 0;
		else if( key_press_1plus[`KEY_SPACE] ) event_out_nx[`EVENT_KEY_SPACE] = 1;

		if( event_received[`EVENT_FALL] )  begin
			event_out_nx[`EVENT_FALL] = 0;
			reset_fall_nx = 1;
		end
		else if( fall_timeout ) event_out_nx[`EVENT_FALL] = 1;
	end


endmodule
