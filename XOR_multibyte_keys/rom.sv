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
    16: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    17: mdr = {`STORE,  7'd72};   //Store the contents of accumulator
    18: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    19: mdr = {`STORE,  7'd73};   //Store the contents of accumulator
    20: mdr = {`LOAD,   7'd126};  //Load the contents of address into the accumulator
    21: mdr = {`STORE,  7'd74};   //Store the contents of accumulator

    22: mdr = {`LOAD,   7'd64};   //Load the character 1 into the accumulator
    23: mdr = {`XOR,    7'd72};   //XOR accumulator with key
    24: mdr = {`STORE,  7'd127};  //Output to display
    25: mdr = {`LOAD,   7'd65};   //Load the character 2 into the accumulator
    26: mdr = {`XOR,    7'd73};   //XOR accumulator with key
    27: mdr = {`STORE,  7'd127};  //Output to display
    28: mdr = {`LOAD,   7'd66};   //Load the character 3 into the accumulator
    29: mdr = {`XOR,    7'd74};   //XOR accumulator with key
    30: mdr = {`STORE,  7'd127};  //Output to display
    31: mdr = {`LOAD,   7'd67};   //Load the character 4 into the accumulator
    32: mdr = {`XOR,    7'd72};   //XOR accumulator with key
    33: mdr = {`STORE,  7'd127};  //Output to display
    34: mdr = {`LOAD,   7'd68};   //Load the character 5 into the accumulator
    35: mdr = {`XOR,    7'd73};   //XOR accumulator with key
    36: mdr = {`STORE,  7'd127};  //Output to display
    37: mdr = {`LOAD,   7'd69};   //Load the character 6 into the accumulator
    38: mdr = {`XOR,    7'd74};   //XOR accumulator with key
    39: mdr = {`STORE,  7'd127};  //Output to display
    40: mdr = {`LOAD,   7'd70};   //Load the character 7 into the accumulator
    41: mdr = {`XOR,    7'd72};   //XOR accumulator with key
    42: mdr = {`STORE,  7'd127};  //Output to display
    43: mdr = {`LOAD,   7'd71};   //Load the character 8 into the accumulator
    44: mdr = {`XOR,    7'd73};   //XOR accumulator with key
    45: mdr = {`STORE,  7'd127};  //Output to display
    46: mdr = {`BNE,    7'd55};   //Loop until all keys are tried

    53: mdr = 1;
    54: mdr = 8;
    55: mdr = 22;

    /*RAM:
64: encrypted character 1
65: encrypted character 2
66: encrypted character 3
67: encrypted character 4
68: encrypted character 5
69: encrypted character 6
70: encrypted character 7
71: encrypted character 8
72: key 1
73: key 2
74: key 3
*/
    default: mdr = 0;             //rest of ROM is 0
  endcase
  end
  
endmodule