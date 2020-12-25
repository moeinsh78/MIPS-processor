`timescale 1ns/1ns
module Reg32B(input clk,input [31:0]RegIn, output reg [31:0]RegOut);
  always@(posedge clk) begin
    RegOut <= RegIn;
  end
endmodule
