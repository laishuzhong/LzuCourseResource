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
reg [ DATAWIDTH * 2 : 0 ] result_reg;//结果
reg                       isDone;//结束标志

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
	//使用状态机完成booth算法
		case (i)
			0:
				begin
					A_reg <= A;//被乘数
					//complement code of A 计算A的补码,方便后面的+-操作
					A_bm <= ~A + 1'b1;  //取补码  
					P <= { 32'd0, B, 1'b0 };  //B add to last 32 bit of P 定义65位末尾添加一个0
					i <= i + 1'b1;//转到步骤1
					N <= 0;
				end
			//operating 这一个状态用来判断最低两位，然后决定执行什么操作
			1:
				begin
					if (N == DATAWIDTH)//当执行完32次——即运行完一次完整的32*32乘法
						begin
							N <= 0;//初始化下一轮
							i <= i + 2'b10;//到3
						end
					else if (P[1:0] == 2'b00 | P[1:0] == 2'b11)//当状态位11 00 时只需要位移
						begin
							P <= P;//不变
							i <= i + 1'b1;//状态转移 2
						end
					else if (P[1:0] == 2'b01)//01 10加减操作
						begin
							P <= {P[64:33] + A_reg,P[32:0]};
							i <= i + 1'b1;//状态转移 2
						end
					else if (P[1:0] == 2'b10)
						begin
							P <= {P[64:33] + A_bm,P[32:0]};
							i <= i + 1'b1;//状态转移 2
						end

				end
			//shift 这是无论最低两位是什么，最后都要执行的移位操作
			2:
				begin
					P <= {P[64],P[64:1]};//移位操作
					N <= N + 1'b1;//表明处理完一位
					i <= i - 1'b1;//返回1
				end
			3:
				begin
					isDone <= 1;//结束
					result_reg <= P;//结果赋值
					i <= i + 1'b1;//状态4

				end
			4:
				begin
					isDone <= 0;//初始化，准备下一轮乘法计算
					i <= 0;
				end
		
		endcase
	end
end

assign Done = isDone;//完成标记
assign RESULT = result_reg[64:1];//结果输出，舍弃添加的最低位0

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
//					//complement code of A 计算A的补码,方便后面的+-操作
//					A_bm <= ~A + 1'b1;    
//					P <= { 8'd0, B, 1'b0 };  //B add to last 8bit of P
//					i <= i + 1'b1;
//					N <= 0;
//				end
//			//operating 这一个状态用来判断最低两位，然后决定执行什么操作
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
//			//shift 这是无论最低两位是什么，最后都要执行的移位操作
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


	


    
           

