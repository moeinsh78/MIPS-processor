`timescale 1ns/1ns
module ShiftL26to28(input [25:0]inp, output [27:0]res);
  assign res = {inp,2'b00};
endmodule
