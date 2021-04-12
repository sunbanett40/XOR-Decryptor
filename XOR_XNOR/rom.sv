/////////////////////////////////////////////////////////////////////
// Design unit: rom
//            :
// File name  : rom.sv
//            :
// Description: ROM for basic processor
//            : including simple program 
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
// Revision   : Version 1.0 12/12/14
//            : Version 1.1 14/01/21 Simplified some of the syntax
/////////////////////////////////////////////////////////////////////

module rom #(parameter WORD_W = 10, OP_W = 3)
               (input logic clock, n_reset, MDR_bus, load_MDR, load_MAR, CS, R_NW,
                inout wire [WORD_W-1:0] sysbus);

`include "opcodes.h"
		
logic [WORD_W-OP_W-1:0] mar;
logic [WORD_W-1:0] mdr;


assign sysbus = (MDR_bus & ~mar[WORD_W-OP_W-1]) ? mdr : 'z;
// mar[WORD_W-OP_W-1] is most significant bit of address
//See comments in RAM and notice the difference here

always_ff @(posedge clock, negedge n_reset)
  begin
  if (!n_reset)
    begin 
    mar <= 0;
    end
  else
    if (load_MAR)
      mar <= sysbus[WORD_W-OP_W-1:0];
  end


always_comb
  begin
  mdr = 0;
  case (mar)
    0:  mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    1:  mdr = {`STORE,  7'd64};   //Store the contents of accumulator 
    2:  mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    3:  mdr = {`STORE,  7'd65};   //Store the contents of accumulator 
    4:  mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    5:  mdr = {`STORE,  7'd66};   //Store the contents of accumulator 
    6:  mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    7:  mdr = {`STORE,  7'd67};   //Store the contents of accumulator 
    8:  mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    9:  mdr = {`STORE,  7'd68};   //Store the contents of accumulator 
    10: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    11: mdr = {`STORE,  7'd69};   //Store the contents of accumulator 
    12: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    13: mdr = {`STORE,  7'd70};   //Store the contents of accumulator 
    14: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    15: mdr = {`STORE,  7'd71};   //Store the contents of accumulator

    16: mdr = {`LOAD,   7'd64};   //Load the character 1 into the accumulator
    17: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    18: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    19: mdr = {`STORE,  7'd127};  //Output to display
    20: mdr = {`LOAD,   7'd65};   //Load the character 2 into the accumulator
    21: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    22: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    23: mdr = {`STORE,  7'd127};  //Output to display
    24: mdr = {`LOAD,   7'd66};   //Load the character 3 into the accumulator
    25: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    26: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    27: mdr = {`STORE,  7'd127};  //Output to display
    28: mdr = {`LOAD,   7'd67};   //Load the character 4 into the accumulator
    29: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    30: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    31: mdr = {`STORE,  7'd127};  //Output to display
    32: mdr = {`LOAD,   7'd68};   //Load the character 5 into the accumulator
    33: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    34: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    35: mdr = {`STORE,  7'd127};  //Output to display
    36: mdr = {`LOAD,   7'd69};   //Load the character 6 into the accumulator
    37: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    38: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    39: mdr = {`STORE,  7'd127};  //Output to display
    40: mdr = {`LOAD,   7'd70};   //Load the character 7 into the accumulator
    41: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    42: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    43: mdr = {`STORE,  7'd127};  //Output to display
    44: mdr = {`LOAD,   7'd71};   //Load the character 8 into the accumulator
    45: mdr = {`XOR,    7'd51};   //XOR accumulator with XOR key
    46: mdr = {`XNOR,   7'd52};   //XNOR accumulator with XNOR key
    47: mdr = {`STORE,  7'd127};  //Output to display

    51: mdr = 21; //XOR Key
    52: mdr = 10; //XNOR key
    53: mdr = 1;
    54: mdr = 8;
    55: mdr = 16;
    default: mdr = 0;             //rest of ROM is 0
  endcase
  end
  
endmodule