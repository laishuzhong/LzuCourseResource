`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:10:14
// Design Name: 
// Module Name: Rounding
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


module Rounding(clk,res,shift,incre,
  exp_result,fra_result,result,overflow);
  input clk,res;
  input [8:0] incre;
  input [27:0] shift;
  reg [24:0] fra;//Include "1" but not the two reserved places.
  output reg overflow;
  output reg [7:0] exp_result;
  output reg [27:0] fra_result;
  output reg [31:0] result;
  
  always @(posedge clk) begin
    if(shift)
      begin
    if(incre[8])//incase the second time exp is not overflow.
      overflow = 1;
    else
      overflow = 0;//reset
    fra [24] = 0;
    fra[23:0] = shift[25:2];
    if(shift[1])
      fra = fra+1;
    if(fra[24])
      begin
        fra_result[27] = shift[27];
        fra_result[26:2] = fra[24:0];
        fra_result[1:0] = 1;
        exp_result = incre[7:0];
      end
    else
      begin
        result[31] = shift[27];
        result[30:23] = incre[7:0];
        result[22:0] = fra[22:0];
      end
    if(!res)
      begin
        fra_result = 0;
        result = 0;
      end
    end
  end
  endmodule
