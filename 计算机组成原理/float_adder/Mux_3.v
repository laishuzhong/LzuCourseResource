`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:12:18
// Design Name: 
// Module Name: Mux_3
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


module Mux_3 (clk, res, x, y, en, out);
    input clk, res, en;
    input [31:0] x, y;
    output reg [31:0] out;
    
    always @(posedge clk) begin
      begin
      if(en)
        out = y;
      else
        out = x;
      end
      begin
      if(!res)
        out = 0;
      end
    end
endmodule
