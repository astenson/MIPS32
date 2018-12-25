/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: Rename Queue, 8-entry FIFO
Last Updated: December 22, 2018
*******************************************************************************/

module RQ(
    input CLK,
    input RESET,
    input SYS,
    input STALL_IN_ID,
    input STALL_IN_IQ,
    input [31:0] Instr_IN,
    input [31:0] Instr_PC_IN,
    input [5:0] opcode_IN,
    input [4:0] rs_IN,
    input [4:0] rt_IN,
    input [4:0] rd_IN,
    input [4:0] shiftAmount_IN,
    input [5:0] funct_IN,
    input [15:0] immediate_IN,
    input [25:0] target_IN,
    output reg [31:0] Instr_OUT,
    output reg [31:0] Instr_PC_OUT,
    output reg [5:0] opcode_OUT,
    output reg [4:0] rs_OUT,
    output reg [4:0] rt_OUT,
    output reg [4:0] rd_OUT,
    output reg [4:0] shiftAmount_OUT,
    output reg [5:0] funct_OUT,
    output reg [15:0] immediate_OUT,
    output reg [25:0] target_OUT,
    output wire STALL_OUT_ID,
    output wire STALL_OUT_IQ
    );

    wire flush;
    or(flush, RESET, SYS);

    and(STALL_OUT_ID, reg_fifo[0][138], reg_fifo[1][138], reg_fifo[2][138], reg_fifo[3][138], reg_fifo[4][138], reg_fifo[5][138], reg_fifo[6][138], reg_fifo[7][138]);

    nor(STALL_OUT_IQ, reg_fifo[0][138], reg_fifo[1][138], reg_fifo[2][138], reg_fifo[3][138], reg_fifo[4][138], reg_fifo[5][138], reg_fifo[6][138], reg_fifo[7][138]);

    wire accept_input;
    nor(accept_input, STALL_OUT_ID, STALL_IN_ID);

    wire write_output;
    nor(write_output, STALL_OUT_IQ, STALL_IN_IQ);

    reg [2:0] head_ptr;
    reg [2:0] tail_ptr;
    reg [138:0] reg_fifo [7:0];
    //138: 1 if the entry is full, 0 if empty
    //137-106: instruction
    //105-74: instruction PC
    //73-68: opcode
    //67-63: rs
    //62-58: rt
    //57-53: rd
    //52:48: shift amount
    //47-42: funct
    //41-26: immediate
    //25-0: jump target

    initial begin
        head_ptr <= 3'b000;
        tail_ptr <= 3'b000;
    end

    always @(posedge CLK or posedge RESET or posedge SYS) begin
        if (!flush) begin
            if (accept_input) begin
                $display("The RQ is accepting Instruction 0x%x, with PC 0x%x, from ID.", Instr_IN, Instr_PC_IN);
                reg_fifo[tail_ptr][138] <= 1'b1;
                reg_fifo[tail_ptr][137:106] <= Instr_IN;
                reg_fifo[tail_ptr][105:74] <= Instr_PC_IN;
                reg_fifo[tail_ptr][73:68] <= opcode_IN;
                reg_fifo[tail_ptr][67:63] <= rs_IN;
                reg_fifo[tail_ptr][62:58] <= rt_IN;
                reg_fifo[tail_ptr][57:53] <= rd_IN;
                reg_fifo[tail_ptr][52:48] <= shiftAmount_IN;
                reg_fifo[tail_ptr][47:42] <= funct_IN;
                reg_fifo[tail_ptr][41:26] <= immediate_IN;
                reg_fifo[tail_ptr][25:0] <= target_IN;
                tail_ptr <= tail_ptr + 1;
            end else begin
                if (!STALL_IN_ID) begin
                    $display("The RQ is not accepting new data because it is full.");
                end else if (!STALL_OUT_ID) begin
                    $display("The RQ is not accepting new data because ID is stalled.");
                end else begin
                    $display("The RQ is not accepting new data because it is full and ID is stalled.");
                end
            end
            if (write_output) begin
                Instr_OUT <= reg_fifo[head_ptr][137:106];
                Instr_PC_OUT <= reg_fifo[head_ptr][105:74];
                opcode_OUT <= reg_fifo[head_ptr][73:68];
                rs_OUT <= reg_fifo[head_ptr][67:63];
                rt_OUT <= reg_fifo[head_ptr][62:58];
                rd_OUT <= reg_fifo[head_ptr][57:53];
                shiftAmount_OUT <= reg_fifo[head_ptr][52:48];
                funct_OUT <= reg_fifo[head_ptr][47:42];
                immediate_OUT <= reg_fifo[head_ptr][41:26];
                target_OUT <= reg_fifo[head_ptr][25:0];
                head_ptr <= head_ptr + 1;
                $display("The RQ is sending Instruction 0x%x, with PC 0x$x, to IQ.", Instr_OUT, Instr_PC_OUT);
            end else begin
                if (!STALL_IN_IQ) begin
                    $display("The RQ is not sending out data because it is empty.");
                end else if (!STALL_OUT_IQ) begin
                    $display("The RQ is not sending out data because IQ is stalled.");
                end else begin
                    $display("The RQ is not sending out data because it is empty and IQ is stalled.");
                end
            end
        end else begin
            $display("The RQ received a flush signal and is resetting the queue.");
            reg_fifo[0] <= 0;
            reg_fifo[1] <= 0;
            reg_fifo[2] <= 0;
            reg_fifo[3] <= 0;
            reg_fifo[4] <= 0;
            reg_fifo[5] <= 0;
            reg_fifo[6] <= 0;
            reg_fifo[7] <= 0;
        end
    end

endmodule
