`timescale 1ns/1ns
module testMIPS();
  reg clk,init;
  MIPS mips(clk,init);
  initial begin
    clk=0;
      forever #2 clk = ~clk;  
  end 
  initial begin
    #5
    init = 1;
    #3
    init = 0;
    #5000
    $stop;
  end
endmodule