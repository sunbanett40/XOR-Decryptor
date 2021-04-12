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



/*  RAM:
    
    70: character_position
    71: character_in 1
    72: character_in 2
    73: character_in 3
    74: character_in 4
    75: character_in 5
    76: character_in 6
    77: character_in 7
    78: character_in 8
    79: ACC_TEMP
    
    80: character_position
    81: character_out 1
    82: character_out 2
    83: character_out 3
    84: character_out 4
    85: character_out 5
    86: character_out 6
    87: character_out 7
    88: character_out 8
    
    //auto Loader
    90: mdr = {`LOAD,   (`LOAD position_rom_start)}; 
    91: mdr = {`ADD,    load_position};
    92: mdr = {`STORE,  96}; //update next line
    93: mdr = {`LOAD,   (`STORE position_ram_start)}; 
    94: mdr = {`ADD,    position_load};
    95: mdr = {`STORE,  97}; //update next line
    96: mdr = {`LOAD,   program_in};
    97: mdr = {`STORE,  program_out};
    98: mdr = {`BNE,    90};
    
    //input
    100: mdr = {`LOAD,   switches};
    101: mdr = {`STORE,  ACC_TEMP};
    102: mdr = {`LOAD,   (`STORE position_character_start)};
    103: mdr = {`ADD,    character_position};
    104: mdr = {`STORE,   106};
    105: mdr = {`LOAD,    ACC_TEMP};
    106: mdr = {`STORE,  position};
    107: mdr = {`BNE,   100};

    //encryption-decryption
    100: mdr = {`LOAD,   (`LOAD character_in_start)}; 
    101: mdr = {`ADD,    position};
    102: mdr = {`STORE,  106}; //update next line
    103: mdr = {`LOAD,   (`STORE character_out_start)}; 
    104: mdr = {`ADD,    position};
    105: mdr = {`STORE,  108}; //update next line
    106: mdr = {`LOAD,   character_in};   
    107: mdr = {`XOR,    key};   
    108: mdr = {`STORE,  character_out};   
    109: mdr = {`STORE,  Display};
    110: mdr = {`LOAD,   position};
    111: mdr = {`ADD,    1};
    112: mdr = {`STORE,  position};
    113: mdr = {`XOR,    length};   
    114: mdr = {`BNE,    100};
    115: mdr = {`LOAD,   key};
    116: mdr = {`ADD,    1};
    117: mdr = {`STORE,  key};
    118: mdr = {`XOR,    possible_keys};
    119: mdr = {`BNE,    100};
*/

    default: mdr = 0;             //rest of ROM is 0
  endcase
  end
  
endmodule