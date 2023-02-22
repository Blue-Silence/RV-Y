`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 19:09:59
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] funct3,
    input [6:0] funct7,
    input signed [63:0] SrcA,
    input signed [63:0] SrcB,
    output [63:0] Result
    );
    
    assign Result = (funct3 == 3'b000) ? ((funct7 == 7'b0100000) ? SrcA-SrcB : SrcA+SrcB) :
                    (funct3 == 3'b001) ? SrcA << SrcB[4:0] :
                    (funct3 == 3'b010) ? {63'b0,(SrcA<SrcB)} :
                    (funct3 == 3'b011) ? {63'b0,({1'b0,SrcA}<{1'b0,SrcB})}:
                    (funct3 == 3'b100) ? SrcA^SrcB :
                    (funct3 == 3'b101) ? ((funct7 == 7'b0100000) ? SrcA>>>SrcB[4:0] : SrcA>>SrcB[4:0]) :
                    (funct3 == 3'b110) ? SrcA|SrcB :
                    (funct3 == 3'b111) ? SrcA&SrcB :
                    1'bx;
endmodule
