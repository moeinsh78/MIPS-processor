`timescale 1ns/1ns
module MIPS(input clk,init);
  wire [5:0]opcode,func;
  wire [2:0]ALUoperation;
  wire [1:0]ALUsrcB,PCsrc;
  wire zero,RegDst,WrSel,WdSel,ALUsrcA,MemtoReg,MemWrite,MemRead,RegWrite,IorD,IRWrite,PCWrite,BrFlag,PCWriteCond;
  controller CU(clk,init,opcode,func,zero,IorD,IRWrite,PCWrite,RegDst,WrSel,WdSel,RegWrite,ALUsrcA,MemtoReg,MemWrite,MemRead,BrFlag,PCWriteCond,ALUsrcB,PCsrc,ALUoperation);
  datapath DP(clk,init,MemRead,MemWrite,IorD,PCWriteCond,PCWrite,IRWrite,RegWrite,RegDst,WrSel,WdSel,MemtoReg,BrFlag,ALUsrcA,ALUsrcB,PCsrc,ALUoperation,zero,func,opcode);
endmodule


