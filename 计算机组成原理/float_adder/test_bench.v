`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:05:18
// Design Name: 
// Module Name: test_bench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_bench;
reg clk; 
reg reset; 
reg[31:0] x; 
reg[31:0] y;
wire[31:0] result;

initial
    #0 clk = 1'b1;
  always
    #10 clk = ~clk;
  
  initial
    begin
      #0 reset = 1'b0;
      #5 reset = 1'b0;
      #10 reset = 1'b1;
//      #500 $finish;
    end
    
  initial
    begin
      #11  x=32'b0001_1111_1111_1111_1111_1111_1111_1111;
      #11  y=32'b1001_1111_1111_1111_1111_1111_1111_0000;
    end
    Floating_Point_Addition
    test(clk,reset,x,y, result);
endmodule
