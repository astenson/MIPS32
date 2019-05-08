/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: data cache, arbitrary size, level of association
Last Updated: May 7, 2019
*******************************************************************************/

module dc(
    //Signals to/from the processor
    input       [31:0] dataInProcessor.
    input       [31:0] addrInProcessor,
    input              writeFlagProcessor, //1 if write
    input              readFlagProcessor, //1 if read
    output wire [31:0] dataOutProcessor,
    output wire        missFlagProcessor, //1 if it's a miss

    //Signals t0/from the bus
    input       [31:0] dataInBus,
    input       [31:0] addrInBus,
    output wire [31:0] addrOutBus,
    output wire [31:0] dataOutBus,
    output wire        requestOutBus,
    input              grantInBus,

    //Snooping signals to/from the bus
    input       [31:0] addrInSnooping,
    input              masterFlagSnooping, //1 if this cache/processor is the bus master
    input              invalidateFlagIn,
    output wire        invalidateFlagOut,
    output wire        interveneFlagOut
    );

    parameter total_size = 32; //in kilobytes
    parameter block_size = 32; //in bytes
    parameter num_ways = 2;

    reg [((total_size/block_size*1024)/num_ways)-1:0] regFile [(8*block_size*num_ways)-1:0];

endmodule
