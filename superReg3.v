`timescale 1ns/1ns
module superReg3(input [3:0]cntIn,input [31:0]ALUResIn,WDataIn,input [4:0]DstRegIn,input clk,
  output reg [3:0]cntOut,output reg [31:0]ALUResOut,WDataOut,output reg [4:0]DstRegOut);
  always@(posedge clk) begin
    cntOut <= cntIn;
    ALUResOut <= ALUResIn;
    WDataOut <= WDataIn;
    DstRegOut <= DstRegIn;
  end
endmodule
