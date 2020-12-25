`timescale 1ns/1ns
module MUX9B(input [8:0]I1,[8:0]I2, input s, output [8:0]muxOut);
  assign muxOut = s ? I2 : I1;
endmodule
