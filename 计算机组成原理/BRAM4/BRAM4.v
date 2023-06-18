`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/14 07:58:43
// Design Name: 
// Module Name: BRAM4
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
module BRAM4(
input clk,               //ʱ��
input rst                //��λ�źţ��͵�ƽ��Ч
    );
    
reg[8:0]     w_addr;      //RAM PORT A д��ַ
reg[15:0]    w_data;     //RAM PORT  A д����
reg[8:0]     r_addr;     //RAM PORT  B ����ַ
wire[15:0]   r_data;    //RAM PORT   B ������
    
//ʵ����RAM
    blk_mem_gen_0 ram_ip_test ( 
  .clka     (clk          ),            // input clka 
  .addra    (w_addr       ),            // input [8 : 0] addra 
  .dina     (w_data       ),            // input [15 : 0] dina 
  .clkb     (clk          ),            // input clkb 
  .addrb    (r_addr       ),            // input [8 : 0] addrb 
  .doutb    (r_data       )             // output [15 : 0] doutb 
  ); 
endmodule
