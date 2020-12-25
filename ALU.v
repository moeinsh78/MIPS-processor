`timescale 1ns/1ns
module ALU(input [31:0]A,B,input [2:0]ALUoperation,output reg [31:0]O);
  always@(ALUoperation,A,B) begin
    case(ALUoperation)
    3'b000: O = A & B;
    3'b001: O = A | B;
    3'b010: O = A + B;
    3'b110: O = A - B;
    3'b111: begin
      if(A[31] == 1'b0 && B[31] == 1'b1) O = 8'h00000000;
      else if(A[31] == 1'b1 && B[31] == 1'b0) O = 8'h00000001;
     	else O = (A > B)? 8'h00000000 : 8'h00000001;
    end
    endcase
  end
endmodule
