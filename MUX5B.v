`timescale 1ns/1ns
module MUX5B(input [4:0]I1,[4:0]I2, input s, output [4:0]muxOut);
  assign muxOut = s ? I2 : I1;
endmodule
