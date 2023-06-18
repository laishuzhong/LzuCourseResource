`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:13:16
// Design Name: 
// Module Name: Mux_1
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


module Mux_1 (clk, res, x, y, en, out);
    input clk, res, en;
    input [31:0] x, y;
    reg [7:0] exp_x, exp_y;
    output reg [7:0] out;
    
    always @(posedge clk)
    begin
      exp_x = x[30:23];
      exp_y = y[30:23];
      begin
      if(en)
        out = exp_y;
      else
        out = exp_x;
      end
      begin
      if(!res)
        out = 0;
      end
    end
endmodule
