/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: 4 input arbiter, any tree level except the base
Last Updated: December 22, 2018
*******************************************************************************/

module arbiter(
    input [3:0] requests_IN,
    input group_grant_IN,
    output wire [3:0] grants_OUT,
    output wire group_request_OUT
    );

    or(group_request_OUT, requests_IN[0], requests_IN[1], requests_IN[2], requests_IN[3]);
    and(grants_OUT[3], group_grant_IN, requests_IN[3]);
    and(grants_OUT[2], group_grant_IN, !requests_IN[3], requests_IN[2]);
    and(grants_OUT[1], group_grant_IN, !requests_IN[3], !requests_IN[2], requests_IN[1]);
    and(grants_OUT[0], group_grant_IN, !requests_IN[3], !requests_IN[2], !requests_IN[1], requests_IN[0]);
endmodule
