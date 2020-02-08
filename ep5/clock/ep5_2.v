
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module ep5_2(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5
	
);

	wire carry_s;
	wire carry_m;

//=======================================================
//  REG/WIRE declarations
//=======================================================

clock_second clk_sec(CLOCK_50, SW[6], SW[5:0], HEX0[6:0], HEX1[6:0], carry_s);
clock_minute clk_min(carry_s, SW[7], SW[5:0], HEX2[6:0], HEX3[6:0], carry_m);
clock_hour clk_h(carry_m, SW[8], SW[5:0], HEX4[6:0], HEX5[6:0]);

//=======================================================
//  Structural coding
//=======================================================



endmodule
