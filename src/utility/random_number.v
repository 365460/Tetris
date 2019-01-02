
module random_number #(
	parameter LENGTH = 3, 
	parameter FROM = 0,
	parameter TO = 7
)( 
	input wire rst,
	input wire clk,
	output reg [LENGTH-1:0] num
);   

	reg [LENGTH-1:0] num_nx;

	always@(posedge clk or posedge rst)begin
		if(rst) num <= FROM;
		else num <= num_nx;
	end

	always @(*) begin
		if( num == TO ) num_nx = FROM;
		else num_nx = num + 1;
	end

endmodule
