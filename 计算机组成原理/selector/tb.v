`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/10 22:41:10
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


module tb(

    );
    reg [31:0] in1,in2,in3,in4;
    reg [1:0] op;
    wire [31:0] out;
    initial
    begin
        in1 = 32'b00000000000000000000000000000000;
        in2 = 32'b00000000000000000000000000000001;
        in3 = 32'b00000000000000000000000000000010;
        in4 = 32'b00000000000000000000000000000011;
        op = 2'b10;
    end
    Select4to1 s(in1, in2, in3, in4, op, out);
endmodule

module Select4to1(in1, in2, in3, in4, op, out);
    input [31:0] in1;
    input [31:0] in2;
    input [31:0] in3;
    input [31:0] in4;
    input [1:0] op;
    output [31:0] out;
    wire [31:0] out1;
    wire [31:0] out2;
    Selector2to1 s1(in1, in2, op[0], out1);
    Selector2to1 s2(in3, in4, op[0], out2);
    Selector2to1 s3(out1, out2, op[1], out);
endmodule

//实现三十二位数据的二选一
module Selector2to1(
in1, in2, op, out
    );
    input [31:0] in1;
    input [31:0] in2;
    input op;
    output wire [31:0] out;
    genvar i;
    generate
    //循环比较
        for(i=0;i<32;i=i+1)begin
             sec s(
             .in1(in1[i]), 
             .in2(in2[i]),
             .op(op),
             .out(out[i])
             );
        end
   endgenerate
endmodule

module sec(in1, in2, op, out);
    input in1;
    input in2;
    input op;
    output wire out;
     assign out = (!op&&in1)||(op&in2);//门级电路的实现
endmodule


module Selector4to1_case(in1, in2, in3, in4, op, out);
    input [31:0] in1;
    input [31:0] in2;
    input [31:0] in3;
    input [31:0] in4;
    input [1:0] op;
    output reg [31:0] out;
    always @(*)
    begin
      case(op)
        2'b00:out = in1;
        2'b01:out = in2;
        2'b10:out = in3;
        2'b11:out = in4;
       endcase     
     end 
endmodule
