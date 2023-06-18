`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/12 19:13:44
// Design Name: 
// Module Name: tb
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


module tb;

    reg   [11:0] alu_control;
    reg   [31:0] alu_src1;   
    reg   [31:0] alu_src2;   
    wire  [31:0] alu_result; 
    ALU_total alu_module(
        .op(alu_control),
        .in0   (alu_src1   ),
        .in1   (alu_src2   ),
        .out (alu_result )
    );

    initial begin
        # 50
        //�ӷ�����
        alu_control = 12'b1000_0000_0000;
        alu_src1 = 32'h1;
        alu_src2 = 32'h1;

        //��������
        #50;
        alu_control = 12'b0100_0000_0000;
        alu_src1 = 32'h3;
        alu_src2 = 32'h2;
        
        //�з��űȽ�
        #50;
        alu_control = 12'b0010_0000_0000;
        alu_src1 = 32'h1;
        alu_src2 = 32'h2;
        
        //�޷��űȽ�
        #50;
        alu_control = 12'b0001_0000_0000;
        alu_src1 = 32'h1;
        alu_src2 = 32'h2;
        
        //��λ��
        #50;
        alu_control = 12'b0000_1000_0000;
        alu_src1 = 32'b1010;
        alu_src2 = 32'b0101;
        
        //��λ���
        #50;
        alu_control = 12'b0000_0100_0000;
        alu_src1 = 32'b1010;
        alu_src2 = 32'b0101;

        //��λ��
        #50;
        alu_control = 12'b0000_0010_0000;
        alu_src1 = 32'b1010;
        alu_src2 = 32'b0101;
        
        //��λ���
        #50;
        alu_control = 12'b0000_0001_0000;
        alu_src1 = 32'b1011;
        alu_src2 = 32'b0101;
        
        //�߼�����
        #50;
        alu_control = 12'b0000_0000_1000;
        alu_src1 = 32'h4;
        alu_src2 = 32'h1;
        
        //�߼�����
        #50;
        alu_control = 12'b0000_0000_0100;
        alu_src1 = 32'h8;
        alu_src2 = 32'h2;

        //��������        
        #50;
        alu_control = 12'b0000_0000_0010;
        alu_src1 = 32'h4;
        alu_src2 = 32'h2;

        //��λ����    
        #50;
        alu_control = 12'b0000_0000_0001;
        alu_src2 = 32'hbfc0;
        alu_src1 = 32'h0;
    end
endmodule

