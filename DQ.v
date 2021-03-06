/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: Decode Queue, 8-entry FIFO
Last Updated: December 21, 2018
*******************************************************************************/

module DQ(
    input CLK,                      //clock signal
    input RESET,                    //reset signal, means that the queue needs to be flushed
    input SYS,                      //syscall, means that the queue needs to be flushed
    input STALL_IN_IF,              //IF is telling DQ to stall
    input STALL_IN_ID,              //ID is telling DQ to stall
    input [31:0] Instr_IN,          //instruction passed from IF
    input [31:0] Instr_PC_IN,       //instruction PC passed from IF
    output reg [31:0] Instr_OUT,    //instruction passed to ID
    output reg [31:0] Instr_PC_OUT, //instruction PC passed to ID
    output wire STALL_OUT_IF,       //signal to IF to stall
    output wire STALL_OUT_ID        //signal to ID to stall
    );

    wire flush;      //internal flag if the queue needs to be flushed
    or(flush, RESET, SYS); //if any external flush flags are raised, then flush

    //Stall the IF stage if the Decode Queue is full
    and(STALL_OUT_IF, reg_fifo[0][64], reg_fifo[1][64], reg_fifo[2][64], reg_fifo[3][64], reg_fifo[4][64], reg_fifo[5][64], reg_fifo[6][64], reg_fifo[7][64]);

    //Stall the ID stage if the Decode Queue is empty
    nor(STALL_OUT_ID, reg_fifo[0][64], reg_fifo[1][64], reg_fifo[2][64], reg_fifo[3][64], reg_fifo[4][64], reg_fifo[5][64], reg_fifo[6][64], reg_fifo[7][64]);

    //Only accept new inputs if the queue isn't full and there is no stall signal from IF
    wire accept_input;
    nor(accept_input, STALL_OUT_IF, STALL_IN_IF);

    //only write out data if the queue isn't empty and there is no stall signal from ID
    wire write_output;
    nor(write_output, STALL_OUT_ID, STALL_IN_ID);

    reg [2:0] head_ptr;
    reg [2:0] tail_ptr;
    reg [64:0] reg_fifo [7:0];
    //bit 64: is the entry full or empty
    //bits 63-32: instruction
    //bits 31-0: instruction PC

    initial begin
        head_ptr <= 3'b000;
        tail_ptr <= 3'b000;
    end

    always @(posedge CLK or posedge RESET or posedge SYS) begin
        if (!flush) begin
            if (accept_input) begin
                $display("The DQ is accepting Instruction 0x%x, with PC 0x%x, from IF.", Instr_IN, Instr_PC_IN);
                reg_fifo[tail_ptr][64] <= 1'b1;
                reg_fifo[tail_ptr][63:32] <= Instr_IN;
                reg_fifo[tail_ptr][31:0] <= Instr_PC_IN;
                tail_ptr <= tail_ptr + 1;
            end else begin
                if (!STALL_IN_IF) begin
                    $display("The DQ is not accepting new data because it is full.");
                end else if (!STALL_OUT_IF) begin
                    $display("The DQ is not accepting new data because IF is stalled.");
                end else begin
                    $display("The DQ is not accepting new data because it is full and IF is stalled.");
                end
            end
            if (write_output) begin
                Instr_OUT <= reg_fifo[head_ptr][63:32];
                Instr_PC_OUT <= reg_fifo[head_ptr][31:0];
                reg_fifo[head_ptr][64] <= 1'b0;
                head_ptr <= head_ptr + 1;
                $display("The DQ is sending Instruction 0x%x, with PC 0x%x, to ID.", Instr_OUT, Instr_PC_OUT);
            end else begin
                if (!STALL_IN_ID) begin
                    $display("The DQ is not sending out data because it is empty.");
                end else if (!STALL_OUT_ID) begin
                    $display("The DQ is not sending out data because ID is stalled.");
                end else begin
                    $display("The DQ is not sending out data because it is empty and ID is stalled.");
                end
            end
        end else begin
            $display("The DQ received a flush signal and is resetting the queue.");
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
