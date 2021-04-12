/////////////////////////////////////////////////////////////////////
// Design unit: TestCPU
//            :
// File name  : testcpu.sv
//            :
// Description: Simple testbench for basic processor
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 05/08/08
//            : Version 1.2 19/12/17
//            : Version 1.3 08/01/21 - For remote working
/////////////////////////////////////////////////////////////////////

module testcpu;

parameter int WORD_W = 10, OP_W = 3;

logic  clock, n_reset;
logic [WORD_W-1:0] switches;
logic [WORD_W-1:0] display;
wire [WORD_W-1:0] sysbus;

cpu2 #(.WORD_W(WORD_W), .OP_W(OP_W)) c1 (.*);

always
  begin
#10ns clock = 1'b1;
#10ns clock = 1'b0;
end

initial
begin
n_reset = 1'b1;
switches = 
#1ns n_reset = 1'b0;
#2ns n_reset = 1'b1;
#718ns switches = 8'h01;  //character 1 a
#600ns switches = 8'h14;  //character 2 t
#600ns switches = 8'h14;  //character 3 t
#600ns switches = 8'h01;  //character 4 a
#600ns switches = 8'h03;  //character 5 c
#600ns switches = 8'h0b;  //character 6 k
#600ns switches = 8'h05;  //character 7 e
#600ns switches = 8'h12;  //character 8 r
#600ns switches = 8'h15;  //key 1 0101 k
#600ns switches = 8'h15;  //key 0 0101 e
#600ns switches = 8'h15;  //key 1 1001 y
end

endmodule