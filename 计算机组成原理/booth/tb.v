`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/09 15:16:03
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


//`timescale 1ns / 1ps   //仿真单位时间为1ns，精度为1ps
//module testbench;

//    // Inputs
//    reg [31:0] operand1;
//    reg [31:0] operand2;
//    reg clk;
//    reg rstn;
//    reg start;

//    // Outputs
//    wire [63:0] result;
//    wire finish;
//    wire done;
//    // Instantiate the Unit Under Test (UUT)
//    booth uut(clk, rstn, start, operand1, operand2, result, done,finish);
//    initial begin
//        // Initialize Inputs
//        operand1 = 0;
//        operand2 = 0;
//        start = 1;
//        clk = 0;
//        rstn = 0;
//        // Wait 100 ns for global reset to finish
//        #100;
//        // Add stimulus here
//        rstn = 1;
//        operand1 = 32'h00000011;
//        operand2 = 32'h00000011;
//        # 100;
//        operand1 = 32'h00001111;
//        operand2 = 32'h00001111;
//        # 100
//        operand1 = 32'h1;
//        operand2 = 32'h2;
        
//    end
////    always #10 operand1 = $random;  //$random为系统任务，产生一个随机的32位数
////    always #10 operand2 = $random;  //#10 表示等待10个单位时间(10ns)，即每过10ns，赋值一个随机的32位数
//    always #10 clk = ~clk;
//endmodule


`timescale  1ns / 1ps    

module tb_booth_multiply;

// booth_multiply Parameters
parameter PERIOD     = 5;
parameter DATAWIDTH  = 32;

// booth_multiply Inputs
reg   CLK                                  = 0 ;
reg   RSTn                                 = 0 ;
reg   START                                = 0 ;
reg   [ DATAWIDTH - 1 : 0 ]  A             = 0 ;
reg   [ DATAWIDTH - 1 : 0 ]  B             = 0 ;

// booth_multiply Outputs
wire  [ DATAWIDTH * 2 - 1 : 0 ]  RESULT    ;
wire  Done                                 ;


initial
begin
    forever #(PERIOD/2)  CLK=~CLK;
end

initial
begin
    #(PERIOD) RSTn  =  1;START = 1;
end

booth_multiply #(
    .DATAWIDTH ( DATAWIDTH ))
 u_booth_multiply (
    .CLK                     ( CLK                               ),
    .RSTn                    ( RSTn                              ),
    .START                   ( START                             ),
    .A                       ( A       [ DATAWIDTH - 1 : 0 ]     ),
    .B                       ( B       [ DATAWIDTH - 1 : 0 ]     ),

    .RESULT                  ( RESULT  [ DATAWIDTH * 2 - 1 : 0 ] ),
    .Done                    ( Done                              )
);

initial
begin
    A = -4;
	B = 6;
	#200
	A = 3;
	B = 5;
	#200
	A = -4;
	B = -6;
	#200
	A = 123;
	B = -56;
	#200
	A = 99;
	B = 44;
	#200
	A = -34;
	B = -66;
	#200
	A = 23;
	B = 12;
	#200
	A = 111;
	B = 100;
    #800
    $finish;

end

endmodule
