`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:16:18
// Design Name: 
// Module Name: Big_Alu
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


module Big_Alu(clk, res, a, b, outp);
  input clk,res;
  input [26:0] a;
  input [31:0] b;
  reg sig_a,sig_b;
  reg [26:0] fra_a=0,mid;
  reg [26:0] fra_b=0;
  output reg [27:0] outp=0; //Added an overflow place at 26.
  
  always @(posedge clk)
    begin
      sig_a = a[26];
      sig_b = b[31];
      fra_a[25:0] = a[25:0];
      fra_b[24:2] = b[22:0];
      mid = 0;
      if(sig_a == sig_b)
        begin
          outp[27] = sig_a;
          outp[26:0] = fra_a + fra_b;
        end
      else
        begin
          if(fra_a > fra_b)
            begin
              outp[27] = sig_a;
              mid = (fra_a - fra_b)%fra_a;
              outp[26:0] = mid;
            end
          else if(fra_a < fra_b)
            begin
              outp[27] = sig_b;
              mid = (fra_b - fra_a)%fra_b;
              outp[26:0] = mid;
            end
          else
            outp = 0;
          end
        fra_b[25] = 0;
      if(res == 0)
        outp = 0;
    end
endmodule
