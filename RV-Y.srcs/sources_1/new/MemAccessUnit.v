`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 20:36:31
// Module Name: MemAccessUnit
//////////////////////////////////////////////////////////////////////////////////


module MemAccessUnit(
        input [63:0] offset,
        input regE,
        input [63:0] regVal,
        input [63:0] In,
        input MemWE,
        input clk,
        output [63:0] Out
    );
    
    wire [63:0] addr;
    assign addr = ((regE) ? regVal : 0)+offset;
    
    Mem dmem (addr, In, MemWE, clk,Out);

endmodule
