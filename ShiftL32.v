`timescale 1ns/1ns
module ShiftL32(input [31:0]inp, output [31:0]res);
  assign res = {inp[29:0],2'b00};
endmodule
