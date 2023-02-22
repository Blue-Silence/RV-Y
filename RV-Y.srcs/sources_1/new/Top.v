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
    wire [4:0] rd;
    wire [4:0] regSrcA;
    wire [4:0] regSrcB;
    
    //ALU
    wire [63:0] aluInA;
    wire [63:0] aluInB;
    wire [63:0] aluResult;
    
    //BranchUnit
    wire [63:0] branchInA;
    wire [63:0] branchInB;
    wire [1:0] branchType;
    wire [63:0] pc;
    wire [63:0] branchR;
    
    
    //MemAccessUnit
    wire memRegE;
    wire memWE;
    wire [63:0] memIn;
    wire [63:0] memOut;
    
    //InstrFetchUnit
    wire [31:0] instr;
    
    //RegFile
    wire [63:0] regOutA;
    wire [63:0] regOutB;
    wire [63:0] regIn;
    wire regWE;
    
    //Control
    wire [2:0] instrType;
    wire [1:0] instrFlowType;
    wire [1:0] resultType;
    wire [1:0] dstType;
    wire aluImmE;
    
//////////////////////////////////////////////
//Instruction decode
    assign regSrcA = instr[19:15];
    assign regSrcA = instr[24:20];
    assign funct7 = instr[31:25];
    assign funct3 = instr[14:12];
    assign rd = instr[11:7];
    
    wire [63:0] immI,immS,immB,immU,immJ;
    ImmConstr immModle (instr,immI,immS,immB,immU,immJ);
    assign imm = (instrType == 3'b001) ? immI : 
                 (instrType == 3'b010) ? immS : 
                 (instrType == 3'b011) ? immB :
                 (instrType == 3'b100) ? immU :
                 (instrType == 3'b101) ? immJ :
                 64'bx;

//////////////////////////////////////////////////

    Control ctrl (  
                    .opcode(),
                    .funct7(),
                    .funct3(),
                    
                    .instrType(instrType),
                    .instrFlowType(instrFlowType),
                    
                    .memWE(memWE),
                    .memRegE(memRegE),
                    
                    .dstType(dstType),
                    .resultType(resultType),
                    
                    .aluImmE(aluImmE)
                
                );


    BranchUnit BU (
                    .bT(instrFlowType),
                    .funct3(funct3),
                    .clk(clk),
                    .offset(imm),
                    .SrcA(regOutA),
                    .SrcB(regOutB),
                    .pc(pc),
                    .rd(branchR)
                );
//////////////////////////////////////////////////////////////////

    assign aluInA = regOutA;
    assign aluInB = (aluImmE) ? imm : regOutB;

    ALU aluM (
                    .funct3(funct3),
                    .funct7(funct7),
                    .SrcA(aluInA),
                    .SrcB(aluInB),
                    .Result(aluResult)
                    );
                    
///////////////////////////////////////////////////////////////////
    
    assign memIn = regOutB; //Need to modified to meet word type;
    
    MemAccessUnit MAU (
                    .offset(imm),
                    .regE(memRegE),
                    .regVal(regOutA),
                    .In(memIn),
                    .MemWE(memWE),
                    .clk(clk),
                    .Out(memOut)
                    );
///////////////////////////////////////////////////////////////////
    InstrFetchUnit IFU (
                    .pc(pc),
                    .clk(clk),
                    .instr(instr)
                    );
///////////////////////////////////////////////////////////////////
    
    assign regIn = (resultType == 2'b00) ? aluResult :
                   (resultType == 2'b10) ? branchR : 
                   (resultType == 2'b01) ? memOut :
                   imm;
                   
    RegFile RF(
                    .srcA(regSrcA),
                    .srcB(regSrcb),
                    .dst(rd),
                    .in(regIn),
                    .regWE(regWE),
                    .clk(clk),
                    .a(regOutA),
                    .b(regOutB)
    );

endmodule
