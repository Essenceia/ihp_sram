module RM_IHPSG13_1P_256x8_c3_bm_bist (
`ifdef USE_POWER_PINS
	VDD,
	VSS,
	VDDARRAY,
`endif
    A_CLK,
    A_MEN,
    A_WEN,
    A_REN,
    A_ADDR,
    A_DIN,
    A_DLY,
    A_DOUT,
    A_BM,
    A_BIST_CLK,
    A_BIST_EN,
    A_BIST_MEN,
    A_BIST_WEN,
    A_BIST_REN,
    A_BIST_ADDR,
    A_BIST_DIN,
    A_BIST_BM
);
`ifdef USE_POWER_PINS
	input VDD;
	input VSS;
	input VDDARRAY;
`endif
    input A_CLK;
    input A_MEN;
    input A_WEN;
    input A_REN;
    input [7:0] A_ADDR;
    input [7:0] A_DIN;
    input A_DLY;
    output [7:0] A_DOUT;
    input [7:0] A_BM;
    input A_BIST_CLK;
    input A_BIST_EN;
    input A_BIST_MEN;
    input A_BIST_WEN;
    input A_BIST_REN;
    input [7:0] A_BIST_ADDR;
    input [7:0] A_BIST_DIN;
    input [7:0] A_BIST_BM;

endmodule
