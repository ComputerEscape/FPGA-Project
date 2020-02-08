
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module ep12_test(

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
	output		     [6:0]		HEX5,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// Audio //////////
	input 		          		AUD_ADCDAT,
	inout 		          		AUD_ADCLRCK,
	inout 		          		AUD_BCLK,
	output		          		AUD_DACDAT,
	inout 		          		AUD_DACLRCK,
	output		          		AUD_XCK,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2,

	//////////// I2C for Audio and Video-In //////////
	output		          		FPGA_I2C_SCLK,
	inout 		          		FPGA_I2C_SDAT
);

	wire carry_s;
	wire carry_m;
	wire [5:0] hour, min, sec;
	wire temp_clk;
	
	assign VGA_SYNC_N = 1'b0;
	
	
	wire clk_i2c;
	wire reset;
	wire [15:0] audiodata;
	wire [15:0] freq;
	
	wire [5:0] clock_res_hour, clock_res_min, clock_res_sec, alarm_res_hour, alarm_res_min, alarm_res_sec;
	
	wire [5:0] alarm_hour, alarm_min;

//=======================================================
//  REG/WIRE declarations
//=======================================================

clock_second clk_sec(CLOCK_50, SW[7], clock_res_sec, 
							SW[2:0], alarm_res_sec, 
							HEX0[6:0], HEX1[6:0], carry_s, sec, hour, min, alarm_hour, alarm_min, freq, SW[3]);

clock_minute clk_min(CLOCK_50, carry_s, SW[8], clock_res_min, 
							SW[2:0], alarm_res_min, 
							HEX2[6:0], HEX3[6:0], carry_m, min, alarm_min);

clock_hour clk_h(CLOCK_50, carry_m, SW[9], clock_res_hour, 
						SW[2:0], alarm_res_hour, 
						HEX4[6:0], HEX5[6:0], hour, alarm_hour);


picture my_pic(CLOCK2_50, 1'b0, 1'b1, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_R, VGA_G, VGA_B, hour, min, sec);


audio_clk u1(CLOCK_50, reset, AUD_XCK, LEDR[9]);


//I2C part
clkgen #(10000) my_i2c_clk(CLOCK_50,reset,1'b1,clk_i2c);  //10k I2C clock  


I2C_Audio_Config myconfig(clk_i2c, KEY[0],FPGA_I2C_SCLK,FPGA_I2C_SDAT,LEDR[2:0]);

I2S_Audio myaudio(AUD_XCK, KEY[0], AUD_BCLK, AUD_DACDAT, AUD_DACLRCK, audiodata);

Sin_Generator sin_wave(AUD_DACLRCK, KEY[0], freq, audiodata);//

keyboard my_k(CLOCK_50, PS2_CLK, PS2_DAT, 
					SW[9], SW[8], SW[7], clock_res_hour, clock_res_min, clock_res_sec, 
					SW[2], SW[1], SW[0], alarm_res_hour, alarm_res_min, alarm_res_sec);

//=======================================================
//  Structural coding
//=======================================================



endmodule
