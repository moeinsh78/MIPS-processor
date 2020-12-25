`timescale 1ns/1ns
module MIPS(input clk,PCinit);
  wire [5:0]opcode,func;
  wire [2:0]ALUoperation;
  wire RegDst,ALUsrc,MemtoReg,MemWrite,MemRead,jsel,RegWrite,PCsrc,eq,clr;
  controller CU(opcode,func,PCinit,eq,RegDst,ALUsrc,MemWrite,MemRead,MemtoReg,RegWrite,jsel,PCsrc,clr,ALUoperation);
  datapath DP(clk,PCinit,PCsrc,jsel,RegDst,ALUsrc,MemWrite,MemRead,MemtoReg,RegWrite,clr,ALUoperation,func,opcode,eq);
endmodule
