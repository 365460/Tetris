`include "header.v"

module display_start(
	input wire [9:0] x_cnt,
	input wire [9:0] y_cnt,

	output reg [3:0] vgaRed,
	output reg [3:0] vgaGreen,
	output reg [3:0] vgaBlue
);

	//TODO
	always@(*) begin
	    {vgaRed, vgaGreen, vgaBlue} = {x_cnt * 3 + 2*y_cnt};
    end
endmodule

