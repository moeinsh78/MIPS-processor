`timescale 1ns/1ns
module InstMem(input [31:0] Address,output [31:0]Instruction); 
  wire [13:0]UsefulAdr;
  assign UsefulAdr = Address[15:2];
  reg [31:0] mem[0:16383];
	initial
	begin
		$readmemb("inst1.data",mem);
	end
	assign Instruction = mem[UsefulAdr];	
endmodule