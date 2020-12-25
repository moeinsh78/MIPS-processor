`timescale 1ns/1ns
module MIPS(input clk,PCinit);
  wire [5:0]opcode,func;
  wire [2:0]ALUoperation;
  wire zero,RegDst,WrSel,WdSel,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,RegWrite,PCsrc;
  controller CU(opcode,func,zero,RegDst,WrSel,WdSel,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,RegWrite,PCsrc,ALUoperation);
  datapath DP(clk,PCinit,RegWrite,RegDst,WrSel,WdSel,ALUsrc,PCsrc,JSel,JrSel,MemRead,MemWrite,MemtoReg,ALUoperation,zero,func,opcode);
endmodule
