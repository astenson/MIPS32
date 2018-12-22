/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: MIPS, overall pipeline connecting individual component blocks
Last Updated: December 21, 2018
*******************************************************************************/

`include "DQ.v"

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
  wire STALL_IDDQ; //signal from ID telling DQ to stall

endmodule
