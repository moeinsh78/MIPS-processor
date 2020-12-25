`timescale 1ns/1ns
module Memory(input [31:0]Add,WData, input clk,MemRead,MemWrite, output reg [31:0]RData);
  wire [13:0]UsefulAdr;
  assign UsefulAdr = Add[15:2];
  
  reg [31:0] Mem[0:16383];
  initial begin
    $readmemb("mem1.data", Mem);
  end
  always@(posedge clk , MemRead) begin
    if(MemWrite)begin
      Mem[UsefulAdr] <= WData;
      $display("store in address :%d",Add);
      $display("number : %d" , WData);
    end
    if(MemRead) RData <= Mem[UsefulAdr];
  end
endmodule
