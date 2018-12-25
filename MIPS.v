/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: MIPS, overall pipeline connecting individual component blocks
Last Updated: December 21, 2018
*******************************************************************************/

`include "DQ.v"
`include "ID.v"
`include "RQ.v"

module MIPS(
    input CLK,
    input RESET
    );

    //wires out of IF
    wire [31:0] Instr_IFDQ;    //passing the instruction from IF to DQ
    wire [31:0] Instr_PC_IFDQ; //passing the instruction's PC from IF to DQ
    wire STALL_IFDQ;           //signal from IF telling DQ to stall

    //wires out of DQ
    wire [31:0] Instr_DQID;    //passing the instruction from DQ to ID
    wire [31:0] Instr_PC_DQID; //passing the instruction's PC from DQ to ID
    wire STALL_DQIF;           //signal from DQ telling IF to stall
    wire STALL_DQID;           //signal from DQ telling ID to stall
    //Decode Queue (DQ)
    DQ DQ(
        .CLK(CLK),
        .RESET(RESET),
        .SYS(SYS),
        .STALL_IN_IF(STALL_IFDQ),
        .STALL_IN_ID(STALL_IDDQ),
        .Instr_IN(Instr_IFDQ),
        .Instr_PC_IN(Instr_PC_IFDQ),
        .Instr_OUT(Instr_DQID),
        .Instr_PC_OUT(Instr_PC_DQID),
        .STALL_OUT_IF(STALL_DQIF),
        .STALL_OUT_ID(STALL_DQID)
        );

    //wires out of ID
    wire [31:0] Instr_IDRQ;
    wire [31:0] Instr_PC_IDRQ;
    wire [5:0] opcode_IDRQ;
    wire [4:0] rs_IDRQ;
    wire [4:0] rt_IDRQ;
    wire [4:0] rd_IDRQ;
    wire [4:0] shiftAmount_IDRQ;
    wire [5:0] funct_IDRQ;
    wire [15:0] immediate_IDRQ;
    wire [25:0] target_IDRQ;
    wire STALL_IDDQ;
    wire STALL_IDRQ;
    //Instruction Decode (ID)
    ID ID(
        .CLK(CLK),
        .STALL_IN_DQ(STALL_DQID),
        .STALL_IN_RQ(STALL_RQID),
        .Instr_IN(Instr_PC_DQID),
        .Instr_PC_IN(Instr_PC_DQID),
        .Instr_OUT(Instr_IDRQ),
        .Instr_PC_OUT(Instr_PC_IDRQ),
        .opcode_OUT(opcode_IDRQ),
        .rs_OUT(rs_IDRQ),
        .rt_OUT(rt_IDRQ),
        .rd_OUT(rd_IDRQ),
        .shiftAmount_OUT(shiftAmount_IDRQ),
        .funct_OUT(funct_IDRQ),
        .immediate_OUT(immediate_IDRQ),
        .target_OUT(target_IDRQ),
        .STALL_OUT_DQ(STALL_IDDQ),
        .STALL_OUT_RQ(STALL_IDRQ)
        );

    //wires out of RQ
    wire [31:0] Instr_RQIQ;
    wire [31:0] Instr_PC_RQIQ;
    wire [5:0] opcode_RQIQ;
    wire [4:0] rs_RQFRAT;
    wire [4:0] rt_RQFRAT;
    wire [4:0] rd_RQFRAT;
    wire [4:0] shiftAmount_RQIQ;
    wire [5:0] funct_RQIQ;
    wire [15:0] immediate_RQIQ;
    wire [25:0] target_RQIQ;
    wire STALL_RQID;
    wire STALL_RQIQ; //also goes to the FRAT
    //Rename Queue (RQ)
    RQ RQ(
        .CLK(CLK),
        .RESET(RESET),
        .SYS(SYS),
        .STALL_IN_ID(STALL_IDRQ),
        .STALL_IN_IQ(STALL_IQRQ),
        .Instr_IN(Instr_IDRQ),
        .Instr_PC_IN(Instr_PC_IDRQ),
        .opcode_IN(opcode_IDRQ),
        .rs_IN(rs_IDRQ),
        .rt_IN(rt_IDRQ),
        .rd_IN(rd_IDRQ),
        .shiftAmount_IN(shiftAmount_IDRQ),
        .funct_IN(funct_IDRQ),
        .immediate_IN(immediate_IDRQ),
        .target_IN(target_IDRQ),
        .Instr_OUT(Instr_RQIQ),
        .Instr_PC_OUT(Instr_PC_RQIQ),
        .opcode_OUT(opcode_RQIQ),
        .rs_OUT(rs_RQFRAT),
        .rt_OUT(rt_RQFRAT),
        .rd_OUT(rd_RQFRAT),
        .shiftAmount_OUT(shiftAmount_RQIQ),
        .funct_OUT(funct_RQIQ),
        .immediate_OUT(immediate_RQIQ),
        .target_OUT(target_RQIQ),
        .STALL_OUT_ID(STALL_RQID),
        .STALL_OUT_IQ(STALL_RQIQ)
        );

    //wires out of IQ
    wire STALL_IQRQ;
endmodule
