/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: FRAT, return alias table for renaming before the IQ
Last Updated: December 23, 2018
*******************************************************************************/

module FRAT(
    input CLK,
    input RESET,
    input SYS,
    input STALL_IN_RQ,
    input STALL_IN_IQ,
    input [4:0] rs_IN,
    input [4:0] rt_IN,
    input [4:0] rd_IN,
    input [5:0] RegID_IN_FreeList,
    input [203:0] backup_IN_RRAT, //for 34 architectural registers, adjust if needed
    output reg [5:0] rs_OUT,
    output reg [5:0] rt_OUT,
    output reg [5:0] rd_OUT,
    output wire STALL_OUT_FreeList
    );

    or(STALL_OUT_FreeList, STALL_IN_RQ, STALL_IN_IQ);

    reg [5:0] FRAT_table [33:0]

    always @(posedge CLK or posedge RESET or posedge SYS) begin
        if (!RESET) begin
            if (!STALL_OUT_FreeList) begin
                //TODO: add logic based on what kind of instruction it is (R, I, J)
            end else begin
                $display("The FRAT will not be renaming registers due to a stall signal.");
            end
        end else begin
            FRAT_table[0] <= backup_IN_RRAT[5:0];
            FRAT_table[1] <= backup_IN_RRAT[11:6];
            FRAT_table[2] <= backup_IN_RRAT[17:12];
            FRAT_table[3] <= backup_IN_RRAT[23:18];
            FRAT_table[4] <= backup_IN_RRAT[29:24];
            FRAT_table[5] <= backup_IN_RRAT[35:30];
            FRAT_table[6] <= backup_IN_RRAT[41:36];
            FRAT_table[7] <= backup_IN_RRAT[47:42];
            FRAT_table[8] <= backup_IN_RRAT[53:48];
            FRAT_table[9] <= backup_IN_RRAT[59:54];
            FRAT_table[10] <= backup_IN_RRAT[65:60];
            FRAT_table[11] <= backup_IN_RRAT[71:66];
            FRAT_table[12] <= backup_IN_RRAT[77:72];
            FRAT_table[13] <= backup_IN_RRAT[83:78];
            FRAT_table[14] <= backup_IN_RRAT[89:84];
            FRAT_table[15] <=
        end
    end

endmodule
