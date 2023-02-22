`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 19:46:41
// Module Name: Mem
//////////////////////////////////////////////////////////////////////////////////

//256*8B Memory

module Mem(
        input [63:0] A,
        input [63:0] In,
        input MemWE,
        input clk,
        output [63:0] Out
    );
    
    reg [63:0] mem [0:255];
    wire [7:0] addr;
    assign addr = A[10:3];
    
    always @ (posedge clk) begin
    if(MemWE)
        mem[addr] <= In;
    end
    
    assign Out = mem[addr];
    
endmodule
