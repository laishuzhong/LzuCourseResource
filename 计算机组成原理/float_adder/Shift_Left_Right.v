`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:09:37
// Design Name: 
// Module Name: Shift_Left_Right
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


module Shift_Left_Right(clk,res,shift_left_bits,shift_right_bits,
  shift_left_en,shift_right_en,mux_4_output,out);
  input clk,res,shift_left_en,shift_right_en;
  input [7:0] shift_left_bits,shift_right_bits;
  input [27:0] mux_4_output;
  output reg [27:0] out;
  
  always @(posedge clk) begin
    if(shift_right_en)
      out = mux_4_output >> shift_right_bits;
    else if(shift_left_en)
      out = mux_4_output << shift_left_bits;
    out[27] = mux_4_output[27];
    out[0] = 1;//mark
  end
endmodule
