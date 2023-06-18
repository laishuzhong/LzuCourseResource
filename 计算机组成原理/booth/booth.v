`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/09 15:15:05
// Design Name: 
// Module Name: booth
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



`timescale 1ns / 1ps

module booth_multiply#(
	parameter DATAWIDTH = 32
)
(
	input                            CLK,
	input                            RSTn,
	input                            START,
	input  [ DATAWIDTH - 1 : 0 ]     A,
	input  [ DATAWIDTH - 1 : 0 ]     B,
	
	output [ DATAWIDTH * 2 - 1 : 0 ] RESULT,
	output                           Done
);

reg [ DATAWIDTH - 1 : 0 ] i;
reg [ DATAWIDTH * 2 : 0 ] P;
reg [ DATAWIDTH - 1 : 0 ] A_reg;
reg [ DATAWIDTH - 1 : 0 ] A_bm;
reg [ DATAWIDTH - 1 : 0 ] N;
reg [ DATAWIDTH * 2 : 0 ] result_reg;//���
reg                       isDone;//������־

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
	begin
		i <= 0;
		P <= 0;
		A_reg <= 0;
		A_bm <= 0;
		result_reg <= 0;
		N <=0;
		isDone <= 0;
	end
	else if (START)
	begin
	//ʹ��״̬�����booth�㷨
		case (i)
			0:
				begin
					A_reg <= A;//������
					//complement code of A ����A�Ĳ���,��������+-����
					A_bm <= ~A + 1'b1;  //ȡ����  
					P <= { 32'd0, B, 1'b0 };  //B add to last 32 bit of P ����65λĩβ���һ��0
					i <= i + 1'b1;//ת������1
					N <= 0;
				end
			//operating ��һ��״̬�����ж������λ��Ȼ�����ִ��ʲô����
			1:
				begin
					if (N == DATAWIDTH)//��ִ����32�Ρ�����������һ��������32*32�˷�
						begin
							N <= 0;//��ʼ����һ��
							i <= i + 2'b10;//��3
						end
					else if (P[1:0] == 2'b00 | P[1:0] == 2'b11)//��״̬λ11 00 ʱֻ��Ҫλ��
						begin
							P <= P;//����
							i <= i + 1'b1;//״̬ת�� 2
						end
					else if (P[1:0] == 2'b01)//01 10�Ӽ�����
						begin
							P <= {P[64:33] + A_reg,P[32:0]};
							i <= i + 1'b1;//״̬ת�� 2
						end
					else if (P[1:0] == 2'b10)
						begin
							P <= {P[64:33] + A_bm,P[32:0]};
							i <= i + 1'b1;//״̬ת�� 2
						end

				end
			//shift �������������λ��ʲô�����Ҫִ�е���λ����
			2:
				begin
					P <= {P[64],P[64:1]};//��λ����
					N <= N + 1'b1;//����������һλ
					i <= i - 1'b1;//����1
				end
			3:
				begin
					isDone <= 1;//����
					result_reg <= P;//�����ֵ
					i <= i + 1'b1;//״̬4

				end
			4:
				begin
					isDone <= 0;//��ʼ����׼����һ�ֳ˷�����
					i <= 0;
				end
		
		endcase
	end
end

assign Done = isDone;//��ɱ��
assign RESULT = result_reg[64:1];//��������������ӵ����λ0

endmodule

//`timescale 1ns / 1ps

//module booth_multiply#(
//	parameter DATAWIDTH = 8
//)
//(
//	input                            CLK,
//	input                            RSTn,
//	input                            START,
//	input  [ DATAWIDTH - 1 : 0 ]     A,
//	input  [ DATAWIDTH - 1 : 0 ]     B,
	
//	output [ DATAWIDTH * 2 - 1 : 0 ] RESULT,
//	output                           Done
//);

//reg [ DATAWIDTH - 1 : 0 ] i;
//reg [ DATAWIDTH * 2 : 0 ] P;
//reg [ DATAWIDTH - 1 : 0 ] A_reg;
//reg [ DATAWIDTH - 1 : 0 ] A_bm;
//reg [ DATAWIDTH - 1 : 0 ] N;
//reg [ DATAWIDTH * 2 : 0 ] result_reg;
//reg                       isDone;

//always @ ( posedge CLK or negedge RSTn )
//begin
//	if (!RSTn)
//	begin
//		i <= 0;
//		P <= 0;
//		A_reg <= 0;
//		A_bm <= 0;
//		result_reg <= 0;
//		N <=0;
//		isDone <= 0;
//	end
//	else if (START)
//	begin
//		case (i)
		
//			0:
//				begin
//					A_reg <= A;
//					//complement code of A ����A�Ĳ���,��������+-����
//					A_bm <= ~A + 1'b1;    
//					P <= { 8'd0, B, 1'b0 };  //B add to last 8bit of P
//					i <= i + 1'b1;
//					N <= 0;
//				end
//			//operating ��һ��״̬�����ж������λ��Ȼ�����ִ��ʲô����
//			1:
//				begin
//					if (N == DATAWIDTH)
//						begin
//							N <= 0;
//							i <= i + 2'b10;
//						end
//					else if (P[1:0] == 2'b00 | P[1:0] == 2'b11)
//						begin
//							P <= P;
//							i <= i + 1'b1;
//						end
//					else if (P[1:0] == 2'b01)
//						begin
//							P <= {P[16:9] + A_reg,P[8:0]};
//							i <= i + 1'b1;
//						end
//					else if (P[1:0] == 2'b10)
//						begin
//							P <= {P[16:9] + A_bm,P[8:0]};
//							i <= i + 1'b1;
//						end

//				end
//			//shift �������������λ��ʲô�����Ҫִ�е���λ����
//			2:
//				begin
//					P <= {P[16],P[16:1]};
//					N <= N + 1'b1;
//					i <= i - 1'b1;
//				end
//			3:
//				begin
//					isDone <= 1;
//					result_reg <= P;
//					i <= i + 1'b1;

//				end
//			4:
//				begin
//					isDone <= 0;
//					i <= 0;
//				end
		
//		endcase
//	end
//end

//assign Done = isDone;
//assign RESULT = result_reg[16:1];

//endmodule


	


    
           

