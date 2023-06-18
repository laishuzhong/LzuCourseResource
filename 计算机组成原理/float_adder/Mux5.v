`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:10:45
// Design Name: 
// Module Name: Mux5
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


module Mux_5(clk,res,en,mux,rounding,outp);
  input clk,res,en;
  input [7:0] mux,rounding;
  output reg [7:0] outp;
  
  always @(posedge clk) begin
    if(!en)
      outp = mux;
    else
      outp = rounding;
    if(!res)
      outp = 0;
    end
endmodule
