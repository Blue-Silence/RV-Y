`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 21:02:43
// Design Name: 
// Module Name: InstrFetchUnit
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


module InstrFetchUnit(
        input [63:0] pc,
        input clk,
        output [31:0] instr
    );
    
    Mem imem (pc, 1'b0, 1'b0, clk, instr);

endmodule
