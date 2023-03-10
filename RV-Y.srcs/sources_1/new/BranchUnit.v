`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2023/02/21 21:18:01
// Module Name: BranchUnit
//////////////////////////////////////////////////////////////////////////////////


module BranchUnit(
    input reset,
    input [1:0] bT,//some signal. 00:no branch; 01:jl; 10:conditional;  11:jlr
    input [2:0] funct3,
    input clk,
    input [63:0] offset,
    input signed [63:0] SrcA,
    input signed [63:0] SrcB,
    output reg [63:0] pc,
    output [63:0] rd
    );
    
    assign rd = pc+4;
    
    wire condition;
    assign condition = (funct3 == 3'b000) ? (SrcA == SrcB) :
                       (funct3 == 3'b001) ? (SrcA != SrcB) : 
                       (funct3 == 3'b100) ? (SrcA < SrcB) :
                       (funct3 == 3'b101) ? (SrcA >= SrcB) :     
                       (funct3 == 3'b110) ? ({1'b0,SrcA} < {1'b0,SrcB}) :    
                       (funct3 == 3'b111) ? ({1'b0,SrcA} >= {1'b0,SrcB}) :
                       1'bx;
                       
    always @ (posedge clk,posedge reset) begin
        if (reset)
            pc <= 0;
        else if((bT == 2'b10 && condition) || bT == 2'b01)
            pc <= pc+4+offset;
        else if (bT == 2'b11)
            pc <= pc+4+SrcA;
        else 
            pc <= pc+4;
     end
     
endmodule
