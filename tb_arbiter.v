/*******************************************************************************
Project: 32-bit Out of Order MIPS Processor
Author: Adam Stenson
Module: arbiter test bench
Last Updated: December 23, 2018
*******************************************************************************/

`include "arbiter.v"

module tb_arbiter();

    reg [3:0] tb_requests;
    wire [3:0] tb_grants;
    reg tb_groupGrant;
    wire tb_groupRequest;

    arbiter arbiter(
        .requests_IN(tb_requests),
        .grants_OUT(tb_grants),
        .group_grant_IN(tb_groupGrant),
        .group_request_OUT(tb_groupRequest)
    );

    initial begin
        //Set up monitoring
        $monitor("requests=%b, groupRequest=%b, groupGrant=%b, grants=%b", tb_requests, tb_groupRequest, tb_groupGrant, tb_grants);
        //Test 1
        tb_requests = 4'b0001;
        tb_groupGrant = 1'b1;
        //Test 2
        #1 tb_requests = 4'b1001;
        //Test 3
        #1 tb_requests = 4'b0011;
        //Test 4
        #1 tb_requests = 4'b0110;
        //Test 5
        #1 tb_requests = 4'b0000;
        //Test 6
        #1 tb_requests = 4'b1111;
        tb_groupGrant = 1'b0;
        $finish;
    end

endmodule
