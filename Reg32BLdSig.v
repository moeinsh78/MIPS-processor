`timescale 1ns/1ns
module Reg32BLdSig(input clk,ld,input [31:0]RegIn, output reg [31:0]RegOut);
  always@(posedge clk) begin
    if(ld) RegOut <= RegIn;
  end
endmodule


