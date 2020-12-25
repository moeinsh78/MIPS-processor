`timescale 1ns/1ns
module PCreg(input [31:0]iBus,clk,init, output reg [31:0]oBus);
  always@(posedge clk) begin
    if(init) oBus <= 32'b0;
    else oBus <= iBus; 
  end
endmodule
