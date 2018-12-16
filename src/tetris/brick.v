`include "header.v"

module brick(
	input wire[`BRICK_LEN-1:0] brick_type,
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output wire[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [`BRICK_POS_LEN*7-1:0] brick_POSs;

	brick_I brickI(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_I-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_J brickJ(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_J-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_L brickL(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_L-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_O brickO(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_O-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_S brickS(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_S-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_T brickT(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_T-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	brick_Z brickZ(
		.dir(dir),
		.cur_pos(cur_pos),
		.brick_pos(brick_POSs[(`BRICK_Z-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN])
	);

	assign brick_pos = brick_POSs[(brick_type-1)*`BRICK_POS_LEN +: `BRICK_POS_LEN];

endmodule

/*
() => cur_pos
         dir = 0,2      dir = 1,3
      * * (*) *           *
						 (*)
						  *			
                          *
*/
module brick_I(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg [`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0, 2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-2, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y));
			end
			1, 3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x, y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x, y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x, y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x, y-2));
			end
		endcase
	end

endmodule

/*
      dir = 0     dir = 1     dir = 2      dir =3
      * (*) *        *                       * *
		    *       (*)        *()          (*)
                   * *         * * *         *
*/
module brick_J(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
			1: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x-1, y-1));
			end
			2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y-1));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
			3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x+1, y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
		endcase
	end
endmodule

/*
      dir = 0     dir = 1     dir = 2      dir =3
      * (*) *      * *                       *  
      *	            (*)         () *        (*)
                     *         * * *         * *
*/
module brick_L(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x-1, y-1));
			end
			1: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
			2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y-1));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
			3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
		endcase
	end
endmodule

/*
      dir = 0,1,2,3
      * (*)      
      *	 *
*/
module brick_O(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0,1,2,3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x-1, y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
		endcase
	end
endmodule

/*
      dir = 0,2     dir = 1,3 
        (*) *        *       
      *	 *           * (*)     
                        *     
*/
module brick_S(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0,2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x-1, y-1));
			end
			1,3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
		endcase
	end
endmodule

/*
      dir = 0,2     dir = 1,3 
      * (*)              *   
      	 *  *         * (*)
                      *        
*/
module brick_Z(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0,2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
			1,3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x-1, y-1));
			end
		endcase
	end
endmodule

/*
      dir = 0     dir = 1     dir = 2      dir =3
                    *                        *  
      *(*)*       *(*)         (*)          (*)*
        *           *         * * *          *  
*/
module brick_T(
	input wire[`DIR_LEN-1:0] dir,
	input wire[`POS_LEN-1:0] cur_pos,

	output reg[`BRICK_POS_LEN-1:0] brick_pos
);

	wire [4:0] x = `GETX(cur_pos);
	wire [4:0] y = `GETY(cur_pos);

	always @(*) begin
		case(dir)
			0: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
			1: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
			2: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x-1, y-1));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x,   y-1));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x+1, y-1));
			end
			3: begin
				`BRICK_SET_POS(brick_pos, 0, `MAKE_POS(x,   y+1));
				`BRICK_SET_POS(brick_pos, 1, `MAKE_POS(x,   y));
				`BRICK_SET_POS(brick_pos, 2, `MAKE_POS(x+1, y));
				`BRICK_SET_POS(brick_pos, 3, `MAKE_POS(x,   y-1));
			end
		endcase
	end
endmodule
