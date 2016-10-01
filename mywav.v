`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mywav(
	clk50M,
	
	wav_data,
	myvalid,
	
	DACLRC,
	BCLK,
	DACDAT,
	
	I2C_SCLK,
	I2C_SDAT
);
/* tin hieu dau vao */
input 	clk50M;
input [15:0] wav_data;
input 	DACLRC;
input 	BCLK;

/* tin hieu dau ra */
output 	DACDAT;
output 	I2C_SCLK;
output myvalid;

/* tin hieu vao - ra*/
inout 	I2C_SDAT;

wire	rst_n;

// cai dat tre 65536*20ns
reset_delay	reset_delay_inst(
	.clock_50m(clk50M),
	.rst_n(rst_n));

// cau hinh thanh ghi WA8731
reg_config	reg_config_inst(
	.clock_50m(clk50M),
	.reset_n(rst_n),
	.i2c_sdat(I2C_SDAT),
	.i2c_sclk(I2C_SCLK)
	);

//gui du lieu am thanh ,right justified, 16bits

sinwave_gen sinwave_gen_inst(
	.clock_50M(clk50M),
	.wav_data(wav_data),
	.dacclk(DACLRC),
	.bclk(BCLK),
	.dacdat(DACDAT),
	.myvalid(myvalid)
	);

endmodule
