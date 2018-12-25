/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: 4 input arbiter, specifically the base arbiter
Last Updated: December 22, 2018
*******************************************************************************/

module base_arbiter(
    input [3:0] requests_IN,
    output wire [3:0] grants_OUT
    );

    assign grants_OUT[3] = requests_IN[3];
    and(grants_OUT[2], !requests_IN[3], requests_IN[2]);
    and(grants_OUT[1], !requests_IN[3], !requests_IN[2], requests_IN[1]);
    and(grants_OUT[0], !requests_IN[3], !requests_IN[2], !requests_IN[1], requests_IN[0]);
endmodule
