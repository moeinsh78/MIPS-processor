`timescale 1ns/1ns
module MUX4to1(input [31:0]I1,[31:0]I2,[31:0]I3,[31:0]I4, input [1:0]s, output reg [31:0]muxOut);
  always@(s,I1,I2,I3,I4) begin
    case(s)
      2'b00: muxOut = I1;
      2'b01: muxOut = I2;
      2'b10: muxOut = I3;
      2'b11: muxOut = I4;
    endcase
  end
endmodule
