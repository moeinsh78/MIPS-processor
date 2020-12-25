`timescale 1ns/1ns
module MUX32B(input [31:0]I1,[31:0]I2, input s, output [31:0]muxOut);
  assign muxOut = s ? I2 : I1;
endmodule
