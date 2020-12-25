`timescale 1ns/1ns
module DataMem(input [31:0]Add,WData, input clk,MemRead,MemWrite, output reg [31:0]RData);
  wire [13:0]UsefulAdd;
  assign UsefulAdd = Add[15:2];
  reg [31:0] MemByte[0:16383];
  initial begin
    $readmemb("Mem.data", MemByte);
  end
  always@(MemRead,UsefulAdd) begin
    if(MemRead) RData = MemByte[UsefulAdd];
  end
  always@(posedge clk) begin
    if(MemWrite)begin
      MemByte[UsefulAdd] <= WData;
      $display("store in address :%d",Add);
      $display("number : %d" , WData);
    end
  end
endmodule
