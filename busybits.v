/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: busybits
Last Updated: February 13, 2019
*******************************************************************************/


module busybits(
    input RESET,
    input SYS,
    input [5:0] rs_IN,
    input [5:0] rt_IN,
    input [5:0] RegID_IN_IQ,
    input enable_IN_IQ,
    input [5:0] RegID_IN_RRAT,
    input enable_IN_RRAT,
    output wire [5:0] rs_OUT,
    output wire [5:0] rt_OUT,
    output wire rs_busy,
    output wire rt_busy
    );

    reg [33:0] busybits;

    assign rs_OUT = rs_IN;
    assign rt_OUT = rt_IN;
    assign rs_busy = busybits[rs_IN];
    assign rt_busy = busybits[rt_IN];

    always @(posedge enable_IN_IQ) begin
        busybits[RegID_IN_IQ] <= 1'b1;
    end

    always @(posedge enable_IN_RRAT) begin
        busybits[RegID_IN_RRAT] <= 1'b0;
    end

    always @(posedge RESET or posedge SYS) begin
        busybits[0] <= 1'b0;
        busybits[1] <= 1'b0;
        busybits[2] <= 1'b0;
        busybits[3] <= 1'b0;
        busybits[4] <= 1'b0;
        busybits[5] <= 1'b0;
        busybits[6] <= 1'b0;
        busybits[7] <= 1'b0;
        busybits[8] <= 1'b0;
        busybits[9] <= 1'b0;
        busybits[10] <= 1'b0;
        busybits[11] <= 1'b0;
        busybits[12] <= 1'b0;
        busybits[13] <= 1'b0;
        busybits[14] <= 1'b0;
        busybits[15] <= 1'b0;
        busybits[16] <= 1'b0;
        busybits[17] <= 1'b0;
        busybits[18] <= 1'b0;
        busybits[19] <= 1'b0;
        busybits[20] <= 1'b0;
        busybits[21] <= 1'b0;
        busybits[22] <= 1'b0;
        busybits[23] <= 1'b0;
        busybits[24] <= 1'b0;
        busybits[25] <= 1'b0;
        busybits[26] <= 1'b0;
        busybits[27] <= 1'b0;
        busybits[28] <= 1'b0;
        busybits[29] <= 1'b0;
        busybits[30] <= 1'b0;
        busybits[31] <= 1'b0;
        busybits[32] <= 1'b0;
        busybits[33] <= 1'b0;
    end
endmodule
