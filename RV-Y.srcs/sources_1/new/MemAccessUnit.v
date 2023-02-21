`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 20:36:31
// Design Name: 
// Module Name: MemAccessUnit
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


module MemAccessUnit(
        input [63:0] offset,
        input regE,
        input [63:0] regVal,
        input [63:0] In,
        input MemWE,
        input clk,
        output [63:0] Out
    );
    
    wire addr;
    assign addr = ((regE) ? regVal : 0)+offset;
    
    Mem dmem (addr, In, MemWE, clk,Out);

endmodule
