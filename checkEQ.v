`timescale 1ns/1ns
module checkEQ(input [31:0]A,[31:0]B, output isEqual);
  assign isEqual = (A == B)? 1'b1 : 1'b0;
endmodule
