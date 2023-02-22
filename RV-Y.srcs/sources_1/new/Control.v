`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 16:00:21
// Design Name: 
// Module Name: Control
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


module Control(
            input [6:0] opcode,
            input [6:0] funct7,
            input [2:0] funct3,
            
            output [2:0] instrType, //000:R ; 001:I ; 010:S ; 011:B ; 100:U ; 101:J
            
            output [1:0] instrFlowType, //00:no branch; 01:jl; 11:jlr
            
            output memWE,
            output memRegE,
            
            output [1:0] resultType, //00:ALU; 01:Mem; 10:pc; 11: no result
            output [1:0] dstType //00:rd, others : disable  
    );
    //Undefined.

endmodule