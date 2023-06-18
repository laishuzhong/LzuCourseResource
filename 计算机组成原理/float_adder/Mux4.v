`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:11:27
// Design Name: 
// Module Name: Mux4
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


module Mux_4 (clk, res, en, big_alu_result, fra_result, out);
    input clk, res, en;
    input [27:0] big_alu_result, fra_result;
    output reg [27:0] out;
    
    always @(posedge clk) begin
      begin
      if(en)
        out = fra_result;
      else
        out = big_alu_result;
      end
      begin
      if(!res)
        out = 0;
      end
    end
endmodule
