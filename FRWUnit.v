`timescale 1ns/1ns
module FRWUnit(input [4:0]EX_Rs,EX_Rt,MEM_WReg,WB_WReg, input MEM_RegWrite,WB_RegWrite, output reg [1:0]FrwA, FrwB);
  reg Flag1,Flag2;
  always@(EX_Rs,MEM_WReg,WB_WReg,MEM_RegWrite,WB_RegWrite) begin
    FrwA = 2'b00;
    Flag1 = 0;
    if(MEM_RegWrite == 1 && MEM_WReg == EX_Rs && MEM_WReg != 5'b0) begin
      Flag1 = 1'b1;
      FrwA = 2'b01;
    end 
    if(WB_RegWrite == 1 && WB_WReg == EX_Rs && WB_WReg != 5'b0 && Flag1 == 0) begin
      FrwA = 2'b10;
    end
  end
  
  always@(EX_Rt,MEM_WReg,WB_WReg,MEM_RegWrite,WB_RegWrite) begin
    FrwB = 2'b00;
    Flag2 = 0;
    if(MEM_RegWrite == 1 && MEM_WReg == EX_Rt && MEM_WReg != 5'b0) begin
      Flag2 = 1'b1;
      FrwB = 2'b01;
    end 
    if(WB_RegWrite == 1 && WB_WReg == EX_Rt && WB_WReg != 5'b0 && Flag2 == 0) begin
      FrwB = 2'b10;
    end
  end
endmodule
