`timescale 1ns/1ns
module superReg1(input [31:0]inputAdr,inputInst,input clk,Instld,clr,output reg [31:0]outputAdr,outputInst);
  always@(posedge clk) begin
    if(clr) outputInst <= 32'b00000000000000000000000000100000;
    else begin
      outputAdr <= inputAdr;
      if(Instld) outputInst <= inputInst; 
    end
  end
endmodule
