`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/12 19:12:52
// Design Name: 
// Module Name: ALU_1_total
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


module ALU_total(
op,in0,in1,out
    );
    input [31:0] in0,in1;
    input [11:0] op;
    output reg[31:0] out;
    always@(*)
begin
    case(op)
        //add�����ӷ��з���
        12'b1000_0000_0000:
            begin
            out=in0+in1;
            end
        //sub���������з�����
        12'b0100_0000_0000:
            begin
            out=in0-in1;
            end
         //slt�Ƚ������з�����
        12'b0010_0000_0000:
            begin                        
            if(in0[31]==1&&in1[31]==0)
                out=1;
            else if(in0[31]==0&&in1[31]==1)
                out=0;
            else 
                out=(in0<in1)?1:0;
           end
        //sltu�Ƚ������޷�����
        12'b0001_0000_0000:
            begin
                out=(in0<in1)?1:0;
            end
        //and�߼�������
        12'b0000_1000_0000:
            begin
            out=in0&in1;
            end
        //nor�߼��������
        12'b0000_0100_0000:
            begin
            out=~(in0|in1);
            end
        //or�߼�������
        12'b0000_0010_0101:
            begin
            out=in0|in1;
            end
        //xor�߼��������
        12'b0000_0001_0000:
            begin
            out=in0^in1;
            end
        //shl�߼�����
        12'b0000_0000_1000:
            begin
            out=in0<<in1;
            end
        //shr�߼�����
        12'b0000_0000_0100:
            begin
            out=in0>>in1;
            end
        //sar��������
        12'b0000_0000_0010:
            begin
            out=($signed(in0))>>>in1;
            end
        //��λ����
        12'b0000_0000_0001:
            begin
               out = {in1[15:0], 16'b0};
            end
    endcase
end
endmodule
