`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/17 16:13:50
// Design Name: 
// Module Name: Incre_Decre
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


module Incre_Decre(clk,res,incre_bit,decre_bit,incre_en,decre_en,mux,incre_decre_output);
  input clk,res,incre_en,decre_en;
  input [7:0] incre_bit,decre_bit,mux;
  output reg [8:0] incre_decre_output;
  
  always @(posedge clk) begin
    incre_decre_output[8] = 0;
    if(incre_en)
      incre_decre_output = mux + incre_bit;
    else if(decre_en)
      incre_decre_output = mux - decre_bit;
    if(!res)
      incre_decre_output = 0;
  end
endmodule
