`timescale 1ns/1ns
module controller(input [5:0]opcode,func,input PCinit,eq,output reg RegDst,ALUsrc,MemWrite,MemRead,MemtoReg,RegWrite,jsel,PCsrc,clr,output reg[2:0]ALUoperation);
  reg [2:0]ALUop;
  reg Branch;
  always @(opcode)begin
    {RegDst,RegWrite,ALUsrc,MemtoReg,MemWrite,MemRead,Branch}=7'b00000000;
    ALUop = 3'b000;
    case (opcode)
      6'b000000 :begin
        {ALUsrc,RegDst,MemWrite,MemRead,MemtoReg,RegWrite,Branch}=7'b0000010;
        ALUop = 3'b010;
      end
      6'b100011:begin
        {ALUsrc,RegDst,MemWrite,MemRead,MemtoReg,RegWrite,Branch}=7'b1101110;
        ALUop = 3'b000;
      end
      6'b101011:begin
       {ALUsrc,MemWrite,MemRead,RegWrite,Branch}=5'b11000;
        ALUop = 3'b000;
      end
      6'b000010 :begin
        Branch =1'b0;
      end
      6'b000100 :begin
        {ALUsrc,MemWrite,MemRead,RegWrite,Branch}=5'b00001;
        ALUop = 3'b001;
      end
      6'b000101 :begin
        {ALUsrc,MemWrite,MemRead,RegWrite,Branch}=5'b00001;
        ALUop = 3'b001;
      end
      6'b001000 :begin
       {ALUsrc,RegDst,MemWrite,MemRead,MemtoReg,RegWrite,Branch}=7'b1100010;
        ALUop = 3'b011;
      end
      6'b001100 :begin
       {ALUsrc,RegDst,MemWrite,MemRead,MemtoReg,RegWrite,Branch}=7'b1100010;
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
  always@(Branch,opcode,eq)begin
    PCsrc = 1'b0;
    jsel = 1'b0;
    if(Branch == 1'b0)begin
      if(opcode == 6'b000010)begin
        jsel = 1'b1;
        PCsrc = 1'b1;
      end
    end
    else begin
      if(opcode == 6'b000100)PCsrc = eq;
      if(opcode == 6'b000101)PCsrc = ~eq;
    end
  end
  always@(posedge PCinit)begin
    PCsrc = 1'b0;
  end
  always@(eq)begin
    clr = (opcode == 6'b000100 && eq) || (opcode == 6'b000101 && ~eq)? 1 : 0;
  end
  always@(jsel)begin
    clr = 1'b0;
    if(jsel) clr = 1'b1;
  end
endmodule

