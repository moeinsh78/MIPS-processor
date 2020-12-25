`timescale 1ns/1ns
module superReg4(input [1:0]cntIn,input [31:0]ALUResIn,dataIn,input [4:0]DstRegIn,input clk,
  output reg [1:0]cntOut,output reg [31:0]ALUResOut,dataOut,output reg [4:0]DstRegOut);
  always@(posedge clk) begin
    cntOut <= cntIn;
    ALUResOut <= ALUResIn;
    dataOut <= dataIn;
    DstRegOut <= DstRegIn;
  end
endmodule

