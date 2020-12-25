`timescale 1ns/1ns
module HazardUnit(input PCinit,ID_EX_MemRead ,input [4:0] ID_EX_Rt , Rt,Rs , input [5:0] opcode ,output reg PcWrite,InstLd,SignalSel);
  always@(opcode,ID_EX_MemRead,ID_EX_Rt,Rt,Rs)begin
    SignalSel = 1'b1;
    InstLd = 1'b1;
    PcWrite = 1'b1;
    if(opcode == 6'b000010)begin
      SignalSel = 1'b0;
    end
    if(ID_EX_MemRead == 1'b1 && ID_EX_Rt != 5'b00000)begin
      if(opcode == 6'b100011)begin
        if(ID_EX_Rt == Rs)begin
          InstLd = 1'b0;
          PcWrite = 1'b0;
          SignalSel = 1'b0;
        end
      end
      else begin
        if(ID_EX_Rt == Rs || ID_EX_Rt == Rt)begin
          InstLd = 1'b0;
          PcWrite = 1'b0;
          SignalSel = 1'b0;
        end
      end
    end
  end
  always@(posedge PCinit)begin
    InstLd = 1'b1;
    PcWrite = 1'b1;
  end
  
endmodule
      
    