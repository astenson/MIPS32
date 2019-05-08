/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: FRAT, register alias table for renaming before the IQ
Last Updated: February 13, 2019
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
    input [5:0] opcode_IN,
    input [5:0] RegID_IN_FreeList,
    input [203:0] backup_IN_RRAT, //for 34 architectural registers, adjust if needed
    output reg [5:0] rs_OUT,
    output reg [5:0] rt_OUT,
    output reg [5:0] rd_OUT,
    output wire STALL_OUT_FreeList,
    output reg Shift_FreeList
    );

    or(STALL_OUT_FreeList, STALL_IN_RQ, STALL_IN_IQ);

    reg [5:0] FRAT_table [33:0];

    always @(posedge CLK or posedge RESET or posedge SYS) begin
        if (!RESET) begin
            if (!STALL_OUT_FreeList) begin
                if (opcode_IN == 6'b000000) begin //R-type instruction
                    rs_OUT <= FRAT_table[rs_IN];
                    rt_OUT <= FRAT_table[rt_IN];
                    rd_OUT <= RegID_IN_FreeList;
                    FRAT_table[rd_IN] <= RegID_IN_FreeList;
                    Shift_FreeList <= 1'b1;
                end else if (opcode_IN == 6'b000010) begin
                    rs_OUT <= 6'b000000;
                    rt_OUT <= 6'b000000;
                    rd_OUT <= 6'b000000;
                end else if (opcode_IN == 6'b000011) begin
                    rs_OUT <= 6'b000000;
                    rt_OUT <= 6'b000000;
                    rd_OUT <= 6'b000000;
                end else begin //I-type instruction
                    rs_OUT <= FRAT_table[rs_IN];
                    rt_OUT <= FRAT_table[rs_IN];
                    rd_OUT <= RegID_IN_FreeList;
                    FRAT_table[rt_IN] <= RegID_IN_FreeList;
                    Shift_FreeList <= 1'b1;
                end
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
            FRAT_table[15] <= backup_IN_RRAT[95:90];
            FRAT_table[16] <= backup_IN_RRAT[101:96];
            FRAT_table[17] <= backup_IN_RRAT[107:102];
            FRAT_table[18] <= backup_IN_RRAT[113:108];
            FRAT_table[19] <= backup_IN_RRAT[119:114];
            FRAT_table[20] <= backup_IN_RRAT[125:120];
            FRAT_table[21] <= backup_IN_RRAT[131:126];
            FRAT_table[22] <= backup_IN_RRAT[137:132];
            FRAT_table[23] <= backup_IN_RRAT[143:138];
            FRAT_table[24] <= backup_IN_RRAT[149:144];
            FRAT_table[25] <= backup_IN_RRAT[155:150];
            FRAT_table[26] <= backup_IN_RRAT[161:156];
            FRAT_table[27] <= backup_IN_RRAT[167:162];
            FRAT_table[28] <= backup_IN_RRAT[173:168];
            FRAT_table[29] <= backup_IN_RRAT[179:174];
            FRAT_table[30] <= backup_IN_RRAT[185:180];
            FRAT_table[31] <= backup_IN_RRAT[191:186];
            FRAT_table[32] <= backup_IN_RRAT[197:192];
            FRAT_table[33] <= backup_IN_RRAT[203:198];
        end
    end

    always @(negedge CLK) begin
        Shift_FreeList <= 0;
    end

endmodule
