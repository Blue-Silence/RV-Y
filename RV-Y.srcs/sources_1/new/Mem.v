`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 19:46:41
// Design Name: 
// Module Name: Mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//256*8B Memory

module Mem(
        input [63:0] A,
        input [63:0] In,
        input MemWE,
        input clk,
        output Out
    );
    
    reg [63:0] mem [0:255];
    wire [7:0] addr;
    assign addr = A[13:6];
    
    always @ (posedge clk) begin
    if(MemWE)
        mem[addr] <= In;
    end
    
    assign Out = mem[addr];
    
endmodule
