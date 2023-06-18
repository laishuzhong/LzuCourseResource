`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:08:24
// Design Name: 
// Module Name: small_Alu
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


module Small_Alu(clk, res, a, b, outp);
  input clk,res;
  input [31:0] a, b;
  reg [7:0] exp_a,exp_b;
  output reg [8:0] outp;
  
  always @(posedge clk)
    begin
      exp_a = a[30:23];
      exp_b = b[30:23];
      if(exp_a >= exp_b)
        begin
        outp[7:0] = exp_a - exp_b;
        outp[8] = 0;
        end
      else
        begin
          outp[7:0] = exp_b - exp_a;
          outp[8] = 1;
        end
      if(res == 0)
        outp = 0;
    end
endmodule
