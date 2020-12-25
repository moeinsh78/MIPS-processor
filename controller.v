`timescale 1ns/1ns
module controller(input [5:0]opcode,func,input zero,output reg RegDst,WrSel,WdSel,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,RegWrite,PCsrc,output reg[2:0]ALUoperation);
  reg [2:0]ALUop;
  reg Branch;
  always @(opcode)begin
    {RegDst,WrSel,WdSel,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,Branch}=11'b00000000000;
    ALUop = 3'b000;
    case (opcode)
      6'b000000 :begin
        {RegDst,WrSel,WdSel,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,Branch}=11'b10110000000;
        ALUop = 3'b010;
      end
      6'b100011:begin
        {RegDst,WrSel,WdSel,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,Branch}=11'b00111101000;
        ALUop = 3'b000;
      end
      6'b101011:begin
       {RegWrite,ALUsrc,MemWrite,MemRead,JSel,JrSel,Branch}=7'b0110000;
        ALUop = 3'b000;
      end
      6'b000010 :begin
       {RegWrite,MemWrite,MemRead,JSel,JrSel,Branch}=6'b000100;
      end
      6'b000011 :begin
       {WrSel,WdSel,RegWrite,JSel,JrSel,Branch}=6'b101100;
      end
      6'b111111 :begin
        {RegWrite,MemWrite,MemRead,JrSel,Branch}=5'b00010;
      end
      6'b000100 :begin
       {RegWrite,ALUsrc,MemWrite,MemRead,JSel,JrSel,Branch}=7'b0000001;
        ALUop = 3'b001;
      end
      6'b000101 :begin
       {RegWrite,ALUsrc,MemWrite,MemRead,JSel,JrSel,Branch}=7'b0000001;
        ALUop = 3'b001;
      end
      6'b001000 :begin
       {RegDst,WrSel,WdSel,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,Branch}=11'b00111000000;
        ALUop = 3'b011;
      end
      6'b001100 :begin
       {RegDst,WrSel,WdSel,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,JSel,JrSel,Branch}=11'b00111000000;
        ALUop = 3'b100;
      end
    endcase
  end
  always@(ALUop,func)begin
    ALUoperation = 3'b101;
    case (ALUop)
      3'b000 :begin
        ALUoperation = 3'b010;
      end
      3'b001 :begin
        ALUoperation = 3'b110;
      end
      3'b010 :begin
        if(func == 6'b100000) ALUoperation = 3'b010;
        if(func == 6'b100010) ALUoperation = 3'b110;
        if(func == 6'b100100) ALUoperation = 3'b000;
        if(func == 6'b100101) ALUoperation = 3'b001;
        if(func == 6'b101010) ALUoperation = 3'b111;
      end 
      3'b011 :begin
        ALUoperation = 3'b010;
      end
      3'b100 :begin
        ALUoperation = 3'b000;
      end 
    endcase
  end
  always@(Branch,opcode,zero)begin
    PCsrc = 1'b0;
    if(Branch == 1'b0) PCsrc = 1'b0;
    else begin
      if(opcode == 6'b000100)PCsrc = zero;
      if(opcode == 6'b000101)PCsrc = ~zero;
    end
  end
endmodule

