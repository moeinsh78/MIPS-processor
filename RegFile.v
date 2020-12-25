`timescale 1ns/1ns
module RegFile(input clk,input RegWrite,input [4:0]readReg1,readReg2,writeReg,input[31:0]writeData,output [31:0]readData1,readData2);
  
  reg [31:0]Registers[0:31];
  integer k;
	initial begin
	 for (k = 0; k < 32; k = k + 1)begin
	   Registers[k] = 0;
	 end
	end
	always @(negedge clk)
	begin
		if (RegWrite == 1) 
		begin
		  if(writeReg == 0) Registers[writeReg] <= 32'b00000000000000000000000000000000;
		  else Registers[writeReg] <= writeData;
		end
	end
	assign readData1 = Registers[readReg1];
	assign readData2 = Registers[readReg2];
endmodule