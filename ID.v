/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: Instruction Decode Stage
Last Updated: December 21, 2018
*******************************************************************************/

//TODO: add control signal outputs, see page 35 of the review pdf
module ID(
    input CLK,
    input STALL_IN_DQ,
    input STALL_IN_RQ,
    input [31:0] Instr_IN,
    input [31:0] Instr_PC_IN,
    output reg [31:0] Instr_OUT,
    output reg [31:0] Instr_PC_OUT,
    output reg [5:0] opcode_OUT,
    output reg [4:0] rs_OUT,
    output reg [4:0] rt_OUT,
    output reg [4:0] rd_OUT,
    output reg [4:0] shiftAmount_OUT, //output signal, shift amount
    output reg [5:0] funct_OUT,       //output signal, function code
    output reg [15:0] immediate_OUT,  //output signal, immediate value
    output reg [25:0] target_OUT,     //output signal, target value
    output reg RegDst_OUT,            //
    output reg ALUSrc_OUT,
    output reg MemtoReg_OUT,
    output reg RegWrite_OUT,
    output reg MemRead_OUT,
    output reg MemWrite_OUT,
    output reg Branch_OUT,
    output reg [1:0] ALUOp_OUT,
    output reg Jump_OUT,
    output wire STALL_OUT_DQ,
    output wire STALL_OUT_RQ
    );

    //Pass through stall signals
    assign STALL_OUT_DQ = STALL_IN_RQ;
    assign STALL_OUT_RQ = STALL_IN_DQ;

    always @(posedge CLK) begin
        //Pass through instruction and instruction PC
        assign Instr_OUT = Instr_IN;
        assign Instr_PC_OUT = Instr_PC_IN;

        //R-type instructions
        assign opcode_OUT = Instr_IN[31:26];
        assign rs_OUT = Instr_IN[25:21];
        assign rt_OUT = Instr_IN[20:16];
        assign rd_OUT = Instr_IN[15:11];
        assign shiftAmount_OUT = Instr_IN[10:6];
        assign funct_OUT = Instr_IN[5:0];

        //I-type instructions
        //opcode, rs, rt assigned under R-type
        assign immediate_OUT = Instr_IN[15:0];

        //J-type instructions
        //opcode assigned under R-type
        assign target_OUT = Instr_IN[25:0];

        //defining the control lines
        case (Instr_IN[31:26]) begin
            6'b000000: begin
                end
            6'b000001: begin
                end
            6'b000010: begin
                end
            6'b000011: begin
                end
            6'b000100: begin
                end
            6'b000101: begin
                end
            6'b000110: begin
                end
            6'b000111: begin
                end
            6'b001000: begin
                end
            6'b001001: begin
                end
            6'b001010: begin
                end
            6'b001011: begin
                end
            
        endcase
    end

endmodule
