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

module rom #(parameter WORD_W = 8, OP_W = 3)
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
    0: mdr = {`STORE, 5'd16}; //Store the contents of accumulator 
	  1: mdr = {`LOAD, 5'd16};  //Load the contents of address into the accumulator
    2: mdr = {`ADD, 5'd5};    //Add the contents of address to the accumulator
    3: mdr = {`STORE, 5'd16}; //Store the contents of accumulator 
    4: mdr = {`BNE, 5'd6};    //Branch if result of last arithmetic operation is not zero
    5: mdr = 2;               //contents used by another instruction
    6: mdr = 1;               //contents used by another instruction
    default: mdr = 0;         //rest of ROM is 0
  endcase
  end
  
endmodule