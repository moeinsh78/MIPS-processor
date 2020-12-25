`timescale 1ns/1ns
module datapath(input clk,PCinit,RegWrite,RegDst,WRsel,WDsel,ALUsrc,PCsrc,jsel,jrsel,MemRead,MemWrite,MemtoReg,
  input [2:0]ALUoperation,output ALUZero,output [5:0]func,opcode);
  wire [31:0]nextPC,PCAdd,nextAdd,Instruction,readData1,readData2,WData,ExtData,ALUop2,ALUres;
  wire [31:0]ShiftedLabel,LabelAdr,PC1,PC2,data,DatatoReg;
  wire [27:0]ShiftedAdr; 
  wire [4:0]WReg,DstReg;
  PCreg PC(nextPC,clk,PCinit,PCAdd);
  Add32B AddPC(PCAdd,32'b00000000000000000000000000000100,nextAdd);
  InstMem InstMem(PCAdd,Instruction);
  MUX5B RegFileMUX1(Instruction[20:16],Instruction[15:11],RegDst,DstReg);
  MUX5B RegFileMUX2(DstReg,5'b11111,WRsel,WReg);
  MUX32B RegFileMUX3(ALUres,data,MemtoReg,DatatoReg);
  MUX32B RegFileMUX4(nextAdd,DatatoReg,WDsel,WData);
  RegFile RegFile(clk,RegWrite,Instruction[25:21],Instruction[20:16],WReg,WData,readData1,readData2);
  SignExtend SgnExt(Instruction[15:0],ExtData);
  MUX32B ALUMUX(readData2,ExtData,ALUsrc,ALUop2);
  ALU ALU(readData1,ALUop2,ALUoperation,ALUZero,ALUres);
  ShiftL26to28 ShjAdr(Instruction[25:0],ShiftedAdr);
  ShiftL32 ShBrAdr(ExtData,ShiftedLabel);
  Add32B BranchAdd(nextAdd,ShiftedLabel,LabelAdr);
  MUX32B PCMUX1(nextAdd,LabelAdr,PCsrc,PC1);
  MUX32B PCMUX2(PC1,{PC1[31:28],ShiftedAdr},jsel,PC2);
  MUX32B PCMUX3(PC2,readData1,jrsel,nextPC);
  DataMem DataMem(ALUres,readData2,clk,MemRead,MemWrite,data);
  assign opcode = Instruction[31:26];
  assign func = Instruction[5:0];
endmodule
