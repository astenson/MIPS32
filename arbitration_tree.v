/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: 4 redux arbitration tree
Last Updated: December 22, 2018
*******************************************************************************/

`include "arbiter.v"
`include "base_arbiter.v"

module arbitration_tree(
    input [15:0] requests_IN,
    output wire [15:0] grants_OUT
    );

    wire [3:0] requests_to_base;
    wire [3:0] grants_from_base;

    arbiter arbiter3(
        .requests_IN(requests_IN[15:12]),
        .group_grant_IN(grants_from_base[3]),
        .grants_OUT(grants_OUT[15:12]),
        .group_request_OUT(requests_to_base[3])
        );

    arbiter arbiter2(
        .requests_IN(requests_IN[11:8]),
        .group_grant_IN(grants_from_base[2]),
        .grants_OUT(grants_OUT[11:8]),
        .group_request_OUT(requests_to_base[2])
        );

    arbiter arbiter1(
        .requests_IN(requests_IN[7:4]),
        .group_grant_IN(grants_from_base[2]),
        .grants_OUT(grants_OUT[7:4]),
        .group_request_OUT(requests_to_base[2])
        );

    arbiter arbiter0(
        .requests_IN(requests_IN[3:0]),
        .group_grant_IN(grants_from_base[0]),
        .grants_OUT(grants_OUT[3:0]),
        .group_request_OUT(requests_to_base[0])
        );

    base_arbiter base_arbiter(
        .requests_IN(requests_to_base),
        .grants_OUT(grants_from_base)
        );

endmodule
