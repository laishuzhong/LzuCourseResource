`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:09:03
// Design Name: 
// Module Name: Shift_Right
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


module Shift_Right(clk, res, shift, mux, outp);
  input clk,res;
  input [31:0] mux;
  input [7:0] shift;
  reg [7:0] tmp;
  reg [26:0] fra = 0;
  output reg [26:0] outp; //26 for signal, 25:0 for num "1" before dot and two reserved at the end.
  always @(posedge clk) begin
    if(shift)
      begin
        fra[24:2] = mux[22:0]; //reserve two places at the end.
        tmp = shift - 128;
        fra[25] = 1; //number "1" before dot
        outp[24:0] = fra>>tmp;
        outp[26] = mux[31]; //signal
      end
    if(!res)
      outp = 0;
    end
endmodule
