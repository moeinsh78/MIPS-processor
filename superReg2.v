`timescale 1ns/1ns
module superReg2(input [8:0]cntIn,input [31:0]RDataIn1,RDataIn2,ExtDataIn,input [4:0]RtIn,RsIn,RdIn,input clk,
  output reg [8:0]cntOut,output reg [31:0]RDataOut1,RDataOut2,ExtDataOut,output reg [4:0]RtOut,RsOut,RdOut);
  always@(posedge clk) begin
    cntOut <= cntIn;
    RDataOut1 <= RDataIn1;
    RDataOut2 <= RDataIn2;
    ExtDataOut <= ExtDataIn;
    RtOut <= RtIn;
    RsOut <= RsIn;
    RdOut <= RdIn;
  end
endmodule
