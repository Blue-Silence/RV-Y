`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 21:52:01
// Design Name: 
// Module Name: Top
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


module Top(
    input clk
    );
    
    //All
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [63:0] imm;
    
    //ALU
    wire [63:0] aluInA;
    wire [63:0] aluInB;
    wire [63:0] aluResult;
    
    //BranchUnit
    wire [63:0] branchInA;
    wire [63:0] branchInB;
    wire [1:0] branchType;
    wire [63:0] pc;
    
    
    //MemAccessUnit
    wire memRegE;
    wire [63:0] memIn;
    wire [63:0] memOut;
    
    //InstrFetchUnit
    wire [31:0] instr;
    
    //RegFile
    wire [4:0] regSrcA;
    wire [4:0] regSrcB;
    wire [4:0] regDst;
    wire [63:0] regOutA;
    wire [63:0] regOutB;
    wire [63:0] regIn;
    wire regWE;
    
    
    wire [63:0] immI,immS,immB,immU,immJ;
    ImmConstr immModle (instr,immI,immS,immB,immU,immJ);
    
endmodule
