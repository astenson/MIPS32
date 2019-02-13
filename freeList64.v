/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: 64 entry free list for register renaming
Last Updated: February 13, 2019
*******************************************************************************/

module freeList64(
    input RESET,
    input SYS,
    input enable_IN_FRAT,
    input enable_IN_RRAT,
    input [5:0] RegID_IN_RRAT,
    output wire [5:0] free_register
    );

    reg [6:0] freeList [63:0];
    reg loop_break;
    integer i;

    assign free_register = freeList[0][5:0];

    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            freeList[i][6] <= 1'b1;
            freeList[i][5:0] <= i;
        end
    end

    always @(posedge enable_IN_FRAT) begin
        for (i = 0; i < 64; i = i + 1) begin
            if (i == 63) begin
                freeList[i] <= 7'b0000000;
            end else begin
                freeList[i] <= freeList[i+1];
            end
        end
    end

    always @(posedge enable_IN_RRAT) begin
        for (i = 0; i < 64; i = i + 1) begin
            if (!loop_break) begin
                if (freeList[i][6] == 1'b0) begin
                    freeList[i][6] <= 1'b1;
                    freeList[i][5:0] <= RegID_IN_RRAT;
                    loop_break <= 1'b1;
                end
            end
        end
    end

    always @(negedge enable_IN_RRAT) begin
        loop_break <= 1'b0;
    end

    always @(posedge RESET or posedge SYS) begin
        for (i = 0; i < 64; i = i + 1) begin
            freeList[i][6] <= 1'b1;
            freeList[i][5:0] <= i;
        end
    end

endmodule
