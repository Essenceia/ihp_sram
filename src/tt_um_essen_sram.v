`default_nettype none

module tt_um_essen_sram (
`ifdef USE_POWER_PINS
	input wire VPWR,
	input wire VGND,
`endif 
	input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
	assign uio_oe = 8'h00;
	assign uio_out = 8'h00;

  reg en_q;
  always @(posedge clk or negedge rst_n)
    if (~rst_n)
		en_q <= 1'b0;
	else
		en_q <= ena;

	/* this is not some marvel of engineering */
	wire [7:0] r_data;
	reg [7:0] addr_q;
	reg r_en_q, w_en_q;
	reg [7:0] w_data_q, r_data_q;
	
	always @(posedge clk) begin
		if (~rst_n) begin
			r_en_q <= 1'b0;
			w_en_q <= 1'b0;
		end else begin
			r_en_q <= uio_in[6];
			w_en_q <= uio_in[7];
		end 
	end

	always @(posedge clk) begin
		addr_q <= {2'b0, uio_in[5:0]};
		w_data_q <= ui_in;
	end

RM_IHPSG13_1P_256x8_c3_bm_bist m_ihp_sram (
`ifdef USE_POWER_PINS
	.VDD(VPWR), // logic supply voltage
	.VSS(VGND), // logic ground
	.VDDARRAY(VPWR), // memory array supply voltage
`endif

    .A_CLK(clk),
    .A_MEN(en_q),
    .A_WEN(w_en_q),
    .A_REN(r_en_q),
    .A_ADDR(addr_q),
    .A_DIN(w_data_q),
    .A_DLY(1'b1),
    .A_DOUT(r_data),
    .A_BM(8'hFF),
    .A_BIST_CLK(1'b0),
    .A_BIST_EN(1'b0),
    .A_BIST_MEN(1'b0),
    .A_BIST_WEN(1'b0),
    .A_BIST_REN(1'b0),
    .A_BIST_ADDR(1'b0),
    .A_BIST_DIN(1'b0),
    .A_BIST_BM(1'b0)
);

	/* hold read data */ 
	reg r_valid_q;
	reg [7:0] data_out_q;
	always @(posedge clk) begin
		r_valid_q <= r_en_q;
		if (r_valid_q) 
			r_data_q <= r_data;
	end

	assign uo_out = r_data_q;
		
endmodule  // tt_um_factory_test
