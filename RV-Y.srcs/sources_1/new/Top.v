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
    wire [63:0] branchRd;
    
    
    //MemAccessUnit
    wire memRegE;
    wire memWE;
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
    
    //Control
    wire [2:0] instrType;
    wire [1:0] instrFlowType;
    
    
    Control ctrl (  
                    .opcode(),
                    .funct7(),
                    .funct3(),
                    .instrType(instrType),
                    .instrFlowType(instrFlowType)
                );
    
    
    wire [63:0] immI,immS,immB,immU,immJ;
    ImmConstr immModle (instr,immI,immS,immB,immU,immJ);
    assign imm = (instrType == 3'b001) ? immI : 
                 (instrType == 3'b010) ? immS : 
                 (instrType == 3'b011) ? immB :
                 (instrType == 3'b100) ? immU :
                 (instrType == 3'b101) ? immJ :
                 64'bx;

    BranchUnit BU (
                    .bT(instrFlowType),
                    .funct3(),
                    .clk(clk),
                    .offset(imm),
                    .SrcA(regOutA),
                    .SrcB(regOutB),
                    .pc(pc),
                    .rd(branchRd)
                );

    ALU aluM (
                    .funct3(funct3),
                    .funct7(funct7),
                    .SrcA(aluInA),
                    .SrcB(aluInB),
                    .Result(aluResult)
                    );

    MemAccessUnit MAU (
                    .offset(imm),
                    .regE(memRegE),
                    .regVal(regOutA),
                    .In(memIn),
                    .MemWE(memWE),
                    .clk(clk),
                    .Out(memOut)
                    );

    InstrFetchUnit IFU (
                    .pc(pc),
                    .clk(clk),
                    .instr(instr)
                    );

endmodule
