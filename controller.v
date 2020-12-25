`timescale 1ns/1ns
module controller(input clk, init,input [5:0]opcode,func,input zero,output reg IorD,IRwrite,PCwrite,RegDst,WrSel,WdSel,RegWrite,ALUsrcA,MemtoReg,MemWrite,MemRead,Brflag,PCWriteCond,output reg [1:0] ALUsrcB , PCsrc,output reg[2:0]ALUoperation);
  reg [2:0]ALUop;
  reg [3:0] ns,ps;
  parameter [3:0] IF=4'b0000 , ID = 4'b0001 , RT=4'b0010 , RT2=4'b0011 , MemRef=4'b0100 , LW=4'b0101 , LW2=4'b0110 , SW=4'b0111 , BR=4'b1000 , J=4'b1001 , ADDi=4'b1010 , I=4'b1011 , ANDi =4'b1100 , JAL=4'b1101 , JR=4'b1110;
  always @(ps , opcode,zero)begin
    ns = 4'b0000;
    {IorD,IRwrite,PCwrite,RegDst,WrSel,WdSel,RegWrite,ALUsrcA,MemtoReg,MemWrite,MemRead,Brflag,PCWriteCond}=13'b0000000000000;
    ALUop = 3'b000;
    PCsrc = 2'b00;
    ALUsrcB = 2'b00;
    case (ps)
      IF :begin
        {IorD,MemRead,IRwrite,ALUsrcA,PCwrite}=5'b01101;
        PCsrc=2'b00;
        ALUsrcB=2'b01;
        ALUop = 3'b000;
        ns = ID;
      end
      ID :begin
        ALUsrcA = 1'b0;
        ALUsrcB = 2'b11;
        ALUop = 3'b000;
        case (opcode)
          6'b000000 : ns=RT;
          6'b100011 : ns=MemRef; //lw
          6'b101011 : ns=MemRef; //sw
          6'b000010 : ns=J;
          6'b000011 : ns=JAL;
          6'b111111 : ns=JR;
          6'b000100 : ns=BR; //beq
          6'b000101 : ns=BR; //bne
          6'b001000 : ns=ADDi;
          6'b001100 : ns=ANDi;
        endcase
      end
      RT :begin
        ALUsrcA = 1'b1;
        ALUsrcB = 2'b00;
        ALUop = 3'b010;
        ns = RT2;
      end
      RT2 :begin
       {RegDst,WrSel,MemtoReg,WdSel,RegWrite}=5'b10001;
       ns = IF;
      end
      MemRef :begin
        ALUsrcA = 1'b1;
        ALUsrcB = 2'b10;
        ALUop = 3'b000;
        if(opcode == 6'b100011) ns = LW;
        if(opcode == 6'b101011) ns = SW;
      end
      LW :begin
        {IorD,MemRead}=2'b11;
        ns = LW2;
      end
      LW2 :begin
       {MemtoReg,WdSel,RegWrite,RegDst,WrSel}=5'b10100;
        ns = IF;
      end
      SW :begin
        {IorD,MemWrite}=2'b11;
        ns = IF;
      end
      J :begin
        PCsrc = 2'b10;
        PCwrite = 1'b1;
        ns = IF;
      end
      BR :begin
        ALUsrcA = 1'b1;
        ALUsrcB = 2'b00;
        ALUop = 3'b001;
        PCsrc = 2'b01;
        PCWriteCond =1'b1;
        if(opcode == 6'b000100)begin
          if(zero == 1'b1) begin
            Brflag = 1'b1;
          end
        end
        if(opcode == 6'b000101)begin
          if(zero == 1'b0) begin
            Brflag = 1'b1;
          end
        end
        ns = IF;
      end
      ADDi :begin
        ALUsrcA =1'b1;
        ALUsrcB = 2'b10;
        ALUop = 3'b011;
        ns = I;
      end
      ANDi :begin
        ALUsrcA = 1'b1;
        ALUsrcB = 2'b10;
        ALUop = 3'b100;
        ns = I;
      end
      I :begin
        {MemtoReg,WdSel,RegWrite,RegDst,WrSel}=5'b00100;
        ns = IF;
      end
      JAL :begin
        {WrSel,WdSel,RegWrite,PCwrite}=4'b1111;
        PCsrc=2'b10;
        ns = IF;
      end
      JR :begin
        PCsrc=2'b11;
        PCwrite = 1'b1;
        ns = IF;
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
  always @(posedge clk)begin
    if(init) ps<=IF;
    else ps<=ns;
  end
endmodule

