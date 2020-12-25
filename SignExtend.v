`timescale 1ns/1ns
module SignExtend(input [15:0]A, output [31:0]Res);
  assign Res = A[15] ? {16'b1111111111111111,A} : {16'b0000000000000000,A};
endmodule
