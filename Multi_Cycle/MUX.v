module mux_2_to_1 (a, b, sel, w);
  input [31:0] a, b;
  input sel;
  output reg [31:0] w;
  assign w = sel ? b : a;
endmodule

module mux_3_to_1 (a, b, c, sel, w);
  input [31:0] a, b, c;
  input [1:0] sel;
  output reg [31:0] w;
  
  always @(a, b, c, sel) begin
	case (sel)
		2'b00: w <= a;
		2'b01: w <= b;
		2'b10: w <= c;
		default: w <= 32'bz;
	endcase
  end

endmodule

module mux_4_to_1 (a, b, c, d, sel, w);
  input [31:0] a, b, c, d;
  input [1:0] sel;
  output reg [31:0] w;
  
  always @(a, b, c, d, sel) begin
	case (sel)
		2'b00: w <= a;
		2'b01: w <= b;
		2'b10: w <= c;
		2'b11: w <= d;
		default: w <= 32'bz;
	endcase
  end
endmodule
