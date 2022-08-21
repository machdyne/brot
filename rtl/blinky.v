// BROT BLINKY

module blinky
#(
)
(

	input CLK_48,

	output LED_R,
	output LED_G,
	output LED_B,

	output reg PMOD_A1,
	output reg PMOD_A2,
	output reg PMOD_A3,
	output reg PMOD_A4,
	output reg PMOD_A7,
	output reg PMOD_A8,
	output reg PMOD_A9,
	output reg PMOD_A10,

	output reg PMOD_B1,
	output reg PMOD_B2,
	output reg PMOD_B3,
	output reg PMOD_B4,
	output reg PMOD_B7,
	output reg PMOD_B8,
	output reg PMOD_B9,
	output reg PMOD_B10,

);

	wire clk;
	wire clkslow;

	assign clk = CLK_48;

	reg [31:0] counter = 0;

	assign PMOD_A1 = counter[28];
	assign PMOD_A2 = counter[27];
	assign PMOD_A3 = counter[26];
	assign PMOD_A4 = counter[25];
	assign PMOD_A7 = counter[24];
	assign PMOD_A8 = counter[23];
	assign PMOD_A9 = counter[22];
	assign PMOD_A10 = counter[21];

	assign PMOD_B1 = counter[28];
	assign PMOD_B2 = counter[27];
	assign PMOD_B3 = counter[26];
	assign PMOD_B4 = counter[25];
	assign PMOD_B7 = counter[24];
	assign PMOD_B8 = counter[23];
	assign PMOD_B9 = counter[22];
	assign PMOD_B10 = counter[21];

   reg [12:0] clkslow_ctr;
   wire clkslow = clkslow_ctr[12];

   always @(posedge clk) begin
		counter = counter + 1;
      clkslow_ctr <= clkslow_ctr + 1;
   end

   reg [11:0] led_counter = 0;
   assign LED_R = ~led_counter[11];
   assign LED_G = ~led_counter[12];
   assign LED_B = ~led_counter[13];

   always @(posedge clkslow) begin
      led_counter <= led_counter + 1;
   end

endmodule
