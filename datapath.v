`timescale 1ns/1ns

module datapath(input clk,PCinit,MemRead,MemWrite,IorD,PCWriteCond,PCWrite,IRWrite,RegWrite,RegDst,WRsel,WDsel,MemtoReg,BrFlag,
  ALUsrcA,input [1:0]ALUsrcB,PCSrc,input [2:0]ALUOperation,output ALUZero,output [5:0]func,opcode);
  
  wire PCld,cond;
  wire [4:0]WReg,DstReg;
  wire [31:0]InsOrData,MemOut,ALURegOut,PCOut,IROut,readData1,readData2,WData,MDROut,DatatoReg,ExtData;
  wire [31:0]AOut,BOut,ShiftedLabel,ALUOp1,ALUOp2,ALURes,NextPC;
  wire [27:0]ShiftedAdr; 
  
  and G1(cond,PCWriteCond,BrFlag);
  or G2(PCld,cond,PCWrite);
  PCreg PC(NextPC,PCld,clk,PCinit,PCOut);
  MUX32B MemMUX(PCOut,ALURegOut,IorD,InsOrData);
  Memory Mem(InsOrData,BOut,clk,MemRead,MemWrite,MemOut);
  Reg32BLdSig IR(clk,IRWrite,MemOut,IROut);
  Reg32B MDR(clk,MemOut,MDROut);
  MUX5B RegFileMUX1(IROut[20:16],IROut[15:11],RegDst,DstReg);
  MUX5B RegFileMUX2(DstReg,5'b11111,WRsel,WReg);
  MUX32B RegFileMUX3(ALURegOut,MDROut,MemtoReg,DatatoReg);
  MUX32B RegFileMUX4(DatatoReg,PCOut,WDsel,WData);
  RegFile RegFile(clk,RegWrite,IROut[25:21],IROut[20:16],WReg,WData,readData1,readData2);
  Reg32B AReg(clk,readData1,AOut);
  Reg32B BReg(clk,readData2,BOut);
  SignExtend SgnExt(IROut[15:0],ExtData);  
  ShiftL32 LabelShL(ExtData,ShiftedLabel);
  ShiftL26to28 ShjAdr(IROut[25:0],ShiftedAdr);
  MUX32B ALUMUX1(PCOut,readData1,ALUsrcA,ALUOp1);
  MUX4to1 ALUMUX2(readData2,32'b00000000000000000000000000000100,ExtData,ShiftedLabel,ALUsrcB,ALUOp2);
  ALU ALU(ALUOp1,ALUOp2,ALUOperation,ALUZero,ALURes);
  Reg32B ALUReg(clk,ALURes,ALURegOut);
  MUX4to1 PCReg(ALURes,ALURegOut,{PCOut[31:28],ShiftedAdr},AOut,PCSrc,NextPC);
  
  assign opcode = IROut[31:26];
  assign func = IROut[5:0];
endmodule
