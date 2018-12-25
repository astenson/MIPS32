/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: comparator test bench
Last Updated: December 23, 2018
*******************************************************************************/

`include "comparator.v"

module tb_comparator();

    reg [5:0] A;
    reg [5:0] B;
    wire results;

    comparator comparator(
        .A(A),
        .B(B),
        .result(result)
    );

    initial begin
        $monitor("A=%b, B=%b, result=%b", A, B, result);
        //Test 1
        A = 6'b000001;
        B = 6'b000010;
        //Test 2
        #1 A = 6'b000010;
        $finish;
    end

endmodule
