`timescale 1ns/1ns
module datapath(input clk,PCinit,PCsrc,jsel,input RegDst,ALUsrc,MemWrite,MemRead,MemtoReg,RegWrite,clr,input [2:0]ALUoperation, 
  output [5:0]func,opcode, output eq);
  

  wire PCld,Instld,SignalSel;
  wire [31:0]nextPC,PCAdr,nextAdr,Instruction,ID_Adr,ID_Inst,readData1,readData2,ExtData,ShiftedLabel,LabelAdr,condPC,ALURes;
  wire [31:0]EX_RData1,EX_RData2,EX_Data,ALUop1,ALUop2,MEM_ALURes,MEM_WData,EX_WData,MEM_data,WB_ALURes,WB_dataOut,WB_WData;
  wire [27:0]ShiftedAdr; 
  wire [4:0]EX_Rt,EX_Rs,EX_Rd,EX_WReg,MEM_WReg,WB_WReg;
  wire [8:0]ID_cnt,EX_cnt;
  wire [3:0]MEM_cnt;
  wire [1:0]WB_cnt,ForwardA,ForwardB;
  wire [8:0]cntSignals;
  assign cntSignals = {ALUoperation,RegDst,ALUsrc,MemWrite,MemRead,MemtoReg,RegWrite};
  PCreg PC(nextPC,clk,PCld,PCinit,PCAdr);
  Add32B AddPC(PCAdr,32'b00000000000000000000000000000100,nextAdr);
  InstMem InstMem(PCAdr,Instruction);
  superReg1 IF_ID(nextAdr,Instruction,clk,Instld,clr,ID_Adr,ID_Inst);
  RegFile RegFile(clk,WB_cnt[0],ID_Inst[25:21],ID_Inst[20:16],WB_WReg,WB_WData,readData1,readData2);
  SignExtend SgnExt(ID_Inst[15:0],ExtData);
  ShiftL32 ShBranchAdr(ExtData,ShiftedLabel);
  Add32B BranchAdd(ID_Adr,ShiftedLabel,LabelAdr);
  ShiftL26to28 ShjAdr(ID_Inst[25:0],ShiftedAdr);
  MUX32B JMUX(LabelAdr,{PCAdr[31:28],ShiftedAdr},jsel,condPC);
  MUX32B PCMUX(nextAdr,condPC,PCsrc,nextPC);
  checkEQ EQ(readData1,readData2,eq);
  
  MUX9B controllerMUX(9'b0,cntSignals,SignalSel,ID_cnt);
  //HAZARD UNIT
  HazardUnit HAZARD_UNIT(PCinit,EX_cnt[2],EX_Rt,ID_Inst[20:16],ID_Inst[25:21],ID_Inst[31:26],PCld,Instld,SignalSel);

  
  superReg2 ID_EX(ID_cnt,readData1,readData2,ExtData,ID_Inst[20:16],ID_Inst[25:21],ID_Inst[15:11],clk,EX_cnt,EX_RData1,EX_RData2,EX_Data,EX_Rt,EX_Rs,EX_Rd);
  MUX3to1 ALUMUX1(EX_RData1,MEM_ALURes,WB_WData,ForwardA,ALUop1);
  MUX3to1 ALUMUX2(EX_RData2,MEM_ALURes,WB_WData,ForwardB,EX_WData);
  MUX32B ALUMUX3(EX_WData,EX_Data,EX_cnt[4],ALUop2);
  ALU ALU(ALUop1,ALUop2,EX_cnt[8:6],ALURes);
  MUX5B DstReg(EX_Rd,EX_Rt,EX_cnt[5],EX_WReg);
  
  //FORWARDING UNIT
  FRWUnit FRW_UNIT(EX_Rs,EX_Rt,MEM_WReg,WB_WReg,MEM_cnt[0],WB_cnt[0],ForwardA,ForwardB);
  
  superReg3 EX_MEM(EX_cnt[3:0],ALURes,EX_WData,EX_WReg,clk,MEM_cnt,MEM_ALURes,MEM_WData,MEM_WReg);
  DataMem DataMem(MEM_ALURes,MEM_WData,clk,MEM_cnt[2],MEM_cnt[3],MEM_data);
  
  superReg4 MEM_WB(MEM_cnt[1:0],MEM_ALURes,MEM_data,MEM_WReg,clk,WB_cnt,WB_ALURes,WB_dataOut,WB_WReg);
  MUX32B DATAMUX(WB_ALURes,WB_dataOut,WB_cnt[1],WB_WData);
  
  assign opcode = ID_Inst[31:26];
  assign func = ID_Inst[5:0];
  /*
  wire [31:0]nextPC,PCAdd,nextAdd,InstructionExtData,ALUop2,ALUres;
  wire [31:0]ShiftedLabel,LabelAdr,PC1,PC2,data,DatatoReg;
  wire [4:0]WReg,DstReg;
  
  MUX5B RegFileMUX1(Instruction[20:16],Instruction[15:11],RegDst,DstReg);
  
  MUX32B RegFileMUX3(ALUres,data,MemtoReg,DatatoReg);
  MUX32B RegFileMUX4(nextAdd,DatatoReg,WDsel,WData);
  
  
  MUX32B ALUMUX(readData2,ExtData,ALUsrc,ALUop2);
  
  
  
  MUX32B PCMUX3(PC2,readData1,jrsel,nextPC);
  
  */
endmodule
