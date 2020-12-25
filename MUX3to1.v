`timescale 1ns/1ns
module MUX3to1(input [31:0]I1,[31:0]I2,[31:0]I3, input[1:0]s, output [31:0]muxOut);
  assign muxOut = (s == 2'b00)? I1 : (s == 2'b01)? I2 : (s == 2'b10)? I3 : 32'bx;
endmodule
