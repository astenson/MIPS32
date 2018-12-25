/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: comparator, compare two 6-bit numbers
Last Updated: December 23, 2018
*******************************************************************************/

module comparator(
    input [5:0] A,
    input [5:0] B,
    output wire result
    );

    wire [5:0] xor_out;
    xor(xor_out[5], A[5], B[5]);
    xor(xor_out[4], A[4], B[4]);
    xor(xor_out[3], A[3], B[3]);
    xor(xor_out[2], A[2], B[2]);
    xor(xor_out[1], A[1], B[1]);
    xor(xor_out[0], A[0], B[0]);
    nor(result, xor_out);
endmodule
